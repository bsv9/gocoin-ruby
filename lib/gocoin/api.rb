module Gocoin
  class API

    attr_reader :client, :user, :merchant, :invoices

  	def initialize(client)
  		@client = client
  		@user = Gocoin::User.new(self)
  		@merchant = Gocoin::Merchant.new(self)
      @invoices = Gocoin::Invoices.new(self)
  	end

  	def request(route, options = {})
  		@client.logger.debug 'Gocoin::API#request called.'
  		raise 'Gocoin::API#request: Options is not a hash object' unless options.nil? || options.kind_of?(Hash)
  		raise 'Gocoin::API#request: API not ready. Token was not defined' unless @client.token

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