module Telegraph
  class Configuration
    include Singleton

    attr_accessor :key

    def initialize(token: nil)
      key = token if token
    end
  end
end