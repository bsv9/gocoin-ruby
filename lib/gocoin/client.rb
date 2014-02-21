module Gocoin
	class Client

		attr_reader :api, :auth, :xrate, :user, :merchant, :invoices, :apps, :headers, :options, :logger
		attr_accessor :token

		def initialize(options = {})
			@defaults = {
				client_id: nil,
				client_secret: nil,
				host: 'api.gocoin.com',
				port: nil,
				path: '/api',
				api_version: 'v1',
				secure: true,
				method: 'GET',
				headers: nil,
				grant_type: 'authorization_code',
				request_id: nil,
				dashboard_host: 'dashboard.gocoin.com',
				xrate_host: 'x.g0cn.com',
				log_file: nil
			}

			@default_headers = {
				'Content-Type' => 'application/json'
			}

			@options = @defaults.merge options
			@logger = Logger.new(@options[:log_file] || STDOUT)
			@headers = @options[:headers] || @default_headers
			@headers['X-Request-Id'] = @options[:request_id] if @options[:request_id]

			@auth = Gocoin::Auth.new(self)
			@api = Gocoin::API.new(self)
			@xrate = Gocoin::Xrate.new(self)

			@accounts = @api.accounts
			@invoices = @api.invoices
			@merchant = @api.merchant
			@user = @api.user

			@options[:secure] = false if @options[:secure] == 'false'
		end

		def authenticate(options)
			@logger.debug 'Gocoin::Client#authenticate method called.'
			@auth.authenticate options
		end

		def http_prefix(secure = true)
			secure ? 'https://' : 'http://'
		end

		def port
			@options[:port] ? ":#{@options[:port]}" : nil
		end

		def raw_request(config)
			unless config[:payload].nil?
				config[:headers]['Content-Length'] = config[:payload].length
			end

			log_config = config.dup
			log_config[:headers] = config[:headers].dup
			@logger.debug 'Raw request made' + strip_secure_from_raw(log_config).to_s

			error_response = nil
			begin
				response = RestClient::Request.execute(
					config.merge(
						open_timeout: 30,
						timeout: 80
					)
				)
			rescue SocketError => error_response
				handle_restclient_error error_response
			rescue NoMethodError => error_response
				if error_response.message =~ /\WRequestFailed\W/
					error_response = APIConnectionError.new('Unexpected HTTP response code')
					handle_restclient_error error_response
				else
					raise
				end
			rescue RestClient::ExceptionWithResponse => error_response
				if rcode = error_response.http_code and rbody = error_response.http_body
					handle_api_error rcode, rbody
				else
					handle_restclient_error error_response
				end
			rescue RestClient::Exception, Errno::ECONNREFUSED => error_response
				handle_restclient_error error_response
			end

			return parse_error(error_response) if error_response
			parse response
		end

		private

		def strip_secure_from_raw(obj)
			strippable = %w[client_secret password current_password password_confirmation]
			if obj[:payload]
				obj[:payload] = JSON.parse obj[:payload]
				strippable.each do |k|
					obj[:payload][k] = "<#{k}>" if obj[:payload][k]
				end
			end
			obj[:headers]['Authorization'] = '<bearer>' if obj[:headers]['Authorization']
			
			obj
		end

		def parse(response)
			begin
				response = JSON.parse response.body
			rescue JSON::ParserError
				raise general_api_error response.code, response.body
			end

			Util.symbolize_names response
		end

		def parse_error(error_response)
			begin
				response = JSON.parse error_response.http_body
			rescue JSON::ParserError
				raise general_api_error error_response.http_code, error_response.error_body
			end

			response[:status] = error_response.http_code

			Util.symbolize_names response
		end

		def general_api_error(rcode, rbody)
			APIError.new( "Invalid response object from API: #{rbody.inspect} " +
										"(HTTP response code was #{rcode}", rcode, rbody)
		end

		def handle_api_error(rcode, rbody)
			begin
				error_obj = JSON.parse rbody
				error_obj = Util.symbolize_names(error_obj)
				error = error_obj[:error_description] or error_obj[:errors] or raise GocoinError.new
			rescue JSON::ParserError, GocoinError
				raise general_api_error(rcode, rbody)
			end

			case rcode
			when 400, 404
				raise invalid_request_error error, rcode, rbody, error_obj
			when 401
				raise authentication_error error, rcode, rbody, error_obj
			when 422 # Don't raise an error. Pass back a JSON object
				return
			else
				raise api_error error, rcode, rbody, error_obj
			end
		end

		def invalid_request_error(error, rcode, rbody, error_obj)
			InvalidRequestError.new(error, rcode, rbody, error_obj)
		end

	  def authentication_error(error, rcode, rbody, error_obj)
	    AuthenticationError.new(error, rbody, error_obj)
	  end

	  def api_error(error, rcode, rbody, error_obj)
	    APIError.new(error, rcode, rbody, error_obj)
	  end

		def handle_restclient_error(e)
	    case e
	    when RestClient::ServerBrokeConnection, RestClient::RequestTimeout
	      message = "Could not connect to GoCoin (#{@options[:host]}). " +
	        "Please check your internet connection and try again. " +
	        "If this problem persists,  let us know at tech@gocoin.com."

	    when RestClient::SSLCertificateNotVerified
	      message = "Could not verify GoCoin's SSL certificate. " +
	        "Please make sure that your network is not intercepting certificates. " +
	        "(Try going to https://#{options[:host]}/#{options[:api_version]} in your browser.) " +
	        "If this problem persists, let us know at tech@gocoin.com."

	    when SocketError
	      message = "Unexpected error communicating when trying to connect to GoCoin. " +
	        "You may be seeing this message because your DNS is not working. " +
	        "To check, try running 'host gocoin.com' from the command line."

	    else
	      message = "Unexpected error communicating with GoCoin. " +
	        "If this problem persists, let us know at tech@gocoin.com."
	    end

	    raise APIConnectionError.new(message + "\n\n(Network error: #{e.message})")
	  end

	end
end