# Feature Toggle Lab Instructions

## Prerequisites
--- 
1. Please install the following dependencies prior to the lab
   1. [git](https://git-scm.com/)
   2. Any text editor for code (VS Code, Sublime, etc.)
   3. [Ruby Version Manager](https://rvm.io/rvm/install) (commands are copied below)
      1. `gpg --keyserver hkp://pool.sks-keyservers.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB`
      2. `\curl -sSL https://get.rvm.io | bash -s stable --ruby`
         1. If you use ZSH, you may need to run the following
         ```
         [[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"
      3. `rvm install 2.5.0`
      4. If you are on a Mac, you may need to run the following if you get Openssl errors:
         1. `brew install rbenv/tap/openssl@1.0`
         2. `export LDFLAGS="-L/usr/local/opt/openssl@1.0/lib"`
         3. `export CPPFLAGS="-I/usr/local/opt/openssl@1.0/include"`
         4. `export PKG_CONFIG_PATH="/usr/local/opt/openssl@1.0/lib/pkgconfig"`
         5. `rvm install 2.5.0 --with-openssl-dir=$(brew --prefix openssl@1.0)`

2. Clone the GitHub Repository
 

## Lab
---
3. Setup up the application
   1. Switch to the application directory
   2. Run `rvm use 2.5.0 --default` (this tells RVM to use ruby version 2.5.0 by default whenever you open up a new terminal window)
   3. Run `bundle install --without production` (this installs all the gems (packages) required to run the application) If this fails, try the following:
        `rvm @global do gem install bundler -v '< 2.0'`
        `gem uninstall bundler -v 2.2.6`
        `gem install nio4r -v '1.2.1' -- --with-cflags="-Wno-error=implicit-function-declaration"`
   4. Run `bundle update` (this command upgrades the gem package versions within your gemfile.lock file)
   5. Take a look at `db/seeds.rb` (these are model instances that will be added to the database when we run db:seed in a minute)
   6. Run `bundle exec rake db:setup` (this command sets up a local database instance and runs the database migrations)
   7. Run `bundle exec rake db:seed`(this command creates model instances based off of the seeds.rb file)
4. Start the application
   1. The application can be started by running `bundle exec rails s` and is available on [localhost:3000](http://localhost:3000)
   2. To stop the application, simply press `ctrl + c` in the terminal window the app is running in

5. Register two users
   1. Click register in the top right hand corner of the web page
   2. Fill out the details and create the user. Keep track of the email and password!
   3. After you have successfully created the first user, click the sign out button in the top right
   4. Create a second user following the same steps as before

6. Utilize the Feature Flag
   1. Open `app/controllers/application_controller.rb` and `app/views/application/home.html.slim` in your text editor. You should see how to interact with the database in the controller and create accessible variables for the view file to use in rendering
   2. Open a second terminal window/tab and navigate to the application directory
   3. Start the rails console by executing `bundle exec rails c`. You may exit by typing `exit`
   4. In the rails console, you can run the following to modify the feature flag we created when we seeded the database
   ```
   ff = FeatureFlag.first //this grabs the first feature flag from the db (id:1)
   ff.value = true //here we're setting the flag value to true (ON)
   ff.save //this saves the changes you just made to the database
   ```
    1. Refresh the page and take a look at the welcome message!

7. Assign roles to each user
   1. In the rails console, run the following:
   ```
   user1 = User.first //get the first user you created
   user2 = User.second //get the second user you created
   user1.roleId = 1 //assign user 1 to role 1
   user2.roleId = 2 //assign user 2 to role 2
   user1.save //save both changes to database
   user2.save

   role1 = user1.role //easy way to access the first user's role
   role1.userWelcomeFeatureFlagValue = true //set the user level feature flag to true
   role1.save //save change to database
   ```

8. Utilize roles to dictate which users can see the new feature
   1. Now that the users have roles, you can modify the code in the `application_controller.rb` file to utilize the role level value for the flag instead of the feature flag itself. 
   
      *Hint: you can use &. to safely access objects that might be null (ex: `curent_user&.role` will return nil instead of fail if a user isn't signed in)*

   2. Open an incognito window and sign in with the second user you created. Notice the difference in behavior.

9.  Change Feature Flag mode to override role level values - up to this point, we have been keying off of the feature flag's value. Now that we have values set for different user groups, we can use those in addition to the feature flag's setting. When the feature flag's mode is set to "Default", then we will look to the user group's setting for this feature flag to determine what value to use. Default implies that the feature flag's value is used if the user group does not have a value set for this feature flag.
   3.  In `application_controller.rb`, modify the code so that the role value for the feature flag is only used if the Feature Flag's mode is set to "Default"
   4.  Ensure the behavior for each user is the same as it was before since the flag's mode value is currently set to "Default"
   5.  In the rails console, modify and save the FeatureFlag's value so that it is anything other than Default ("Override" and "Global" are common terms to use -- this means that the feature flag's value will take priority over the user group's value for the feature flag)
   6.  Refresh the web page for both users. The behavior should be the same!
