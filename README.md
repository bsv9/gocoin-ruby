# gocoin-ruby

A Ruby gem for the GoCoin API.

#### NOTICE:
This code is highly experimental. If you are interested in GoCoin, please contact kevin@gocoin.com

## Installation

``` ruby
gem 'gocoin'
```
or in a Gemfile
``` ruby
require 'gocoin'
```

##Usage

#### Instantiate a Gocoin client

``` ruby
gocoin_client = Gocoin::Client.new(
	client_id: '<CLIENT ID>',
	client_secret: '<CLIENT SECRET>',
	redirect_uri: 'https://myapp.com'
)
```

#### Generate the URL a user must visit to authorize the app

``` ruby
gocoin_client.auth.construct_code_url(
	response_type: 'code',
	client_id: gocoin_client.options[:client_id],
	redirect_uri: gocoin_client.options[:redirect_uri],
	scope: 'user_read_write invoice_read_write',
	state: 'state_token_you_provide'
)
```

The redirect will return the code as a parameter in the URL. For example:
https://myapp.com?code=RETURNED_CODE&state=state_token_you_provide 
Call Client#authenticate with the code as a parameter to retrieve a persistent token with the requests grant permissions.

``` ruby
token = gocoin_client.authenticate( code: CODE )
gocoin_client.token = token[:access_token]
```
Note that token[:access_token] should be stored in your app if you wish to avoid the authentication procedure each time the app is used.


#### Retrieve user data from the API.

``` ruby
# Gocoin::User#self()
# Require user_read or user_read_write privilege
user_self = gocoin_client.user.self

# Gocoin::User#get(id)
same_user = gocoin_client.user.get(user_self[:id])
```

#### Update user data.

``` ruby
# Gocoin::User#update(id, params = {})
# Requires user_read_write grant_type
gocoin_client.user.update( user_self[:id],
	email: 'updated@emailaddress.com',
	first_name: 'Your',
	last_name: 'NewName'
)
```

#### Update the user's password

``` ruby
# Gocoin::User#update_password(id, params = {})
# Requires user_password_write permission
gocoin_client.user.update_password(
	user_self[:id],
	current_password: 'gocoin',
	password: 'gocoin2',
	password_confirmation: 'gocoin2'
)
```

#### Get your merchant_id from your user object (as shown above)

``` ruby
merchant_id = user_self[:merchant_id]

# Gocoin::Merchant#get(id)
# Requires merchants_read or merchant_read_write privilege
merchant_self = gocoin_client.merchant.get(merchant_id))
```

#### Update your merchant data

``` ruby
# Gocoin::Merchant#update(id, params = {})
# Requires merchant_read_write privilege
gocoin_client.merchant.update( merchant_id,
  name: "Blingin' Merchant", 
  address_1: "123 Main St.",
  address_2: "Suite 1", 
  city: "Los Angeles", 
  region: "CA", 
  country_code: "US", 
  postal_code: "90000", 
  contact_name: "Bling McBlingerton", 
  phone: "1-555-555-5555", 
  website: "http://www.blinginmerchant.com", 
  description: "Some description.", 
  tax_id: "000000"
)
```

#### Create an invoice

``` ruby
# Gocoin::Invoices#create(id, params = {})
# Requires invoice_read_write privilege
created_invoice = gocoin_client.invoices.create( merchant_id,
  price_currency: "BTC",
  base_price: 134.00,
  base_price_currency: "USD",
  confirmations_required: 6,
  notification_level: "all",
  callback_url: "https://myapp.com/gocoin/callback",
  redirect_url: "https://myapp.com/redirect"
)
```

#### Retrieve invoices from the API

``` ruby
# Gocoin::Invoices#get(id)
retrieved_invoice = gocoin_client.invoices.get(created_invoice[:id]

# Gocoin::Invoices#search(params = {})
searched_invoices = gocoin_client.invoices.search(
	merchant_id: merchant_id,
	status: 'new',
	start_time: '2013-01-01',
	end_time: '2013-12-31',
	page: 1,
	per_page: 20
)
```
