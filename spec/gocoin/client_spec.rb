require 'spec_helper'

describe Gocoin::Client do

	describe "::initialize" do

		describe "with an empty options hash" do

			before :each do
				@gocoin_client = Gocoin::Client.new
			end

			it "should have the default options" do
				@gocoin_client.options[:client_id].should be_nil
				@gocoin_client.options[:client_secret].should be_nil
				@gocoin_client.options[:host].should == 'api.gocoin.com'
				@gocoin_client.options[:port].should be_nil
				@gocoin_client.options[:path].should == '/api'
				@gocoin_client.options[:api_version].should == 'v1'
				@gocoin_client.options[:secure].should == true
				@gocoin_client.options[:method].should == 'GET'
				@gocoin_client.options[:grant_type].should == 'authorization_code'
				@gocoin_client.options[:request_id].should be_nil
				@gocoin_client.options[:dashboard_host].should == 'dashboard.gocoin.com'
				@gocoin_client.options[:xrate_host].should == 'x.g0cn.com'
				@gocoin_client.options[:log_file].should be_nil
				@gocoin_client.options[:token].should be_nil
			end

			it "should have the default headers" do
				@gocoin_client.headers.should == { 'Content-Type' => 'application/json' }
			end

			it "should allow access to 'logger'" do
				@gocoin_client.logger.class.to_s.should == 'Logger'
			end

			it "should allow access to 'auth'" do
				@gocoin_client.auth.class.to_s.should == 'Gocoin::Auth'
			end

			it "should allow access to 'api'" do
				@gocoin_client.api.class.to_s.should == 'Gocoin::API'
			end

			it "should allow access to 'auth'" do
				@gocoin_client.auth.class.to_s.should == 'Gocoin::Auth'
			end

			it "should allow access to 'user'" do
				@gocoin_client.user.class.to_s.should == 'Gocoin::User'
			end

			it "should allow access to 'merchant'" do
				@gocoin_client.merchant.class.to_s.should == 'Gocoin::Merchant'
			end

			it "should allow access to 'invoices'" do
				@gocoin_client.invoices.class.to_s.should == 'Gocoin::Invoices'
			end

		end

		describe "with a non-empty options hash" do

			before :each do
				@options = {
					client_id: 'the_client_id_string',
					client_secret: 'the_client_secret_string',
					host: 'a.different.host',
					port: '5',
					path: '/a_different_api',
					api_version: 'v6.28',
					secure: false,
					method: 'PUT',
					headers: {'Content-Length' => '628'},
					grant_type: 'a_different_grant_type',
					request_id: 'a_request_id_string',
					dashboard_host: 'a.different.dash.host',
					token: 'a_token'
				}
				@gocoin_client = Gocoin::Client.new(@options)
			end

			it "should not be nil" do
				@gocoin_client.should_not be_nil
			end

			it "should set the options with the provided values" do
				@gocoin_client.options[:client_id].should == @options[:client_id]
				@gocoin_client.options[:client_secret].should == @options[:client_secret]
				@gocoin_client.options[:host].should == @options[:host]
				@gocoin_client.options[:port].should == @options[:port]
				@gocoin_client.options[:path].should == @options[:path]
				@gocoin_client.options[:api_version].should == @options[:api_version]
				@gocoin_client.options[:secure].should == @options[:secure]
				@gocoin_client.options[:method].should == @options[:method]
				@gocoin_client.options[:headers].should == @options[:headers].merge('X-Request-Id' => 'a_request_id_string')
				@gocoin_client.options[:grant_type].should == @options[:grant_type]
				@gocoin_client.options[:request_id].should == @options[:request_id]
				@gocoin_client.options[:dashboard_host].should == @options[:dashboard_host]
				@gocoin_client.options[:token].should == @options[:token]
			end

		end

		it "should interpret a 'false' (String type) options as a boolean false" do
			@gocoin_client = Gocoin::Client.new( :secure => 'false')
			@gocoin_client.options[:secure].should == false
		end

	end

	describe '#http_prefix' do

		it "should return https when secure=ture" do
			@gocoin_client = Gocoin::Client.new
			@gocoin_client.http_prefix.should == 'https://'
		end

		it "should return http when secure=false" do
			@gocoin_client = Gocoin::Client.new
			@gocoin_client.http_prefix(false).should == 'http://'
		end

	end

	describe '#port' do

		it "should return a specified port (precded by a colon)" do
			@gocoin_client = Gocoin::Client.new( :port => 628 )
			@gocoin_client.port.should == ':628'
		end

		it "should return nil when port unspecified" do
			@gocoin_client = Gocoin::Client.new()
			@gocoin_client.port.should be_nil
		end

	end

end
