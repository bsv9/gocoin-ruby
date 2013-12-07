require 'spec_helper'

describe GoCoin::User do
	
	before :each do
		# Values for GET /user API behavior (#self)
		@self_route = "/user"
		@self_options = {}
		@self_api_return_hash = 'mock_self_api_return_hash'

		# Values for GET /users/:id API behavior (#get)
		@get_user_id = 'getuserid'
		@get_route = "/users/#{@get_user_id}"
		@get_options = {}
		@get_api_return_hash = 'mock_get_api_return_hash'

		# Values for PATCH /users/:id API behavior (#update)
		@update_user_id = 'updateuserid'
		@update_params = {
	    email: "some@email.address",
	    first_name: "First",
	    last_name: "Last"
		}
		@update_route = "/users/#{@update_user_id}"
		@update_options = {
			method: 'PATCH',
			payload: @update_params
		}
		@update_api_return_hash = 'mock_update_api_return_hash'

		# Values for PATCH /users/:id/password API behavior
		@update_password_user_id = 'updatepasswordsomeuserid'
		@update_password_params = {
	    current_password: "currentpassword",
	    password: "newpassword",
	    password_confirmation: "newpassword"
		}
		@update_password_route = "/users/#{@update_password_user_id}/password"
		@update_password_options = {
			method: 'PATCH',
			payload: @update_password_params
		}
		@update_password_api_return_hash = 'mock_update_password_api_return_hash'

		@user = GoCoin::User.new(@api = double(GoCoin::API))
		@api.stub(:client).and_return(GoCoin::Client.new)

		@api.stub(:request).and_return('Incorrect parameters provided to API#request')
		@api.stub(:request).with(@self_route, @self_options).and_return(@self_api_return_hash)
		@api.stub(:request).with(@get_route, @get_options).and_return(@get_api_return_hash)
		@api.stub(:request).with(@update_route, @update_options).and_return(@update_api_return_hash)
		@api.stub(:request).with(@update_password_route, @update_password_options).and_return(@update_password_api_return_hash)
	end


	describe "'self' method" do

    it 'should return the correct result' do
    	@user.self.should == @self_api_return_hash
    end

	end

	describe "'get' method" do

    it 'should return the correct result' do
    	@user.get(@get_user_id).should == @get_api_return_hash
    end

	end

	describe "'update' method" do

    it 'should return the correct result' do
    	@user.update(@update_user_id, @update_params).should == @update_api_return_hash
    end

	end

	describe "'update_password' method" do

    it 'should return the correct result' do
    	@user.update_password(@update_password_user_id, @update_password_params).should == @update_password_api_return_hash
    end

	end

end