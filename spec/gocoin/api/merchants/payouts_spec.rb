require 'spec_helper'

describe Gocoin::Merchants::Payouts do
	
	before :each do

		@merchant_id = 'merchant_id'

		# Values for GET /merchants/:merchant_id/payouts/:id API behavior (#get)
		@get_payout_id = 'get_payout_id'
		@get_route = "/merchants/#{@merchant_id}/payouts/#{@get_payout_id}"
		@get_options = {}
		@get_api_return_hash = 'mock_get_api_return_hash'

		# Values for POST /merchants/:id/payouts API behavior (#request)
		@request_params = {
		  currency_code: "BTC"
		}
		@request_route = "/merchants/#{@merchant_id}/payouts"
		@request_options = {
			method: 'POST',
			payload: @request_params
		}
		@request_api_return_hash = 'mock_request_api_return_hash'

		# Values for GET /merchants/:merchant_id/payouts (#list)
		@list_route = "/merchants/#{@merchant_id}/payouts"
		@list_api_return_hash = 'mock_list_api_return_hash'

		@payouts = Gocoin::Merchants::Payouts.new(@api = double(Gocoin::API))
		@api.stub(:client).and_return(Gocoin::Client.new)

		@api.stub(:request).and_return('Incorrect parameters provided to API#request')
		@api.stub(:request).with(@get_route, @get_options).and_return(@get_api_return_hash)
		@api.stub(:request).with(@request_route, @request_options).and_return(@request_api_return_hash)
		@api.stub(:request).with(@list_route, {}).and_return(@list_api_return_hash)
	end

	describe "'get' method" do

    it 'should return the correct result' do
    	@payouts.get(@merchant_id, @get_payout_id).should == @get_api_return_hash
    end

	end

	describe "'list' method" do

    it 'should return the correct result' do
    	@payouts.list(@merchant_id).should == @list_api_return_hash
    end

	end

end