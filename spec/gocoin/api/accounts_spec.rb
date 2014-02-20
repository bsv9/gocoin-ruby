require 'spec_helper'

describe Gocoin::Accounts do
	
	before :each do


		# Values for GET /accounts/:id/transactions?option1=OPTION1 API behavior (#transactions)
		@account_id = 'account_id'
		@transactions_params = {
			start_time: '2013-08-18 00:00',
			page: 2
		}
		@transactions_route = "/accounts/#{@account_id}/transactions?#{Gocoin::Util.hash_to_url_params(@transactions_params)}"
		@transactions_api_return_hash = 'mock_transactions_api_return_hash'

		@accounts = Gocoin::Accounts.new(@api = double(Gocoin::API))
		@api.stub(:client).and_return(Gocoin::Client.new)

		@api.stub(:request).and_return('Incorrect parameters provided to API#request')
		@api.stub(:request).with(@transactions_route, {}).and_return(@transactions_api_return_hash)
	end

	describe "'transactions' method" do

    it 'should return the correct result' do
    	@accounts.transactions(@account_id, @transactions_params).should == @transactions_api_return_hash
    end

	end

end