module Gocoin
  class Invoices

		def initialize(api)
		  @api = api
		end

		def create(merchant_id, params)
			@api.client.logger.debug 'Gocoin::Invoices#create called.'
			route = "/merchants/#{merchant_id}/invoices"
			options = {
				method: 'POST',
				payload: params
			}
			@api.request route, options
		end

		def get(id)
			@api.client.logger.debug 'Gocoin::Invoices#get called.'
			route = "/invoices/#{id}"
			options = {}
			@api.request route, options
		end

		def search(params = {})
			@api.client.logger.debug 'Gocoin::Invoices#search called.'
			route = "/invoices/search?#{Util.hash_to_url_params(params)}"
			options = {}
			@api.request route, options
		end

	end
end