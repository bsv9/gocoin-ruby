module Gocoin
	module Merchants
	  class Payouts

			def initialize(api)
			  @api = api
			end

			def get(merchant_id, payout_id)
				@api.client.logger.debug 'Gocoin::Merchants::Payouts#get called.'
				route = "/merchants/#{merchant_id}/payouts/#{payout_id}"
				options = {}
				@api.request route, options
			end

			def list(merchant_id)
				@api.client.logger.debug 'Gocoin::Merchants::Payouts#list called.'
				route = "/merchants/#{merchant_id}/payouts"
				options = {}
				@api.request route, options
			end

		end
	end
end