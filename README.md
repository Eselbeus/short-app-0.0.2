# Intial Setup

    docker-compose build
    docker-compose up mariadb
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

# URL shortener algorithm

    The algorithm used to convert an id into a unique url, makes use of the CHARACTERS list with numbers and letters 0-Z. The numbers navigate this list by starting with 0 and after Z, a second character is added. This makes it so there will only be a new character added once the whole list of 62 characters has been exhausted. At this point, the number of possibilities of combinations with two characters is 62 squared. You have to account for the fact that there are 62 previous characters with just one digit to find the number in terms of finding what number the id will be in terms of summing powers of 62.

    Step one is to create a while loop that determines how many characters will be in the short_code. Each time the loop checks to see if the number has been reached and it increments the count of characters. Once it is known how many characters there are, we know we need to do that many loops to generate a character for each loop. It appears easiest to deal with the first power of 62 first, so the characters are built in reverse order. Using the modulus operator on the id (-1 to account for the index position) will give the position on the CHARACTERS list since everything has been counted by multiples of powers of 62. That portion then needs to be removed from the number since it is accounted for so it is subtracted. The power of 62 is reduced by one and the loop is incremented to check the position of the next character.

    Two tests were modified to account for the using the character "0". More tests were added to check numbers up to 15018571, which is the point where the url would require 5 characters.
