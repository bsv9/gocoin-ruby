module Gocoin
  class Xrate

    attr_reader :client

    def initialize(client)
      @client = client
    end

    def get(options = {})
      @client.logger.debug 'Gocoin::Xrate#get method called.'

      options = @client.options.merge options
      route = '/prices'

      config = {
        url: "https://#{@client.options[:xrate_host]}#{route}",
        method: 'GET'
      }

      @client.raw_request config
    end

  end
end