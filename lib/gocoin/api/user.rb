module Gocoin
  class User

		def initialize(api)
		  @api = api
		end

		def get(id)
			@api.client.logger.debug 'Gocoin::User#get called.'
			route = "/users/#{id}"
			options = {}
			@api.request route, options
		end

		def self
			@api.client.logger.debug 'Gocoin::User#self called.'
			route = "/user"
			options = {}
			@api.request route, options
		end

		def update(id, params)
			@api.client.logger.debug 'Gocoin::User#update called.'
			route = "/users/#{id}"
			options = {
				method: 'PATCH',
				payload: params
			}
			@api.request route, options
		end

		def update_password(id, params)
			@api.client.logger.debug 'Gocoin::User#update_password called.'
			route = "/users/#{id}/password"
			options = {
				method: 'PATCH',
				payload: params
			}
			@api.request route, options
		end

	end
end