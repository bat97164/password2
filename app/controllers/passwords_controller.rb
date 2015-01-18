class PasswordsController < ApplicationController
  # GET /passwords/1
  # GET /passwords/1.json
  def show
    if params.has_key?(:id)
      @password = Password.find_by_url_token!(params[:id])
      @password.views = View.where(:password_id => @password.id, :successful => true)
    else
      redirect_to :root
      return
    end

    # This password may have expired since the last view.  Validate the password
    # expiration before doing anything.
    @password.validate!

    unless @password.expired
      # Decrypt the passwords
      @key = EzCrypto::Key.with_password CRYPT_KEY, CRYPT_SALT
      @payload = @key.decrypt64(@password.payload)
    end

    log_view(@password)

    expires_now()

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @password }
    end
  end

  # GET /passwords/new
  # GET /passwords/new.json
  def new
    @password = Password.new

    expires_in 3.hours, :public => true, 'max-stale' => 0

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @password }
    end
  end

  # POST /passwords
  # POST /passwords.json
  def create
    if params[:password][:payload].blank? or params[:password][:payload] == PAYLOAD_INITIAL_TEXT
      redirect_to '/'
      return
    end

    if params[:password][:payload].length > 2000
      redirect_to '/', :error => "That password is too long."
      return
    end

    @password = Password.new()

    @password.expire_after_days = params[:password][:expire_after_days]
    @password.expire_after_views = params[:password][:expire_after_views]

    @password.url_token = rand(36**16).to_s(36)
    @password.user_id = current_user.id if current_user

    # Encrypt the passwords
    @key = EzCrypto::Key.with_password CRYPT_KEY, CRYPT_SALT
    @password.payload = @key.encrypt64(params[:password][:payload])

    @password.validate!

    respond_to do |format|
      if @password.save
        format.html { redirect_to @password, :notice => "The password has been pushed." }
        format.json { render :json => @password, :status => :created }
      else
        format.html { render :action => "new" }
        format.json { render :json => @password.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    if params.has_key?(:id)
      @password = Password.find_by_url_token!(params[:id])
    else
      redirect_to :root
      return
    end

    @password.expired = true
    @password.payload = nil
    @password.deleted = true

    respond_to do |format|
      if @password.save
        format.html { redirect_to @password, :notice => "The password has been deleted." }
        format.json { render :json => @password, :status => :destroyed }
      else
        format.html { render :action => "new" }
        format.json { render :json => @password.errors, :status => :unprocessable_entity }
      end
    end
  end

  private

  ##
  # log_view
  #
  # Record that a view is being made for a password
  #
  def log_view(password)
    view = View.new
    view.password_id = password.id
    view.ip          = request.env["HTTP_X_FORWARDED_FOR"].nil? ? request.env["REMOTE_ADDR"] : request.env["HTTP_X_FORWARDED_FOR"]
    view.user_agent  = request.env["HTTP_USER_AGENT"]
    view.referrer    = request.env["HTTP_REFERER"]
    view.successful  = password.expired ? false : true
    view.save

    password.views << view
    password
  end
end
