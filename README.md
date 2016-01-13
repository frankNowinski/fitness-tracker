# Fitness Tracker
Fitness Tracker is a simple Sinatra application that allows a user to create, update, and monitor fitness goals. The user, once signed up and logged in, can create either a weekly fitness goal or a general fitness goal. When creating a new goal, the user inputs the amount of time in minutes they plan on working out each muscle. After a workout, the user inputs the duration of their workout and the particular muscle group they worked on. That value is then deducted from the value associated with that muscle in their original fitness goal.

## Usage
To use this app, just clone, run rake db:migrate and then run shotgun. Everything should be set up.

## Contributing

1. Fork it!
2. Create your feature branch: git checkout -b my-new-feature
3. Commit your changes: git commit -am 'Add some feature'
4. Push to the branch: git push origin my-new-feature
5. Submit a pull request :D
