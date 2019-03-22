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

* I built this application following a TDD process to produce controller and service specs.  I would like to also add features specs, but time constraints have prevented this.

* After initially including the code to make the API call in the main controller's callback action, I decided to move this logic out of the controller in an effort to keep the controller 'skinny'.  This code is now included its own service, and leaves the controller much more readable.

* When rendering an error, the forms values are returned by the controller's callback action.  I consider using a Customer model might make this more simple, but have not been able to do this due to time constraints.

* I have utilised the Bootstrap gem (already included in the project) for very basic styling of the home page. Unfortunately, I have no experience with front end frameworks, but am hoping to learn more about these in my future role.
