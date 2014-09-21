Findbball::Application.configure do

    #global variable of atlanta
    config.lat = 33.7489954
    config.lng = -84.3879824

    # Settings specified here will take precedence over those in config/application.rb.

    # In the development environment your application's code is reloaded on
    # every request. This slows down response time but is perfect for development
    # since you don't have to restart the web server when you make code changes.
    config.cache_classes = false

    # Keep that friggen best-in-place error from showing up
    config.reload_engines = true

    # Do not eager load code on boot.
    config.eager_load = false

    # Show full error reports and disable caching.
    config.consider_all_requests_local       = false
    config.action_controller.perform_caching = false    # Don't care if the mailer can't send.

    # Print deprecation notices to the Rails logger.
    config.active_support.deprecation = :log

    # Raise an error on page load if there are pending migrations
    config.active_record.migration_error = :page_load

    # Debug mode disables concatenation and preprocessing of assets.
    # This option may cause significant delays in view rendering with a large
    # number of complex assets.
    config.assets.debug = true

    # These 2 lines auto-reload couch_record
    # This first line adds our gem's lib directory to the list of directories that will be searched
    # when we encounter a missing constant
    config.autoload_paths += %W(#{config.root}/../best_in_place/lib)
    # This line tells rails to unload the root constant (module/class) for our gem on every request
    ActiveSupport::Dependencies.explicitly_unloadable_constants << 'BestInPlace'

    config.action_mailer.raise_delivery_errors = true

    #config.action_mailer.delivery_method = :sendmail
    config.action_mailer.default_url_options = {host: "findbball.com"}
    config.action_mailer.delivery_method = :smtp



end

class ActionDispatch::Request
    def remote_ip
        "50.141.192.165"
    end
end
