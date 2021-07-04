# FAQ


## Trust is a concern. Why should I use Password Pusher?

And rightfully so. All good security begins with healthy skepticism of all involved components.

Password Pusher exists as a better alternative to emailing passwords. It avoids having passwords exist in email archives in perpetuity. It does not exist as a end-all security solution.

**Password Pusher is opensource so the source can be publicly reviewed and can alternatively be run internally in your organization.**

**Passwords are entirely deleted from the database once they expire.** Additionally, random URL tokens are generated on the fly and passwords are posted without context (what they go to).

*A note for those with an interest in extreme security:* there is no way I can reliably prove that the opensource code is the same that runs on [pwpush.com](https://pwpush.com/) (this is true for all sites in reality). The only thing I can provide in this respect is my public reputation on [Github](https://github.com/pglombardo), [LinkedIn](https://www.linkedin.com/in/peterlombardo/), [Twitter](https://twitter.com/pglombardo) and [my blog](https://the0x00.dev). If this is a concern for you, feel free to review the code, post any questions that you may have and consider running it internally at your organization instead.

## Are there other ways I can access Password Pusher outside of a browser?

Absolutely.  Password Pusher has a fair number of applications and command line utilities that interface with pwpush.com or alternatively privately run instances.  See our [Tools & Applications](/pages/tools) page for more details.

## Can I automate my password distribution?

Yes - many users utilize either Slack or the command line to push and distribute passwords.  See our [Tools & Applications](/pages/tools) page for more details.

## How many requests can I send to Password Pusher?

There are no limits currently and I have no intention of adding any.  To minimally assure site stability, Password Pusher is configured with a rate limiter by default.

## How can I run my own version for my organization?

See our Installation documentation for more details.

## Are there any licensing restrictions for me, my company or my organization?

The source code is released under the GNU General Public License v3.0 and that pretty much defines any and all limitations. There are quite a few rebranded & redesigned clone sites of Password Pusher and I welcome them all.

## Can I use Password Pusher in my talk/presentation/conference?

Absolutely.  Sending me a link to the talk/presentation/conference would be appreciated so I could share it on Twitter.

## Could you add a specific feature for my organization?

Very likely.  I love to hear all ideas & feedback. If you have any, please submit them to the [Github repository](https://github.com/pglombardo/Password Pusher) and I will respond as soon as possible.

## How do you make money?

I don't. This is just a pet project I work on in my spare time built for the community. Monthly costs are $34/month for Heroku hosting and any time/effort that I've put in or will put in developing the tool is voluntary/donated.

I've thought about moving the site to a Digital Ocean droplet but Heroku just makes it so easy. No configuring Apache/nginx, deploy scripts, monitoring services etc...

**2021 Update**:  The traffic has grown to an amount where 1 Heroku dyno no longer is sufficient. 2x professional dynos and the postgres add-on now has the project up to $59/month. 
