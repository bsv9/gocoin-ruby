require 'spec_helper'

describe Gocoin::API do
	
	describe "'request' method" do

		it "should raise an error if route is not passed as parameter" do
			@gocoin_client = Gocoin::Client.new
			expect{@gocoin_client.api.request}.to raise_error ArgumentError
		end

		it "should raise an error if token is undefined" do
			@gocoin_client = Gocoin::Client.new
			expect{@gocoin_client.api.request '/somewhere'}.to raise_error 'Gocoin::API#request: API not ready. Token was not defined'
		end

	end

end