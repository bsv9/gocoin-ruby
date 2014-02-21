module Gocoin
  class Merchant

    attr_reader :currencies, :currency_conversions, :payouts

		def initialize(api)
		  @api = api
		  @currencies = Gocoin::Merchants::Currencies.new(api)
		  @currency_conversions = Gocoin::Merchants::CurrencyConversions.new(api)
		  @payouts = Gocoin::Merchants::Payouts.new(api)
		end

		def get(id)
			@api.client.logger.debug 'Gocoin::Merchant#get called.'
			route = "/merchants/#{id}"
			options = {}
			@api.request route, options
		end

		def update(id, params)
			@api.client.logger.debug 'Gocoin::Merchant#update called.'
			route = "/merchants/#{id}"
			options = {
				method: 'PATCH',
				payload: params
			}
			@api.request route, options
		end

	end
end