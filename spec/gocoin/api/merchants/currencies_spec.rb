require 'spec_helper'

describe Gocoin::Merchants::Currencies do
	
	before :each do

		@merchant_id = 'merchant_id'

		# Values for GET /merchants/:merchant_id/currencies/:id API behavior (#get)
		@get_currency_id = 'get_currency_id'
		@get_route = "/merchants/#{@merchant_id}/currencies/#{@get_currency_id}"
		@get_options = {}
		@get_api_return_hash = 'mock_get_api_return_hash'

		# Values for PATCH /merchants/:merchant_id/ API behavior (#update)
		@update_currency_id = 'updatecurrencyid'
		@update_params = {
		  payment_crypto_split: 60
		}
		@update_route = "/merchants/#{@merchant_id}/currencies/#{@update_currency_id}"
		@update_options = {
			method: 'PATCH',
			payload: @update_params
		}
		@update_api_return_hash = 'mock_update_api_return_hash'

		# Values for GET /merchants/:merchant_id/currencies (#list)
		@list_route = "/merchants/#{@merchant_id}/currencies"
		@list_api_return_hash = 'mock_list_api_return_hash'

		@currencies = Gocoin::Merchants::Currencies.new(@api = double(Gocoin::API))
		@api.stub(:client).and_return(Gocoin::Client.new)

		@api.stub(:request).and_return('Incorrect parameters provided to API#request')
		@api.stub(:request).with(@get_route, @get_options).and_return(@get_api_return_hash)
		@api.stub(:request).with(@update_route, @update_options).and_return(@update_api_return_hash)
		@api.stub(:request).with(@list_route, {}).and_return(@list_api_return_hash)
	end

	describe "'get' method" do

    it 'should return the correct result' do
    	@currencies.get(@merchant_id, @get_currency_id).should == @get_api_return_hash
    end

	end

	describe "'update' method" do

    it 'should return the correct result' do
    	@currencies.update(@merchant_id, @update_currency_id, @update_params).should == @update_api_return_hash
    end

	end

	describe "'list' method" do

    it 'should return the correct result' do
    	@currencies.list(@merchant_id).should == @list_api_return_hash
    end

	end

end