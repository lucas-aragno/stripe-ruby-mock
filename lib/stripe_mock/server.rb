require 'thin'
require 'jimson-temp'

module StripeMock

  class Server
    extend Jimson::Handler

    def self.start_new(opts)
      server = Jimson::Server.new(Server.new,
        :host => opts[:host] || '0.0.0.0',
        :port => opts[:port] || 4999,
        :server => opts[:server] || :thin,
        :show_errors => true
      )
      server.start
    end

    def initialize
      self.clear_data
    end

    def mock_request(*args)
      @instance.mock_request(*args)
    end

    def get_data(key)
      @instance.send(key)
    end

    def clear_data
      @instance = Instance.new
    end

    def set_debug(toggle)
      @instance.debug = toggle
    end

    def debug?
      @instance.debug
    end

    def ping; true; end
  end

end
