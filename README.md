## Ruby Backend Test:

Os detalhes da execução e avaliação do teste podem ser visualizados **[neste link](TEST.md)**.

*Após a finalização do teste sinta-se livre para utilizar este readme como documentação.*
#
## Stack
* `ruby 2.7.1`
* `rails 6.0.3`
* `postgres 12`
## About
This API receives an incoming order, parses it and send the parsed result to other API.

## Getting started

To run the project make sure you have docker and docker-compose installed and proceed as follows:

```bash
# add .env
mv .env.sample .env

# build project
docker-compose build

# up the server
docker-compose up

# exec docker
docker-compose exec web

# run bin/setup to create database
bin/setup
```

## Testing

Run the tests inside docker as follows:

```bash
# rubocop
rubocop

# rspec
rspec
```

## Sending an order
To create a new order you must send a post request containing the raw order data. e.g:
* `verb` - `POST`
* `endpoint` - `/api/v1/order`
* `body` - [spec/fixtures/raw_order.json](spec/fixtures/raw_order.json)
```bash
curl -H 'Content-Type: application/json' \
     -d @spec/fixtures/raw_order.json \
     http://localhost:3000/api/v1/orders
```
* Possible responses:
  - 202 - Successfully created
  - 404 - Cant create order, please check your params
  - 503 - Cant send order to remote server
