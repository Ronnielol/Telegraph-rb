module Telegraph
  module Connection
    BASE_URL = 'https://api.telegra.ph'

    private

    def connection
      @connection ||= Faraday.new(url: BASE_URL) do |faraday|
        faraday.request :url_encoded
        #faraday.response :logger
        faraday.adapter  Faraday.default_adapter
      end
    end

    def request(method, params)
      url = "#{BASE_URL}/#{method}"
      params['access_token'] = token if token
      connection.post do |req|
        req.url(url)
        req.headers['Content-Type'] = 'application/json'
        req.body = params.to_json
      end
    end

    def get(method, params)
      response = request(method, params)
      resp_hash = JSON.parse(response.body)
      check_errors(resp_hash)
      resp_hash['result']
    end

    def check_errors(response)
      raise ArgumentError, response['error'] if response['ok'] == false
    end
  end
end