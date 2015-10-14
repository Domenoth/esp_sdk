[![Build Status](https://travis-ci.org/EvidentSecurity/esp_sdk.svg?branch=master)](https://travis-ci.org/EvidentSecurity/esp_sdk)
[![Code Climate](https://codeclimate.com/repos/546a526f6956800d2900e3fb/badges/841000b5295e533401c3/gpa.svg)](https://codeclimate.com/repos/546a526f6956800d2900e3fb/feed)
[![Coverage Status](https://coveralls.io/repos/EvidentSecurity/esp_sdk/badge.svg)](https://coveralls.io/r/EvidentSecurity/esp_sdk)
[![Gem Version](https://badge.fury.io/rb/esp_sdk.svg)](http://badge.fury.io/rb/esp_sdk)

# Evident Security Platform SDK

A Ruby interface for calling the [Evident.io](https://www.evident.io) API.

This Readme is for the V2 version of the ESP SDK.  For V1 information, see the [**V1 WIKI**](https://github.com/EvidentSecurity/esp_sdk/wiki).

## Installation

Add this line to your application's Gemfile:

    gem 'esp_sdk'

And then execute:

     bundle

Or install it yourself as:

     gem install esp_sdk

# Configuration

## Set your HMAC security keys:

You must set your access_key_id and your secret_access_key.  
You can set these directly:

      ESP.access_key_id = <your key>
      ESP.secret_access_key = <your secret key>
      
or with environment variables:

      ENV['ESP_ACCESS_KEY_ID'] = <you key>
      ENV['ESP_SECRET_ACCESS_KEY'] = <your secret key>
      
or, if in a Rails application, you can use the configuration block in an initializer:

      ESP.configuration do |config|
        config.access_key_id = <your key>
        config.secret_access_key = <your secret key>
      end
      
Get your HMAC keys from the Evident.io website, [esp.evident.io](https://esp.evident.io/settings/api_keys)

## Appliance Users

Users of Evident.io's AWS marketplace appliance will need to set the site for their appliance instance.
You can set this directly:

      ESP.site = <url to your appliance instance>
      
or, if in a Rails application, you can use the configuration block in an initializer:

      ESP.configuration do |config|
        config.site = <url to your appliance instance>
      end

# Usage

## Everything is an Object

The Evident.io SDK uses Active Resource, so the DSL acts very much like Active Record, only instead of a database as the data store, it makes calls to the Evident.io API.
So, for instance, to get a report by ID:

    espsdk:003:0> report = ESP::Report.find(234)
    
And to get the alerts for that report:

    espsdk:003:0> alerts = report.alerts

For objects that are creatable, updatable, and destroyable, you make the exact same calls you would expect to use with Active Record.

    espsdk:003:0> team = ESP::Team.create(name: 'MyTeam', organization_id: 452, sub_organization_id: 599)
    
    espsdk:003:0> team.name = 'NewName'
    espsdk:003:0> team.save
    
    espsdk:003:0> team.destroy
    
## Errors
Active Resource objects have an errors collection, just like Active Record objects.  If the API call returns a non fatal response, like 
validation issues, you can check the errors object to see what went wrong.

    espsdk:003:0> t = ESP::Team.create(organization_id: nil, sub_organization_id: nil)
    espsdk:003:0> t.errors
    {
        :base => [
            [0] "Organization can't be blank",
            [1] "Sub organization can't be blank",
            [2] "Name can't be blank"
        ]
    }
    
The errors will be in the :base key rather than the corresponding attribute key, since we have not defined a schema for the objects
in order to stay more loosely coupled to the API.

    espsdk:003:0> t.errors.full_messages
    [
        [0] "Organization can't be blank",
        [1] "Sub organization can't be blank",
        [2] "Name can't be blank"
    ]

When an error is thrown, you can rescue the error and check the error message:

    espsdk:003:0> c = ESP::CustomSignature.find(435)
    espsdk:003:0> c.run!(external_account_id: 999)
    ActiveResource::ResourceInvalid: Failed.  Response code = 422.  Response message = Couldn't find ExternalAccount.
    	from /Users/kevintyll/evident/esp_sdk/lib/esp/resources/custom_signature.rb:23:in `run!'
    
    begin
      c.run!(external_account_id: 999)
    rescue ActiveResource::ResourceInvalid => e
      puts e.message
    end
    Failed.  Response code = 422.  Response message = Couldn't find ExternalAccount.
    
All non get requests have a corresponding ! version of the method.  These methods will throw an error rather than swallow
the error and return an object with the errors object populated. For example, the `run` and `run!` methods on CustomSignature.

## Pagination
Evident.io API endpoints that return a collection of objects allows for paging and only returns a limited number of items at a time.
The Evident.io SDK returns an ESP::PaginatedCollection object that provides methods for paginating through the collection. 
 
## Contributing

1. Fork it ( https://github.com/[my-github-username]/esp_sdk/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
