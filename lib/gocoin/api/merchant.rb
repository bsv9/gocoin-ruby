module GoCoin
  class Merchant

		def initialize(api)
		  @api = api
		end

		def get(id)
			@api.client.logger.debug 'GoCoin::Merchant#delete called.'
			route = "/merchants/#{id}"
			options = {}
			@api.request route, options
		end

		def update(id, params)
			@api.client.logger.debug 'GoCoin::Merchant#update called.'
			route = "/merchants/#{id}"
			options = {
				method: 'PATCH',
				payload: params
			}
			@api.request route, options
		end

	end
end