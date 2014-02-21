require 'spec_helper'

describe Gocoin::Merchant do
	
	before :each do
		# Values for GET /merchants/:id API behavior (#get)
		@get_merchant_id = 'getmerchantid'
		@get_route = "/merchants/#{@get_merchant_id}"
		@get_options = {}
		@get_api_return_hash = 'mock_get_api_return_hash'

		# Values for PATCH /merchants/:id API behavior (#update)
		@update_merchant_id = 'updatemerchantid'
		@update_params = {
		  name: "Blingin' Merchant", 
		  address_1: "123 Main St."
		  # more is unnecessary
		}
		@update_route = "/merchants/#{@update_merchant_id}"
		@update_options = {
			method: 'PATCH',
			payload: @update_params
		}
		@update_api_return_hash = 'mock_update_api_return_hash'

		# Values for GET /merchants/:id/accounts API behavior (#accounts)
		@accounts_merchant_id = 'accountsmerchantid'
		@accounts_route = "/merchants/#{@accounts_merchant_id}/accounts"
		@accounts_options = {}
		@accounts_api_return_hash = 'mock_accounts_api_return_hash'


		@merchant = Gocoin::Merchant.new(@api = double(Gocoin::API))
		@api.stub(:client).and_return(Gocoin::Client.new)

		@api.stub(:request).and_return('Incorrect parameters provided to API#request')
		@api.stub(:request).with(@get_route, @get_options).and_return(@get_api_return_hash)
		@api.stub(:request).with(@update_route, @update_options).and_return(@update_api_return_hash)
		@api.stub(:request).with(@accounts_route, @accounts_options).and_return(@accounts_api_return_hash)
	end

	describe "'get' method" do

    it 'should return the correct result' do
    	@merchant.get(@get_merchant_id).should == @get_api_return_hash
    end

	end

	describe "'update' method" do

    it 'should return the correct result' do
    	@merchant.update(@update_merchant_id, @update_params).should == @update_api_return_hash
    end

	end

	describe "'accounts' method" do

    it 'should return the correct result' do
    	@merchant.accounts(@accounts_merchant_id).should == @accounts_api_return_hash
    end

	end

end