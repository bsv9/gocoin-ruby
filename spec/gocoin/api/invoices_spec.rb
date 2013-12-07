require 'spec_helper'

describe GoCoin::Invoices do
	
	before :each do

		# Values for GET /invoices/:id API behavior (#get)
		@get_invoice_id = 'getinvoiceid'
		@get_route = "/invoices/#{@get_invoice_id}"
		@get_options = {}
		@get_api_return_hash = 'mock_get_api_return_hash'

		# Values for POST /merchant/:id/invoices API behavior (#create)
		@merchant_id = 'somemerchantid'
		@create_params = {
		  price_currency: "BTC"
		  # more unnecessary for testing
		}
		@create_route = "/merchants/#{@merchant_id}/invoices"
		@create_options = {
			method: 'POST',
			payload: @create_params
		}
		@create_api_return_hash = 'mock_create_api_return_hash'

		# Values for GET /invoices/search?option1=OPTION1 API behavior (#search)
		@search_options = {
			status: 'new',
			page: 2
		}
		@search_route = "/invoices/search?#{GoCoin::Util.hash_to_url_params(@search_options)}"
		@search_api_return_hash = 'mock_search_api_return_hash'

		@invoices = GoCoin::Invoices.new(@api = double(GoCoin::API))
		@api.stub(:client).and_return(GoCoin::Client.new)

		@api.stub(:request).and_return('Incorrect parameters provided to API#request')
		@api.stub(:request).with(@get_route, @get_options).and_return(@get_api_return_hash)
		@api.stub(:request).with(@create_route, @create_options).and_return(@create_api_return_hash)
		@api.stub(:request).with(@search_route, {}).and_return(@search_api_return_hash)
	end

	describe "'get' method" do

    it 'should return the correct result' do
    	@invoices.get(@get_invoice_id).should == @get_api_return_hash
    end

	end

	describe "'create' method" do

    it 'should return the correct result' do
    	@invoices.create(@merchant_id, @create_params).should == @create_api_return_hash
    end

	end

	describe "'search' method" do

    it 'should return the correct result' do
    	@invoices.search(@search_options).should == @search_api_return_hash
    end

	end

end