require 'spec_helper'

describe Gocoin::Merchants::CurrencyConversions do
	
	before :each do

		@merchant_id = 'merchant_id'

		# Values for GET /merchants/:merchant_id/currency_conversions/:id API behavior (#get)
		@get_currency_conversion_id = 'get_currency_conversion_id'
		@get_route = "/merchants/#{@merchant_id}/currency_conversions/#{@get_currency_conversion_id}"
		@get_options = {}
		@get_api_return_hash = 'mock_get_api_return_hash'

		# Values for POST /merchants/:id/currency_conversions API behavior (#request)
		@request_params = {
		  base_currency: "BTC"
		}
		@request_route = "/merchants/#{@merchant_id}/currency_conversions"
		@request_options = {
			method: 'POST',
			payload: @request_params
		}
		@request_api_return_hash = 'mock_request_api_return_hash'

		# Values for GET /merchants/:merchant_id/currency_conversions (#list)
		@list_route = "/merchants/#{@merchant_id}/currency_conversions"
		@list_api_return_hash = 'mock_list_api_return_hash'

		@currency_conversions = Gocoin::Merchants::CurrencyConversions.new(@api = double(Gocoin::API))
		@api.stub(:client).and_return(Gocoin::Client.new)

		@api.stub(:request).and_return('Incorrect parameters provided to API#request')
		@api.stub(:request).with(@get_route, @get_options).and_return(@get_api_return_hash)
		@api.stub(:request).with(@request_route, @request_options).and_return(@request_api_return_hash)
		@api.stub(:request).with(@list_route, {}).and_return(@list_api_return_hash)
	end

	describe "'get' method" do

    it 'should return the correct result' do
    	@currency_conversions.get(@merchant_id, @get_currency_conversion_id).should == @get_api_return_hash
    end

	end

	describe "'list' method" do

    it 'should return the correct result' do
    	@currency_conversions.list(@merchant_id).should == @list_api_return_hash
    end

	end

end