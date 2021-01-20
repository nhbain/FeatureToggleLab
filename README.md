# Feature Toggle Lab Instructions

## Prerequisites
--- 
1. Please install the following dependencies prior to the lab
   1. [git](https://git-scm.com/)
   2. Any text editor for code (VS Code, Sublime, etc.)
   3. [Ruby Version Manager](https://rvm.io/rvm/install) (commands are copied below)
      1. `gpg --keyserver hkp://pool.sks-keyservers.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB`
      2. `\curl -sSL https://get.rvm.io | bash -s stable --ruby`
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
   2. Run `bundle install --without production`
   3. Take a look at `db/seeds.rb`. You are welcome to modify the values.
   4. Run `bundle exec rake db:setup`
   5. Run `bundle exec rake db:seed`
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
   3. Start the rails console by executing `bundle exec rails c`
   4. In the rails console, you can run the following to modify the feature flag we created when we seeded the database
   ```
   ff = FeatureFlag.first
   ff.value = true
   ff.save
   ```
    1. Refresh the page and take a look at the welcome message!

7. Assign roles to each user
   1. Open a second terminal window/tab and navigate to the application directory
   2. Open a rails console by running `bundle exec rails c`
   3. Run the following:
   ```
   user1 = User.first
   user2 = User.second
   user1.roleId = 1
   user2.roleId = 2
   user1.save
   user2.save

   role1 = user1.role
   role1.userWelcomeFeatureFlagValue = true
   role1.save
   ```

8. Utilize roles to dictate which users can see the new feature
   1. Now that the users have roles, you can modify the code in the `application_controller.rb` file to utilize the role level value for the flag instead of the feature flag itself. 
   
      *Hint: you can use &. to safely access objects that might be null (ex: `curent_user&.role` will return nil instead of fail if a user isn't signed in)*

   2. Open an incognito window and sign in with the second user you created. Notice the difference in behavior.

9.  Change Feature Flag mode to override role level values
   3.  In `application_controller.rb`, modify the code so that the role value for the feature flag is only used if the Feature Flag's mode is set to "Default"
   4.  Ensure the behavior for each user is the same as it was before since the flag's mode value is currently set to "Default"
   5.  In the rails console, modify and save the FeatureFlag's value so that it is anything other than Default ("Override" and "Global" are common terms)
   6.  Refresh the web page for both users. The behavior should be the same!

