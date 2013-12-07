require 'cgi'
require 'json'
require 'socket'
require 'rest_client'
require 'logger'

require 'gocoin/version'
require 'gocoin/util'

require 'gocoin/errors/gocoin_error'
require 'gocoin/errors/api_connection_error'
require 'gocoin/errors/api_error'
require 'gocoin/errors/authentication_error'
require 'gocoin/errors/invalid_request_error'

require 'gocoin/client'
require 'gocoin/auth'
require 'gocoin/api'

require 'gocoin/api/invoices'
require 'gocoin/api/merchant'
require 'gocoin/api/user'
