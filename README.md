# README

This is the take-home assignment regarding building a simple API for building creation/update with custom fields.

## Run with Docker:

To run the app on Docker, from the code directory:

- `docker-compose build`
- `docker-compose run --rm app sh -c "bundle install && rails db:setup && rails db:seed"`
- `docker-compose up`

You can then use the API with the pre-seeded data. All seed data, including Custom Field definitions are in `app/db/seeds.rb`

For example, to view the buildings:

http://localhost:3000/buildings

## Design Considerations:

Instead of using a table and data model to store custom field values (and then joining to buildings to grab the custom field values), I am using a serialized JSON field on the buildings table. This has pros and cons. For a take home assignment, it allowed a quick MVP to get up and running, but it could hit some problems depending on whether or not the project needs to search and query by that data. I am also using MySQL as the DB. Postgres has far more advanced JSON fields that allow indexing and querying, so that could be a consideration if this project were going to be the basis for an actual system.

## API:

Using Postman you can easily POST/GET data as needed from the API, here are the routes. I've included a few API endpoints not specified in the assignment to make it easier to browse some of the data, especialy CustomFields.

### GET [/buildings](http://localhost:3000/buildings)

This route returns JSON with the following keys:

`status`: should be "success" if all went well

`pagination`: data regarding the pagination information a client would need to page through the records

`data`: the array of buildings

All buildings will be listed with "flattened" custom fields included. It can be paginated like so, by passing the "per page" you'd like as `limit`:

GET [/buildings?limit=5&page=1](http://localhost:3000/buildings?limit=5&page=1)

Notice how the `pagination` key contains a hash with information.

### GET [/buildings/:id](http://localhost:3000/buildings/1)

Information about one building, contains keys:

`status`: should be "success" if all went well

`data`: JSON object of the building data

### GET [/clients](http://localhost:3000/clients)

`status`: should be "success" if all went well

`data`: the array of clients

Note that this route does not allow pagination

### GET [/clients/:id](http://localhost:3000/clients/1)

`status`: should be "success" if all went well

`data`: JSON object of the client

### GET [/clients/:id/custom_fields](http://localhost:3000/clients/1/custom_fields)


`status`: should be "success" if all went well

`data`: array of the custom fields associated with this client, icluding the name of the field, the field_type, and enum_options if it is an enum field

### POST /buildings

This is used to create a building, note that you will need the client ID to create a building, example raw POST body:

```json
{
    "building": {
        "client_id": 1,
        "address_1": "543 Circle St",
        "city": "Chicago",
        "state": "IL",
        "zip": "94324",
        "custom_fields": {
            "color": "green",
            "zoning": "commercial"
        }
    }
}
```

the response should be an HTTP 201 (created) status code and contain these keys:

`status`: should be "success" if all went well

`data`: JSON object of the building that was just created

here's an example of a bad validation (the zoning is not a valid enum option for this client):

```json
{
    "building": {
        "client_id": 1,
        "address_1": "543 Circle St",
        "city": "Chicago",
        "state": "IL",
        "zip": "94324",
        "custom_fields": {
            "color": "green",
            "zoning": "i don't believe in zoning"
        }
    }
}
```

The response will be HTTP 422 (unprocessable entity) and a body with these keys:

`status`: error

`errors`: A JSON hash containing keys of field names that did not validate, each key is an array of validation errors

### PATCH /buildings/:id

This is a way to edit a building, you can supply only the fields you wish to change. However, there is a catch! This is a TODO in my implementation, but I'm going to leave it here for this take home assignment: You must always supply the full representation of the "custom_fields". You can't deep-PATCH custom fields right now.

here's an example where we give the full representation of custom fields to update them:

```json
{
    "building": {
        "custom_fields": {
            "color": "white",
            "height_feet": 120.45,
            "zoning": "commercial"
        }
    }
}
```

The same error or success states apply to PATCH as they do to POST
