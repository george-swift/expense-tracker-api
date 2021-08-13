# Expense Tracker API Documentation

> An API only Rails app that allows cross origin resource sharing with a React Redux frontend. The database is structured around three models: `User`, `List` and `Expense`. The `List` model has zero or more instances of the `Expense` model while belonging to an instance of the `User`. The `User` model uses a `has_many :through` association to get a readonly collection of the nested association between `List` and `Expenses`.

## Endpoints

_Base URL_: `https://api-expense-tracker.herokuapp.com`

|Description|Method|Endpoint|
|:---|:---|:---|
|Sign up to create an account|POST|`/users`|
|Log in to created account|POST|`/sessions`|
|Display user account information|GET|`users/:id`|
|Edit existing user account|PUT|`users/:id`|
|Log out if logged in|DELETE|`/sessions`|
|Fetch user's lists of expenses|GET|`users/:user_id/lists`|
|Create a new list|POST|`users/:user_id/lists`|
|Update an existing list|PUT|`/lists/:id`|
|Delete an existing list|DELETE|`/lists/:id`|
|Fetch expenses in a given list|GET|`/lists/:list_id/expenses`|
|Create a new expense in a list|POST|`/lists/:list_id/expenses`|
|Update an existing expense in a list|PUT|`/expenses/:id`|
|Delete an existing list|DELETE|`/expenses/:id`|


## Expected Response Status Codes

|Class|Symbol|HTTP status code|
|:---|:---|:---|
|Success|:ok|200|
|Success|:created|201|
|Client Error|:bad_request|400|
|Client Error|:unauthorized|401|
|Server Error|:internal_server_error|500|


## Built With
- Ruby 3.0.1
- Rails 6
- Postgresql
- RSpec

## Getting Started

- To get a copy of the API, run `git@github.com:george-swift/expense-tracker-api.git`
- Run `bundle install` to install dependencies
- Start development server by executing `rails s --binding=127.0.0.1 -p 4000`
- Visit the link `http://127.0.0.1:4000` on your browser to access resources
- Run `rails spec SPEC_OPTS="--format=doc"` to get test report

## Authors

👤 &nbsp; **Ubong George**
- GitHub: [@george-swift](https://github.com/george-swift)
- LinkedIn: [Ubong George](https://www.linkedin.com/in/ubong-itok)

## Acknowledgments

[Ruby on Rails Guide](https://guides.rubyonrails.org/api_app.html)

## Show your support

Give a :star: &nbsp; if you like this project!

## License

Available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).