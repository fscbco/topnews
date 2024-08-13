# Denzil Kriekenbeek take home exercise

## Installation problems on Apple M1 Mac Book Air, Sonoma 14.4.1 (23E224)

### nio4r gem failing bundle install:
  ```
  gem install nio4r -v 2.5.8 -- --with-cflags="-Wno-incompatible-pointer-types"
  ```

### Postgres gem install failing bundle install due to Postgres not being installed:
  ```
  brew install postgresql
  brew services start postgresql@14
  ```

### Wrong version of OpenSSL being used when building Ruby 3.1.2 with ruby-install
  Add to .zshrc
  ```
    export PATH="/opt/homebrew/opt/openssl@1.1/bin:$PATH"
    export LIBRARY_PATH="$LIBRARY_PATH:/opt/homebrew/opt/openssl@1.1/lib/"
    export RUBY_CONFIGURE_OPTS="--with-openssl-dir=$(brew --prefix openssl@1.1)"
  ```
  `ruby-install ruby-3.1.2`

## Initial Impressions:
- The Hacker News API requires N+1 requests to populate a page, we'll have to do some significant caching to make this tolerable.

- 1st step would be to refresh my memory by reading
https://guides.rubyonrails.org/caching_with_rails.html

- Might need to enable development (in memory) cache with bin/rails dev:cache, but this would mean production would need an alternate memory store (memcached?). No need to decide now.

## Random thought livestream:

- Any time an API is involved, I reach for the VCR gem; it mocks out external API calls, allowing for deterministic unit tests. Incidentally, while reading the docs, noticed that the supported Typhoeus library can handle parallel requests. Seems applicable to this problem.

- There's a nagging deprecation warning that seems easily fixable.

- Login/logout is the first requirement, and I see the devise gem in the gemfile, so let's get that working next.

- Heh, didn't realize the User table already had all the devise columns until I went to create a migration. *facepalm*  As an aside, I was going to add the annotate gem for easy schema reference.

- Now that we can guarantee that users are logged in, the next step is to retrieve Hacker News entries via its API. Will brute force the N+1 request first, then iterate from there.

- My plan is to create a "repository" to abstract away all this API work. But in good TDD practice, I'll start by writing a failing test that lets me design my interface.

- Hmm, the API has an "ask" item that is unhelpfully tagged also typed as a "story". The only difference I see is that an "ask" has a text field, where a real "story" does not. But I suppose for this exercise we only care about titles.

- Whoops neglected this file: Got my brute force scraper working. Piped that output to home page. Added a like button to each row... Next step is to make it do something, which involves creating table for this data to live in.

- I added low level cacheing for the scrape results. The likes would have to be dynamic, so there would have to be some collation of the data sets. Hence the introduction of my collator classes.  I realized that the home page's cache expiration would have to be on the order of minutes, whereas each individual story details cache could live for days.  As a result, every piece of information should only be loaded once, keeping our bandwidth low at the expense of some cache space.

- I was considering doing some partial render caching as well, but I also wanted to submit it before EOW :)

- I'm also glad to have included the typhoeus gem to do parallel fetches, which should prevent a heavy waterfall on initial page load.


## Final Thoughts:
- This was a really fun exercise! I haven't used Rails 7 before, so I took the opportunity to acquaint myself with how Stimulus worked. I'm happy with the resulting "SPA"-like experience. I think you'll see that I'm very test driven, and I like to build facades of abstraction that make making tweaks later easier. After building all the tools I needed for the home page, I was able to build the liked page in a few minutes.  Thank you, and I hope to hear from you soon!

Sincerely,
-Denzil
