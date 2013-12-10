module GoCoin
  class Auth

    REQUIRED_CODE_PARAMS = %w[grant_type client_id client_secret code redirect_uri]

    attr_reader :client

    def initialize(client)
      @client = client
    end

    def authenticate(options = {})
      @client.logger.debug 'GoCoin::Auth#authenticate method called.'

      headers = @client.headers.merge(options[:headers] || {})
      options = @client.options.merge options
      verify_required_params options
      route = '/oauth/token'

      config = {
        url: "#{@client.http_prefix}#{@client.options[:host]}#{@client.port}#{@client.options[:path]}/#{@client.options[:api_version]}#{route}",
        method: 'POST',
        headers: headers,
        payload: options.to_json
      }

      @client.raw_request config
    end

    def construct_code_url(params)
      "https://#{@client.options[:dash_url]}/auth?#{Util.hash_to_url_params(params)}"
    end

    private

    def verify_required_params(options)
      if options[:grant_type] == 'authorization_code'
        required = REQUIRED_CODE_PARAMS
      else
        raise 'GoCoin::Auth#authenticate: grant_type was not defined properly or is unsupported'
      end      

      @client.logger.debug "Required params: #{required}"
      required.each do |required_attribute|
        raise "GoCoin::Auth#authenticate requires '#{required_attribute}' option." unless options[required_attribute.to_sym]
      end
      options
    end

  end
end