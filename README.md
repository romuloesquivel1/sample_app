# Ruby on Rails Tutorial sample application

This is the sample application for the
[*Ruby on Rails Tutorial: Learn Web Development with Rails*](https://www.railstutorial.org/)
by [Michael Hartl](https://www.michaelhartl.com/).

## License

All source code in the [Ruby on Rails Tutorial](https://www.railstutorial.org/)
is available jointly under the MIT License and the Beerware
License. See [LICENSE.md](LICENSE.md) for details.

## Getting started

To get started with the app, clone the repo and then install the
needed gems:
```
$ gem install bundler -v 2.3.14
$ bundle _2.3.14_ config set --local without 'production'
$ bundle _2.3.14_ install
```
Next, migrate the database:
```
$ rails db:migrate
```

Run the test suite to verify that everything is working
correctly:
```
$ rails test
```
If the test suite passes, you'll be ready to seed the database with sample users:
```
$ rails db:seed
```
*Please be aware that the application was developed exclusively for testing purposes, without deployment to the Heroku and AWS platforms. 
You can run the app on a local server:
```
$ rails server
```

For more information, see the
[*Ruby on Rails Tutorial* book](https://www.railstutorial.org/book).