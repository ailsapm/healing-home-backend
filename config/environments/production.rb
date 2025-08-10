require "active_support/core_ext/integer/time"

Rails.application.configure do
  #settings specified here will take precedence over those in config/application.rb.

  #code is not reloaded between requests in production for better speed.
  config.enable_reloading = false

  #eager load code on boot for better performance and memory savings (ignored by Rake tasks).
  #loads all app code when server starts, improves performance but uses more memory
  config.eager_load = true

  #full error reports are disabled for security
  config.consider_all_requests_local = false

  #cache static assets (images, CSS, JS) for a long time since they have unique filenames
  config.public_file_server.headers = { "cache-control" => "public, max-age=#{1.year.to_i}" }

  # Enable serving of images, stylesheets, and JavaScripts from an asset server.
  #config.asset_host = "http://assets.example.com"

  #store uploaded files locally (see config/storage.yml for options).
  config.active_storage.service = :local

  #assume all access to app is through SSL-terminating reverse proxy for correct urls and security headers
  config.assume_ssl = true

  ##force all connections to use HTTPS, enabling security headers and secure cookies
  config.force_ssl = true

  #skip http-to-https redirect for the default health check endpoint.
  #config.ssl_options = { redirect: { exclude: ->(request) { request.path == "/up" } } }

  #log to STDOUT with current request id as a default log tag, unique id to help track issues
  config.log_tags = [ :request_id ]
  config.logger   = ActiveSupport::TaggedLogging.logger(STDOUT)

  #define how much info shown in logs, change to "debug" to log everything (including potentially personally-identifiable information, info is good for pruduction)
  config.log_level = ENV.fetch("RAILS_LOG_LEVEL", "info")

  #stop health checks from clogging up logs.
  config.silence_healthcheck_path = "/up"

  #don't log any deprecations.
  config.active_support.report_deprecations = false

  #replace default in-process memory cache store with a durable alternative to persist cache
  config.cache_store = :solid_cache_store

  #use durable background job queue adapter instead of default async 
  config.active_job.queue_adapter = :solid_queue
  config.solid_queue.connects_to = { database: { writing: :queue } }

  #email settings - commenting out, out of scope for right now
  #don't raise errors if emails fail to send by default
  #change to true and configure SMTP to send real emails

  # config.action_mailer.raise_delivery_errors = false

  #host to be used by links generated in mailer templates - setting to port 3000 for now, not enabling any mailer stuff at this stage
  #change to deployed url when deploying
  config.action_mailer.default_url_options = { host: "localhost", port: 3000 }

  # Specify outgoing SMTP server. Remember to add smtp/* credentials via rails credentials:edit.
  # config.action_mailer.smtp_settings = {
  #   user_name: Rails.application.credentials.dig(:smtp, :user_name),
  #   password: Rails.application.credentials.dig(:smtp, :password),
  #   address: "smtp.example.com",
  #   port: 587,
  #   authentication: :plain
  # }

  #enable locale fallbacks for I18n (makes lookups for any locale fall back to
  # I18n.default_locale when a translation cannot be found).
  config.i18n.fallbacks = true

  #do not create a dump schema after migrations
  config.active_record.dump_schema_after_migration = false

  #only show model ID when inspecting records in production logs (keeps logs cleaner)
  config.active_record.attributes_for_inspect = [ :id ]

  #protect against DNS rebinding and host header attack
  #uncomment and add allowed hosts to whitelist relevant domain(s)
  # config.hosts = [
  #   "example.com",     #allow requests from example.com
  #   /.*\.example\.com/ #allow requests from subdomains like `www.example.com`
  # ]
  #
  #skip DNS rebinding protection for the default health check endpoint if needed
  # config.host_authorization = { exclude: ->(request) { request.path == "/up" } }
end
