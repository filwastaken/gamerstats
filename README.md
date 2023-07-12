# README

* Software version:
    - Ruby version: ruby 2.7.2p137 (2020-10-01 revision 5445e04352) [x86_64-linux].
    - Rails version: Rails 6.1.7.4.
    - Redis version: Redis server v=7.0.11 sha=af64a2e9:1 malloc=jemalloc-5.2.1 bits=64 build=24fa9c7847da6d28.
    - Sidekiq version: Sidekiq 6.5.9.
    - Cucumber version: 8.0.0.

* Database creation:
    In order to create the database you must use the executable file ./cucumber, in particular you can call it with argument -D (or -database) to create the database from scratch. Otherwise you can use -D -R (or -database -restore) to restore from the previous database savefile. During this process it's unwise to kill execution with Ctrl+C since there's a chance to lose both the current databse and it's backup. To save the current database instance in a backup you can use ./cucumber -C (or -create). Be aware that this will delete the previous backup, however there's 6 seconds where you can stop this process safely. Calling this file without any arguments will start the process of testing the rails app, by calling rails and redis as background jobs (with output redirected to /dev/null) and calling cucumber afterwards.

* Seed:
    In seed.rb there are two commented sections: main and test. By writing items between this two comments you allow ./cucumber to use them properly either in the main database or the test one.

* How to run the test suite:
    To run the test suite, you must follow the next steps:
        - Open one terminal and enter "redis-server".
        - Open a second terminal and enter "rails s".
        - Open a third terminal and enter "bundle exec cucumber".
    This way, you should be able to see the cucumber test running in the third terminal.
    When cucumber has terminated, you should see the summary at the bottom of the terminal.
    To make this simple, as already described above, you can call the "./cucumber" program. This way all the previous steps are executed automatically.

* Services:
    To run the background jobs, you need to follow the next steps:
        - Open a terminal and enter "redis-server".
        - Open a second terminal and enter "bundle exec sidekiq".
        - Open a third terminal and enter "rails s".
    This way, every time you visit the home page, 8 jobs will be scheduled. Those will search for new users to add to the database by using the Battlenet API.

    You can also call all these jobs defined above by using ./server.