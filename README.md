# Description
This project was adapted from [this tutorial](https://iridakos.com/tutorials/2013/12/07/creating-a-simple-todo-part-1.html) and the code it refers to. However, it was changed and customized to become a survey presented for developers to get their opinions about specific replies on StackOverflow questions. It is my first Ruby on Rails project and will be used to help in a [research project](https://sarahnadi.org/smr/lib-use/) I am helping with.

# Installing Ruby on Rails on Ubuntu 16.04 LTS
* Use [this link](https://www.phusionpassenger.com/library/install/nginx/install/oss/xenial/) to install Nginx + Passenger.
* Use [this link](https://www.digitalocean.com/community/tutorials/how-to-deploy-a-rails-app-with-passenger-and-nginx-on-ubuntu-14-04#step-four-—-install-ruby) to install Ruby. Make sure to get the newest ruby version and not the one noted in the link. This project is based on Ruby 2.5.3.
* Link passenger to the right ruby by doing the following:
	* `sudo vim /etc/nginx/passenger.conf`
	* set `passenger_ruby` to `/usr/bin/ruby`
* Use [this link](https://www.digitalocean.com/community/tutorials/how-to-deploy-a-rails-app-with-passenger-and-nginx-on-ubuntu-14-04#step-seven-—-deploy) to install Rails and deploy app.

# Installing MySQL and connecting it to project
This application uses MySQL database. To install that:
* Install the mysql packages on Ubuntu by running the following command: `sudo apt-get install mysql-client libmysqlclient-dev`
* Follow [this guide](https://support.rackspace.com/how-to/installing-mysql-server-on-ubuntu/) to install mysql server
* Follow [this post](https://stackoverflow.com/questions/50073498/ruby-on-rails-data-migration-from-sqlite3-to-mysql-regarding-to-many-to-many-rel) to connect the project to mysql2 to the database

# Ruby on Rails Notes
Since this is my first project in Ruby on Rails, I've taken some notes of how things in RoR go [here](https://github.com/samasri/DevelopersSurvey/blob/master/doc/RubyOnRailsNotes.md).

# Database
The schema can be found [here](https://github.com/samasri/DevelopersSurvey/blob/master/doc/Database.png). The models can be initialized using `rake db:migrate:reset`.

# Features
* Uses Ruby on Rails framework to 
* Presents questions to users in forms and collects the information
* Keeps track of users through Session IDs to ensure seamless flow of the form in case of interruptions like mistakenly closing or reloading the page submitting

# Known Constraints
* Session numbers are used to identify users; this is a security vunlerability
* Saving information from the forms is done by blindly permitting all parameters. This is a security vunlerability

# Test Suit
Test suit still not developed
