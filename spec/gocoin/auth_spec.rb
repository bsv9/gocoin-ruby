require 'spec_helper'

describe GoCoin::Auth do
	
	describe "'auth' method" do

		it "should raise an error if an improper grant_type is specified" do
			@gocoin_client = GoCoin::Client.new(grant_type: 'invalid_grant_type')
			expect{@gocoin_client.auth.authenticate}.to raise_error 'GoCoin::Auth#authenticate: grant_type was not defined properly'
		end

		it "should raise an error if missing required properties for password grant_type" do
			@gocoin_client = GoCoin::Client.new(
				grant_type: 'password',
				client_secret: 'somesecret',
				username: 'admin@gocoin.com',
				password: 'password123',
				scope: 'user_read'
			)
			expect{@gocoin_client.auth.authenticate}.to raise_error "GoCoin::Auth#authenticate requires 'client_id' option."
		end

		it "should raise an error if missing required properties for authorization_code grant_type" do
			@gocoin_client = GoCoin::Client.new(
				grant_type: 'authorization_code',
				client_id: 'someid',
				client_secret: 'somesecret',
				redirect_uri: 'someuri'
			)
			expect{@gocoin_client.auth.authenticate}.to raise_error "GoCoin::Auth#authenticate requires 'code' option."
		end

	end

	describe "'construct_code_url' method" do

		it "should create and return an authorization_code url" do
			@gocoin_client = GoCoin::Client.new(
				grant_type: 'password',
				client_secret: 'somesecret',
				username: 'admin@gocoin.com',
				password: 'password123',
				scope: 'user_read'
			)
			url = @gocoin_client.auth.construct_code_url param_key: 'param_value'
			url.should == 'https://dashboard.gocoin.com/auth?param_key=param_value'
		end

	end

end