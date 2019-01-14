module Telegraph
  class Client
    include Telegraph::Connection

    attr_reader :token

    def initialize(token)
      @token = token
    end
  end
end
