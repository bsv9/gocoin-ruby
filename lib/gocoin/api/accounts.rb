module Gocoin
  class Accounts

		def initialize(api)
		  @api = api
		end

		def transactions(account_id, params = {})
			@api.client.logger.debug 'Gocoin::Accounts#transactions called.'
			route = "/accounts/#{account_id}/transactions?#{Util.hash_to_url_params(params)}"
			options = {}
			@api.request route, options
		end

	end
end