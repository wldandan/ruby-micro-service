Bluemix Microservice Sample
==================


Sample microservice Ruby application built using [Grape](https://github.com/intridea/grape), [Grape Swagger](https://github.com/tim-vandecasteele/grape-swagger), and [Grape Entity](https://github.com/intridea/grape-entity) deployed to [IBM Bluemix](https://ace.ng.bluemix.net) (Cloud Foundry)

## Overview

##### End points
  To Retrieve products list: 
       http://localhost:9292/v1/products

  To Create a new product
       http://localhost:9292/v1/products

##### Service API
Using the Grape DLS to implement your service API, along with Grape-Swagger allows you to easily produce documentation that conforms to the [Swagger 1.2 Specification](https://github.com/swagger-api/swagger-spec). Unfortunately Grape-Swagger does not yet support the Swagger 2.0 specification.

Here is an example of the GET operation for getting a collection of Sales records.
```
class SalesApi  < Grape::API

  version 'v1', using: :path
  format :json
  default_format :json

  namespace :sales do

    desc 'List of sales', entity: Entities::Sales
    get '/', http_codes: [[200, 'Ok', Entities::Sales]] do
      present SalesAccess.fetch_all, is_array: false, with: Entities::Sales, type: :full
    end
  
  ...........

end
```

##### Accessing Cloud Foundry (Bluemix) Services
Once a service is bound to your application(See the Deploy to Bluemix section) you can access it using the properties in the VCAP_SERVICES environment variable. This variable is added to the environment by Cloud Foundry.

The sample application shows how you can read the Redis information from the VCAP_SERVICES variable when running on Cloud Foundry, as well as using the default connection when running locally.
See the ["Getting started with Redis service"](https://www.ng.bluemix.net/docs/#services/Redis/index.html) for more information.

```
class RedisConnection

  def self.client
    Redis.new(host: credentials['hostname'], port: credentials['port'], password: credentials['password'])
  end

  private

  def self.credentials
    @credentials ||= fetch_credentials
  end

  def self.fetch_credentials
    credentials = {'credentials'=>{'port'=>'6379', 'hostname'=>'localhost', 'password'=>''}}
    if ENV['VCAP_SERVICES']
      services = JSON.parse(ENV['VCAP_SERVICES'])
      redis_service = services['redis-2.6']
      credentials = redis_service.first['credentials'] if redis_service
    end
    credentials
  rescue Exception => e
    $stderr.puts 'Error in config'
    $stderr.puts "Error: #{e.message}"
  end

end
```



## Installation
Clone or fork this repository then run bundle to install the dependent gems.  

    git clone https://github.com/tbeauvais/bluemix-microservice-sample.git
    cd bluemix-microservice-sample
    bundle



## Running the Sample Locally


For simplicity the sample uses Redis as its datastore. The easiest way to install Redis on a Mac is to use homebrew
```
$ brew install redis
```
Start Redis
```
$ redis
```

Once Redis has started you can start the sample application using the puma server.
```
$ bundle exec puma

```


##### Testing in Swagger UI

Once the application has started you can open http://petstore.swagger.io/ in your browser, and point the Swagger UI to your local running server.

```
http://localhost:9292/swagger_doc
```

![Application Architecture](/doc/swagger_ui.png)

From here you can start by adding some sample data using the POST operation. Once you have some sales records you can view them using the GET operation.
![Application Architecture](/doc/swagger_post.png)


## Deploy to Bluemix
If you don't already have an account on [IBM Bluemix](https://ace.ng.bluemix.net) you will need to create one in order to deploy the sample application. You should also be familiar with Cloud Foundry and have the Cloud Foundry [command line tool](http://docs.cloudfoundry.org/devguide/installcf/whats-new-v6.html) installed. 
   
### Rename Application 
First you will need to edit the "name" and "host" in the manifest.yml file to ensure the application name and route to the application are unique. For example:

    applications:
      - name: my-sales-microservice-sample
        host: my-sales-microservice-sample

### Login to Bluemix
    $ cf api https://api.ng.bluemix.net
    $ cf login
    
### Create a Service Instance
Run the cf create-service command to create a Redis service instance. The name you give the instance (redis-db1) must match the service name specified in the manifest.yml file since that's what the application will be bound to.

    $ cf create-service redis 100 redis-db1

### Push Application to Cloud foundry (Bluemix)
Run the following commands from the cloned repository (e.i. bluemix-microservice-sample). This will connect you to Bluemix and then push the application to the the Cloud Foundry server, as well as bind the application to the service instance. 

    $ cf push


##### Testing in Swagger UI

Once the application has started you can open http://petstore.swagger.io/ in your browser, and point the Swagger UI to the application running on Bluemix.

```
http://my-sales-microservice-sample.mybluemix.net/swagger_doc
```

![Application Architecture](/doc/swagger_ui_bluemix.png)
