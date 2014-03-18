module Gocoin
	module Merchants
	  class CurrencyConversions

			def initialize(api)
			  @api = api
			end

			def get(merchant_id, currency_conversion_id)
				@api.client.logger.debug 'Gocoin::Merchants::CurrencyConversion#get called.'
				route = "/merchants/#{merchant_id}/currency_conversions/#{currency_conversion_id}"
				options = {}
				@api.request route, options
			end

			def list(merchant_id)
				@api.client.logger.debug 'Gocoin::Merchants::CurrencyConversion#list called.'
				route = "/merchants/#{merchant_id}/currency_conversions"
				options = {}
				@api.request route, options
			end

		end
	end
end