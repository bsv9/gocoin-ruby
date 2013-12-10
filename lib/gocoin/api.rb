module GoCoin
  class API

    attr_reader :client, :user, :merchant, :invoices

  	def initialize(client)
  		@client = client
  		@user = GoCoin::User.new(self)
  		@merchant = GoCoin::Merchant.new(self)
      @invoices = GoCoin::Invoices.new(self)
  	end

  	def request(route, options = {})
  		@client.logger.debug 'GoCoin::API#request called.'
  		raise 'GoCoin::API#request: Options is not a hash object' unless options.nil? || options.kind_of?(Hash)
  		raise 'GoCoin::API#request: API not ready. Token was not defined' unless @client.token

  		headers = options[:headers] ? @client.headers.merge(options[:headers]) : @client.headers.dup
  		headers['Authorization'] = "Bearer #{@client.token}"

  		options = @client.options.merge(options)
  		payload = options[:payload] ? options[:payload].to_json : nil

  		config = {
  			url: "#{@client.http_prefix(options[:secure])}#{options[:host]}#{@client.port}#{options[:path]}/#{options[:api_version]}#{route}",
  			method: options[:method],
  			headers: headers,
  		}
      config[:payload] = options[:payload].to_json if options[:payload]
  		@client.raw_request config
  	end

  end
end