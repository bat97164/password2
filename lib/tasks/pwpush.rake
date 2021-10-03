# frozen_string_literal: true

desc 'Run through and expire passwords.'
task :daily_expiration, [:batch_size] => :environment do |_, args|
  unless args.key?(:batch_size)
    puts 'Please specify the batch size. e.g. rails daily_expiration[100]'
    exit
  end

  counter = 0
  expiration_count = 0
  bsize = args[:batch_size].to_i

  Password.where(expired: false)
          .order(:created_at)
          .find_each(batch_size: bsize) do |push|
    counter += 1

    push.validate!
    if push.expired
      puts "#{counter}: Push #{push.url_token} created on #{push.created_at.to_s(:long)} has expired."
      expiration_count += 1
    else
      puts "#{counter}: Push #{push.url_token} created on #{push.created_at.to_s(:long)} is still active."
    end
  end

  puts "Batch of #{args[:batch_size]}: #{expiration_count} total pushes expired."

  puts ''
  puts 'All done.  Bye!  (っ＾▿＾)۶🍸🌟🍺٩(˘◡˘ )'
  puts ''
end
