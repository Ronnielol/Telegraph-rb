module Telegraph
  module Connection
    BASE_URL = 'https://api.telegra.ph'

    def self.included(base)
      base.extend(self)
    end

    private

    def connection
      @connection ||= Faraday.new(url: BASE_URL) do |faraday|
        faraday.request :url_encoded
        faraday.response :json, content_type: /\bjson$/, parser_options: { symbolize_names: true }
        #faraday.response :logger
        faraday.headers['Content-Type'] = 'application/json'
        faraday.adapter  Faraday.default_adapter
      end
    end

    def get(method, params)
      params[:fields] = params[:fields].to_json if params[:fields]
      response = connection.get(method, params)
      check_errors(response)
      response.body[:result]
    end

    def post(method, params)
      url = "#{BASE_URL}/#{method}"
      response = connection.post do |req|
        req.url(url)
        req.body = params.to_json
      end
      check_errors(response)
      response.body[:result]
    end

    def check_errors(response)
      resp_body = response.body
      raise ArgumentError, resp_body[:error] if resp_body[:ok] == false
    end
  end
end
