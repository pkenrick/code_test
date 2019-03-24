# Make it Cheaper Code Test

## 1. Fork this project to your GitHub

## 2. Do the test

- API documentation on [http://mic-leads.dev-test.makeiteasy.com/api/v1/docs](http://mic-leads.dev-test.makeiteasy.com/api/v1/docs)
- Copy/paste `.env.example` to `.env`
- Setup API token provided by Make It Cheaper
- `bundle install`
- `rails s`

## 3. When finished

- provide a git URL to allow us to read/run your code
- and/or create a pull request

## 4. Your app must start by running the following commands

- `bundle install`
- `rake db:create db:migrate` (If you use a database or sqlite3. It's possible to do the test without any database)
- `rails s`

## Test

```shell
bundle exec rspec
```

## Environments variables

Check `.env.example`

- LEAD_API_PGUID="CFFBF53F-6D89-4B5B-8B36-67A97F18EDEB"
- LEAD_API_PACCNAME="MicDevtest"
- LEAD_API_PPARTNER="MicDevtest"
- LEAD_API_ACCESS_TOKEN=provide_by_maket_it_cheaper

## Notes from the Author

* I built this application following a TDD process to produce controller and service specs.  I have also added some simple feature specs.

* I have attempted to keep my controller skinny by doing two things:

  1. moving the API-calling code out to its own service
  2. creating a customer model keep track of the user's inputs (no database required so I used ActiveModel rather than ActiveRecord)

* With the inclusion of the customer model, it would have been easy to include model validations, however the API validates the user details thoroughly and returns very specific error messages.  I decided it would be best to simply rely on these.  It means that no changes to the app are required if the API's requirements change (for example, if it's decided that customer name can be first name only).

* I have utilised the Bootstrap gem (already included in the project) for basic styling of the home page, included in the scss file `homepage.scss`.
