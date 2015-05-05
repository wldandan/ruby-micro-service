Microservice Sample
==================


A Sample microservice Ruby application built using [Grape](https://github.com/intridea/grape), [Grape Swagger](https://github.com/tim-vandecasteele/grape-swagger), and [Grape Entity](https://github.com/intridea/grape-entity)

## Overview

##### End points

  To retrieve products list:

       path: /products
       verb: GET

  To create a new product:

       path: /products
       verb: POST
       body: {'name':'Docker In Action', 'price':56.00}

  To get detail of one specified product:

       path: /products/:id
       verb: GET

  To update detail of one specified product:

       path: /products/:id
       verb: PUT
       body: {'name':'Docker In Action', 'price':40.00}

  To remove one specified product:

       path: /products/:id
       verb: DELETE


##### Service API
Using the Grape DLS to implement service API, along with Grape-Swagger allows you to easily produce documentation that conforms to the [Swagger 1.2 Specification](https://github.com/swagger-api/swagger-spec). Unfortunately Grape-Swagger does not yet support the Swagger 2.0 specification.

Here is an example of the GET operation for getting a collection of Products records.

```
class ProductsApi  < Grape::API

  format :json
  default_format :json

  namespace :products do
  ...........

end

```

## Installation
Clone or fork this repository then run bundle to install the dependent gems.

    git clone https://github.com/wldandan/ruby-microservice-sample.git
    bundle

## Run the application

```
$ bundle exec puma

```


## Warm up

Once the application has started you can open http://petstore.swagger.io/ in your browser, and point the Swagger UI to your local running server.

```
http://localhost:9292/swagger_doc
```
