###Changelog

###### v0.1.1:
Initial release: <br>
Selected methods for User, Merchant, and Invoices

###### v0.1.2:
Decapitalized all instances of gocoin (except class name Gocoin). <br>
This includes the gem name itself

Added methods:
* client.accounts.transactions
* client.merchant.currencies.get
* client.merchant.currencies.list
* client.merchant.currencies.update
* client.merchant.currency_conversions.get
* client.merchant.currency_conversions.list
* client.merchant.currency_conversions.request
* client.merchant.payouts.get
* client.merchant.payouts.list
* client.merchant.payouts.request

###### v0.1.3:
Enhanced README documentation. <br>

Removed methods:
* client.merchant.currency_conversions.request
* client.merchant.payouts.request
