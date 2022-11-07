# Challenge Warner Hurtado Laguna
Challenge code for junior fullstack LTV.
<br/>
- For the development of this challenge, all the proposed challenges were successfully completed, complying with all the characteristics and passing the previously defined tests. 
- For the controller file and the model file I used all the predefined functions where inside each function I added the logic. I created a migration to add a new column for the "short_urls" table, this new column is called "url_code", where the URL code is stored. 
- To understand the logic of the code I used the predefined tests as guides to know what logic was needed to develop the challenge. 
- For the short_code function I have used a logic that allows to send the id of the URL stored in the database and this method will return the encoded id. This is possible because it is using base62, this allows to create combinations using the set of characters 0-9, a-z, and A-Z. I don't need to decode the code when I want to click because the short code is stored in the database, when I want to go to another link I just enter the code and the system redirects to the web page. Inside the function of the shortener first it is validated if the id that is being sent is not null, then there is a while that will work if the number is positive, then the result variable gets the result of the Modular Operator of the varialbe number between 62, then the character in that position will be stored in the variable url_code, finally the number is divided with 62 and rounded down and if the number is greater than 0 continues in the while, otherwise, the function ends.

# Intial Setup

    docker-compose build
    docker-compose up mariadb
    # Once mariadb says it's ready for connections, you can use ctrl + c to stop it
    docker-compose run short-app rails db:migrate
    docker-compose -f docker-compose-test.yml build

# To run migrations

    docker-compose run short-app rails db:migrate
    docker-compose -f docker-compose-test.yml run short-app-rspec rails db:test:prepare

# To run the specs

    docker-compose -f docker-compose-test.yml run short-app-rspec

# Run the web server

    docker-compose up

# Adding a URL

    curl -X POST -d "full_url=https://google.com" http://localhost:3000/short_urls.json

# Getting the top 100

    curl localhost:3000

# Checking your short URL redirect

    curl -I localhost:3000/abc
