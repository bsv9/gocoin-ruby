module Gocoin
	module Merchants
	  class Currencies

			def initialize(api)
			  @api = api
			end

			def get(merchant_id, currency_code)
				@api.client.logger.debug 'Gocoin::Merchants::Currencies#get called.'
				route = "/merchants/#{merchant_id}/currencies/#{currency_code}"
				options = {}
				@api.request route, options
			end

			def list(merchant_id)
				@api.client.logger.debug 'Gocoin::Merchants::Currencies#list called.'
				route = "/merchants/#{merchant_id}/currencies"
				options = {}
				@api.request route, options
			end

			def update(merchant_id, currency_code, params)
				@api.client.logger.debug 'Gocoin::Merchants::Currencies#update called.'
				route = "/merchants/#{merchant_id}/currencies/#{currency_code}"
				options = {
					method: 'PATCH',
					payload: params
				}
				@api.request route, options
			end

		end
	end
end