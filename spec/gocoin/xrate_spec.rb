require 'spec_helper'

describe Gocoin::Xrate do

	before :each do
		# Values for Xrate GET /prices API behavior (#get)
		@host = 'fake.xrate.host'
		@route = '/prices'
		@get_raw_request_config = {
      url: "https://#{@host}#{@route}",
      method: 'GET'
		}
		@get_api_return_hash = 'mock_get_api_return_hash'

		@xrate = Gocoin::Xrate.new(@client = double(Gocoin::Client))

		@client.stub(:logger).and_return(Logger.new(STDOUT))
		@client.stub(:options).and_return({
			xrate_host: @host
		})


		@client.stub(:raw_request).and_return('Incorrect parameters provided to API#raw_request')
		@client.stub(:raw_request).with(@get_raw_request_config).and_return(@get_api_return_hash)
	end
  
  describe "'get' method" do

    it 'should make a raw_request' do
	  	@xrate.get.should == @get_api_return_hash
	  end

  end

end
