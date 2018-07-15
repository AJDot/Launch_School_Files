# Week 8

## Assignment: Admin views payments (Webhooks)

Use [RequestBin](https://requestb.in/) to test what an HTTP client is sending. Good for inspecting and debugging webhook requests.

Use the `stripe_event` gem to handle this in Rails.

User [Rspec Request Spec](https://relishapp.com/rspec/rspec-rails/v/2-99/docs/request-specs/request-spec) to test this.

I had a bunch of trouble getting the `stripe_event` gem to work so I ended up making a controller to handle the incoming webhooks from Stripe. I followed this article (https://www.grok-interactive.com/blog/handling-stripe-webhooks-in-rails/) and used [ngrok](https://ngrok.com/download) to do the response forwarding. I needed to use this in my tests as well, not just the locally hosted app.

## Advanced Search with Elasticsearch

No matter if you are building a social network, an e-commerce platform, or a content management system, as long as your application is user facing and has a lot of data, searching is going to be a core feature for user to find necessary content. Think Amazon, Airbnb, Github, EBay, Quora, Youtube, Facebook, Pinterest - just about any populate site you can think of, they all have a search bar on the top.

We have built a simple search previously in the course, in the next several assignments, we're going to walk you through how to build "industrial strength" advanced search features into your app with Elasticsearch.

Before you try to understand what Elasticsearch is and how to use it, let's first talk about why we need to have a dedicated piece of software for performing searches in the first place. In other words, why we can't just rely on doing SQL queries in our database?

* First, search is not an easy feature. Sure, if you can restrict searching to only one field of one data model, it may not be too hard to do on your own. But what if your users want full text search, support for double quotes for phrases, wildcard queries, and AND, OR, NOT keywords with ranked results? Because searching is often at the core of a product and compromising functionality is going to be hard to justify, you'll soon find yourself tasked to build a Google.

* Another reason for a dedicated search infrastructure like Elasticsearch is that for a good user experience, search has a high level of performance (near real time) and scaling requirements. This may be especially challenging if the data being searched is stored in different database tables or even different databases. In such cases we'd have to either first join database tables then perform the search, or search in different targets separately then combine the results. But either way, it involves a lot of in-time computation and slows down fast with increasing data volume.

* Elasticsearch is built on top of Apache Lucene, which is a full text search engine. On top of Lucene, Elasticsearch provides a document store for data storage, RESTful APIs for querying and distributed infrastructure for high availability and performance. With the document store storage, we can structure data in the same way that we want to be retrieved and used - for example in MyFlix, if we wish our video search to return results with video, reviews and user (last reviewer's name, for example) information, which are stored in 3 tables in the production database, we would store them together as JSON documents and send them to Elasticsearch as new videos or reviews are added. Elasticsearch will index those data with searchable terms, and when we submit queries, we'll get back data assembled in the exact format that we need them. Elasticsearch can also be configured to run on clusters to take care of scalability requirements.

## Elastic Search: Installation

#### Linux and Windows
Make sure you have Java (JVM) 1.7+ installed on your machine. Visit this link: https://www.elastic.co/downloads/elasticsearch and download the Elasticsearch distribution.

To run Elasticsearch, on Linux `bin/elasticsearch`, on Windows `bin/elasticsearch.bat`.

Or install with package using this guide: https://www.elastic.co/guide/en/elasticsearch/reference/current/deb.html.

This is very confusing. I couldn't get it to work by testing `curl -X GET http://localhost:9200`.

I tried changing permissions of a bunch of files but still got errors. Eventually I did this:

#### Getting ElasticSearch to Run Locally
Set `ES_HOME` environment variable for ease of use.
```
export ES_HOME='/usr/share/elasticsearch'
```

I put this in `~/.bash_profile`. This is of course assuming the elasticsearch debian package was install as this will be its location.

Ran `service elasticsearch start` and had to input my computer password. Then ran:
```
$ES_HOME/bin/elasticsearch
```

I thought this would do it but no such luck, at least not by trying to run in manually using `$ES_HOME/bin/elasticsearch`. Try `service elasticsearch status` and a report should be given to you, something like this:
```bash
● elasticsearch.service - Elasticsearch
   Loaded: loaded (/usr/lib/systemd/system/elasticsearch.service; disabled; vendor preset: enabled)
   Active: active (running) since Fri 2018-03-02 07:39:07 EST; 1min 38s ago
     Docs: http://www.elastic.co
 Main PID: 8850 (java)
   CGroup: /system.slice/elasticsearch.service
           └─8850 /usr/bin/java -Xms1g -Xmx1g -XX:+UseConcMarkSweepGC -XX:CMSInitiatingOccupancyFraction=75 -XX:+UseCMSInitiatingOccupancyOnly -XX:+AlwaysPreTouch -

Mar 02 07:39:07 BarkBark systemd[1]: Started Elasticsearch.
```

Now an extra check to make sure:
```bash
$ curl -X GET http://localhost:9200
# The output
{
  "name" : "v-EkKKG",
  "cluster_name" : "elasticsearch",
  "cluster_uuid" : "BOUx-s2BRm6nAOsx1TmqNQ",
  "version" : {
    "number" : "6.2.2",
    "build_hash" : "10b1edd",
    "build_date" : "2018-02-16T19:01:30.685723Z",
    "build_snapshot" : false,
    "lucene_version" : "7.2.1",
    "minimum_wire_compatibility_version" : "5.6.0",
    "minimum_index_compatibility_version" : "5.0.0"
  },
  "tagline" : "You Know, for Search"
}
```

I guess this means it's working.

## Set up Elasticsearch with Rails

#### Development and Local Test Environments
For the MyFlix project, we will be using Elasticsearch's Ruby clients - but more exactly these gems:

```
elasticsearch-model
elasticsearch-rails
```

add those two gems to your Gemfile:

...
gem 'elasticsearch-model'
gem 'elasticsearch-rails'
...
and run

```
bundle install
```

For development and test environments, we are set with local installation, however make sure you are always running Elasticsearch server on ports between 9200 - 9300, and you should be fine.

#### Continuous Deployment Environment on CircleCI

For CircleCI, we will have to update the circle.yml file. It is possible to use other versions of Elasticsearch on Circle, but using CircleCI's default version of Elasticsearch will be fine for our purposes.

**THIS WAS FOR CIRCLE CI 1.0**
```yml
machine:
  ruby:
    version: 2.1.6
  services:
    - elasticsearch
deployment:
  production:
    branch: master
    commands:
      - heroku maintenance:on --app production_app_name
      - heroku pg:backups capture --app production_app_name
      - git push git@heroku.com:production_app_name.git $CIRCLE_SHA1:refs/heads/master
      - heroku run rake db:migrate --app production_app_name
      - heroku maintenance:off --app production_app_name
  staging:
    branch: staging
    commands:
      - heroku maintenance:on --app staging_app_name
      - git push git@heroku.com:staging_app_name.git $CIRCLE_SHA1:refs/heads/master
      - heroku run rake db:migrate --app staging_app_name
      - heroku maintenance:off --app staging_app_name
```

**THIS IS FOR CIRCLE CI 2.0**
```yml
version: 2
jobs:
  test-job:
    docker:
      - image: circleci/ruby:2.2.9-node-browsers
        environment:
          - RAILS_ENV: test
          - PGHOST: 127.0.0.1
          - PGUSER: root
          - PGPASSWORD: ""

      - image: circleci/postgres:9.6
        environment:
          - POSTGRES_USER: root
          - POSTGRES_DB: myflix_test
          - POSTGRES_PASSWORD: ""

      - image: circleci/elasticsearch

    working_directory: ~/myflix

    steps:
      - checkout

      # Download and cache dependencies
      - restore_cache:
          keys:
          - v1-dependencies-{{ checksum "Gemfile.lock" }}
          # fallback to using the latest cache if no exact match is found
          - v1-dependencies-

      - run:
          name: install dependencies
          command: |
            bundle install --jobs=4 --retry=3 --path vendor/bundle

      - save_cache:
          paths:
            - ./vendor/bundle
          key: v1-dependencies-{{ checksum "Gemfile.lock" }}

      # Database setup
      - run: mv config/database.ci.yml config/database.yml
      - run: bundle exec rake db:create
      - run: bundle exec rake db:schema:load

      # run tests!
      - run:
          name: run tests
          command: |
            mkdir /tmp/test-results
            TEST_FILES="$(circleci tests glob "spec/**/*_spec.rb" | circleci tests split --split-by=timings)"

            bundle exec rspec --format progress \
                            --format RspecJunitFormatter \
                            --out /tmp/test-results/rspec.xml \
                            --format progress \
                            $TEST_FILES
      # collect reports
      - store_test_results:
          path: /tmp/test-results
      - store_artifacts:
          path: /tmp/test-results
          destination: test-results

  production-deploy:
    machine: true
    steps:
      - checkout
      - run:
          name: Run setup script
          command: bash .circleci/setup-heroku.sh
      - add_ssh_keys:
          fingerprints:
            - "b0:01:cb:56:32:7d:3c:58:5c:11:c3:c3:f3:0b:1d:35"
      - run:
          name: Deploy Master to Heroku
          command: |
            git fetch
            heroku maintenance:on --app ah-myflix
            heroku pg:backups capture --app ah-myflix
            git push git@heroku.com:ah-myflix.git $CIRCLE_SHA1:refs/heads/master
            heroku run rake db:migrate --app ah-myflix
            heroku maintenance:off --app ah-myflix

  staging-deploy:
    machine: true
    steps:
      - checkout
      - run:
          name: Run setup script
          command: bash .circleci/setup-heroku.sh
      - add_ssh_keys:
          fingerprints:
            - "b0:01:cb:56:32:7d:3c:58:5c:11:c3:c3:f3:0b:1d:35"
      - run:
          name: Deploy Staging to Heroku
          command: |
            git fetch
            heroku maintenance:on --app ah-myflix-staging
            git push git@heroku.com:ah-myflix-staging.git $CIRCLE_SHA1:refs/heads/master
            heroku run rake db:migrate --app ah-myflix-staging
            heroku maintenance:off --app ah-myflix-staging

workflows:
  version: 2
  test-deploy:
    jobs:
      - test-job
      - production-deploy:
          requires:
            - test-job
          filters:
            branches:
              only: master
      - staging-deploy:
          requires:
            - test-job
          filters:
            branches:
              only: staging
```

#### Production Environment on Heroku
For Heroku - we will be using the SearchBox add-on. It has a free tier which gives us 2 indices and an unlimited amount of documents up to 5 MB size.

To install the add-on: (you may need to do this on both staging and production servers)

**UPDATED**
```
heroku addons:create searchbox:starter
```
Don't use searchbox's guide for Rails installation as we will use different setup.

#### Add initializer in the MyFlix app
The best way to set up the Elasticsearch client is to create an initialize:

`config/initializers/elasticsearch.rb`

```ruby
Elasticsearch::Model.client =
  if Rails.env.staging? || Rails.env.production?
    Elasticsearch::Client.new url: ENV['SEARCHBOX_URL']
  elsif Rails.env.development?
    Elasticsearch::Client.new log: true
  else
    Elasticsearch::Client.new
  end
```

For the development environment, we will use the `log: true` option to see whether our app communicates with Elasticsearch server, however for the test environment this option would generate a lot of extra noise.

For the staging and production environments - the `SEARCHBOX_URL` will be set with SearchBox addon installation, so you don't have to worry about it.

## Watch the Elasticsearch Getting Started Seminar
Use the link below. You can skip the first 20 minutes where he talked about installation and configuration. It's a great intro - even though it is not in the context of Ruby or Rails apps. But the basic queries are very similar.

https://info.elastic.co/2016-03-AB-Test-Getting-Started-ES_Video.html

Watch this to get an idea of the elasticsearch's APIs and basic features. You don't have to memorize everything, but just to get to understand the product. We'll dive deeper into it and show you how to use it in your Rails app in the next several topics.

https://github.com/elastic/elasticsearch-rails
```ruby
include Elasticsearch::Model
# add active record callbacks on model to elasticsearch is always synced
include Elasticsearch::Model::Callbacks
```

Use
```ruby
response.records.to_a
```

to get an active record array of results. (where `response` is the result from a search.)


## Rails Serialization
Turning an object into a string (to send over the wire). We need to communicate with the elastic search server which can be on a different machine. We have to turn the model into the json format, then we can send it to the elastic search server to store.

JSON format is most commonly used.

`#to_json` method provided by Rails
```ruby
video = Video.first
video.to_json
# => "{\"id\":1,\"title\":\"Monk\",\"description\":\"Adrian Monk is a brilliant San Francisco detective, whose obsessive compulsive disorder just happens to get in the way.\",\"created_at\":\"2018-02-26T14:07:00.429Z\",\"updated_at\":\"2018-02-26T14:07:00.429Z\",\"category_id\":2,\"large_cover\":{\"url\":\"/uploads/video/large_cover/1/monk_large.jpg\"},\"small_cover\":{\"url\":\"/uploads/video/small_cover/1/monk.jpg\"},\"video_url\":null}"
```

In Rails we may not want everything on the object to be converted to json. Can use `as_json` method on the model to customize this. We only want to send to elastic search server the data we will use to do the searching. The less data to look through, the faster the search will be.

```ruby
class Video < ActiveRecord::Base
  def as_json(options={})
    {title: title}
  end
end
```

Now converting to json will just do it for the title, not everything about the object.
```ruby
video = Video.first
video.to_json
# => "{\"title\":\"Monk\"}"
```

Instead of doing this explicitly we can do this:
```ruby
class Video < ActiveRecord::Base
  def as_json(options={})
    super(only: [:title])
  end
end
```

However, elastic search isn't the only external source that may need json data from the model. So we need a way to specify the attributes we just want to send to elastic search.

Do it with this
```ruby
def as_indexed_json(options={})
  # default behavior
  as_json(options)
end
```

This is provided by the `Elasticsearch::Model`

Customize it:
```ruby
def as_indexed_json(options={})
  as_json(only: [:title])
end
```

Now we can get rid of our custom `as_json` and use `as_indexed_json` to work with elasticsearch. The method above will now only send the title to elasticsearch but anyone else accessing this model as json will get everything.

## Assignment: Search Video by Title
Follow along with the previous two videos and set up Elasticsearch with the Video model so that you can search videos by their titles with Elasticsearch.

Add those tests in your `video_spec.rb` and your code should make them all pass:

```ruby
describe ".search", :elasticsearch do
  let(:refresh_index) do
    Video.import
    Video.__elasticsearch__.refresh_index!
  end

  context "with title" do
    it "returns no results when there's no match" do
      Fabricate(:video, title: "Futurama")
      refresh_index

      expect(Video.search("whatever").records.to_a).to eq []
    end

    it "returns an empty array when there's no search term" do
      futurama = Fabricate(:video)
      south_park = Fabricate(:video)
      refresh_index

      expect(Video.search("").records.to_a).to eq []
    end

    it "returns an array of 1 video for title case insensitve match" do
      futurama = Fabricate(:video, title: "Futurama")
      south_park = Fabricate(:video, title: "South Park")
      refresh_index

      expect(Video.search("futurama").records.to_a).to eq [futurama]
    end

    it "returns an array of many videos for title match" do
      star_trek = Fabricate(:video, title: "Star Trek")
      star_wars = Fabricate(:video, title: "Star Wars")
      refresh_index

      expect(Video.search("star").records.to_a).to match_array [star_trek, star_wars]
    end
  end
end
```

For all our RSpec tests that are related to Elasticsearch, we need to create the indexes on the Elasticsearch server for our Video model. The easiest way to do this is to use RSpec's tagging feature and tag all Elasticsearch related tests with a `:elasticsearch` tag, then insert this option in the RSpec.configure block:

```ruby
config.before(:each, elasticsearch: true) do
  Video.__elasticsearch__.create_index! force: true
end
```
Read more about `create_index! force: true` [here](https://github.com/elastic/elasticsearch-rails/tree/master/elasticsearch-model#index-configuration).


## Assignment: Search Video by Title and Description
Now, update the code in your Video model to implement the following search rules:

* the search will match both the `title` and `description` fields. In other words, if the search term can match a video's title or description, it's considered a match.

* when there are multiple words used for search, only results that contain all the words will be considered a match.

Add the following tests in your `video_spec.rb` and make sure they pass:

```ruby
...
context "with title and description" do
  it "returns an array of many videos based for title and description match" do
    star_wars = Fabricate(:video, title: "Star Wars")
    about_sun = Fabricate(:video, description: "sun is a star")
    refresh_index

    expect(Video.search("star").records.to_a).to match_array [star_wars, about_sun]
  end
end

context "multiple words must match" do
  it "returns an array of videos where 2 words match title" do
    star_wars_1 = Fabricate(:video, title: "Star Wars: Episode 1")
    star_wars_2 = Fabricate(:video, title: "Star Wars: Episode 2")
    bride_wars = Fabricate(:video, title: "Bride Wars")
    star_trek = Fabricate(:video, title: "Star Trek")
    refresh_index

    expect(Video.search("Star Wars").records.to_a).to match_array [star_wars_1, star_wars_2]
  end
end
...
```

You should refer to Elasticsearch's documentation on multi-match and operator:

https://www.elastic.co/guide/en/elasticsearch/reference/current/query-dsl-multi-match-query.html

## Assignment: Build Out the Entire Workflow for Advanced Search
In this assignment, you are going to build out the entire workflow for the advanced search feature, where video's title and description fields are going to be searched.

Here is a feature spec that you can work with:

```ruby
require 'spec_helper'

feature "User interacts with advanced search", :elasticsearch do

  background do
    Fabricate(:video, title: "Star Wars: Episode 1")
    Fabricate(:video, title: "Star Wars: Episode 2")
    Fabricate(:video, title: "Star Trek")
    Fabricate(:video, title: "Bride Wars", description: "some wedding movie!")
    refresh_index
    sign_in
    click_on "Advanced Search"
  end

  scenario "user searches with title" do
    within(".advanced_search") do
      fill_in "query", with: "Star Wars"
      click_button "Search"
    end

    expect(page).to have_content("2 videos found")
    expect(page).to have_content("Star Wars: Episode 1")
    expect(page).to have_content("Star Wars: Episode 2")
    expect(page).to have_no_content("Star Trek")
  end

  scenario "user searches with title and description" do
    within(".advanced_search") do
      fill_in "query", with: "wedding movie"
      click_button "Search"
    end
    expect(page).to have_content("Bride Wars")
    expect(page).to have_no_content("Star")
  end
end

def refresh_index
  Video.import
  Video.__elasticsearch__.refresh_index!
end
```

On the advanced search page, you don't have to worry about the checkbox for reviews and the option to filter movies by ratings yet. We'll build those in the next assignment. You also don't have to worry about highlighting the search terms in the results.

You'll need to have an "Advanced Search" link on the top bar - you can put it to the right of the current search button. You may need to reduce the width of the search input box so everything still fits.


## Assignment: Expand Search into Reviews
Let's now expand our search into reviews as well, so that if a video has a review which contains a match for the search term, we'll return that video as well.

Since we are now searching against three fields (two fields in the Video model and one in the Review model), we're going to use a very simple rule for how the search results are ordered: matches with video titles will have the most weight, then the matches against video descriptions, and finally matches against videos' reviews. Specifically, the weights for the three are going to be 100:50:1.

Hints:

Read [What is Relevance?](https://www.elastic.co/guide/en/elasticsearch/guide/current/relevance-intro.html), and [Boosting fields in multi match queries](https://www.elastic.co/guide/en/elasticsearch/reference/current/query-dsl-multi-match-query.html#_literal_fields_literal_and_per_field_boosting)
Expand `as_indexed_json` method to include reviews and body. ActiveRecord::Base's `as_json` method has a way to include the associated objects. Check it out [here](http://api.rubyonrails.org/classes/ActiveModel/Serializers/JSON.html#method-i-as_json).
Make sure when you create or update a Review object, it will update the associated Video object parent, therefore updating the video's document in Elasticsearch.
Add the following tests into your `video_spec.rb` file, in the context of the `.search` method.

```ruby
context "with title, description and reviews" do
  it 'returns an an empty array for no match with reviews option' do
    star_wars = Fabricate(:video, title: "Star Wars")
    batman    = Fabricate(:video, title: "Batman")
    batman_review = Fabricate(:review, video: batman, body: "such a star movie!")
    refresh_index

    expect(Video.search("no_match", reviews: true).records.to_a).to eq([])
  end

  it 'returns an array of many videos with relevance title > description > review' do
    star_wars = Fabricate(:video, title: "Star Wars")
    about_sun = Fabricate(:video, description: "the sun is a star!")
    batman    = Fabricate(:video, title: "Batman")
    batman_review = Fabricate(:review, video: batman, body: "such a star movie!")
    refresh_index

    expect(Video.search("star", reviews: true).records.to_a).to eq([star_wars, about_sun, batman])
  end
end
```


## Assignment: Filter with Average Rating
In this assignment, we will learn how to use filters to be able to further refine the search results by their average ratings.

First read Elasticsearch docs on what filters are and the difference between filters and queries.

* [Queries and filters](https://www.elastic.co/guide/en/elasticsearch/guide/current/_queries_and_filters.html)
* [Most important queries](https://www.elastic.co/guide/en/elasticsearch/guide/current/_most_important_queries.html)
* [Combining queries](https://www.elastic.co/guide/en/elasticsearch/guide/current/combining-queries-together.html)

Requirements and Considerations:

1. Update `as_indexed_json` method to include a video's average rating. Note that `average_rating` is not an attribute on the Video model, but instead it's computed with a method, check ActiveRecord's `as_json` documentation to see how to add such data into the serialized json.

2. Make sure we have the ability to search with either `rating_from` or `rating_to`, or both at the same time. Make it flexible!

Add the following specs into `video_spec.rb` and make them pass:

```ruby
context "filter with average ratings" do
  let(:star_wars_1) { Fabricate(:video, title: "Star Wars 1") }
  let(:star_wars_2) { Fabricate(:video, title: "Star Wars 2") }
  let(:star_wars_3) { Fabricate(:video, title: "Star Wars 3") }

  before do
    Fabricate(:review, rating: "2", video: star_wars_1)
    Fabricate(:review, rating: "4", video: star_wars_1)
    Fabricate(:review, rating: "4", video: star_wars_2)
    Fabricate(:review, rating: "2", video: star_wars_3)
    refresh_index
  end

  context "with only rating_from" do
    it "returns an empty array when there are no matches" do
      expect(Video.search("Star Wars", rating_from: "4.1").records.to_a).to eq []
    end

    it "returns an array of one video when there is one match" do
      expect(Video.search("Star Wars", rating_from: "4.0").records.to_a).to eq [star_wars_2]
    end

    it "returns an array of many videos when there are multiple matches" do
      expect(Video.search("Star Wars", rating_from: "3.0").records.to_a).to match_array [star_wars_2, star_wars_1]
    end
  end

  context "with only rating_to" do
    it "returns an empty array when there are no matches" do
      expect(Video.search("Star Wars", rating_to: "1.5").records.to_a).to eq []
    end

    it "returns an array of one video when there is one match" do
      expect(Video.search("Star Wars", rating_to: "2.5").records.to_a).to eq [star_wars_3]
    end

    it "returns an array of many videos when there are multiple matches" do
      expect(Video.search("Star Wars", rating_to: "3.4").records.to_a).to match_array [star_wars_1, star_wars_3]
    end
  end

  context "with both rating_from and rating_to" do
    it "returns an empty array when there are no matches" do
      expect(Video.search("Star Wars", rating_from: "3.4", rating_to: "3.9").records.to_a).to eq []
    end

    it "returns an array of one video when there is one match" do
      expect(Video.search("Star Wars", rating_from: "1.8", rating_to: "2.2").records.to_a).to eq [star_wars_3]
    end

    it "returns an array of many videos when there are multiple matches" do
      expect(Video.search("Star Wars", rating_from: "2.9", rating_to: "4.1").records.to_a).to match_array [star_wars_1, star_wars_2]
    end
  end
end
```


## Assignment: Build Out Advanced Search Options
In this assignment, build out the UI and the workflow so that

* user can include reviews in their advanced searches
* user can filter results by average ratings

Much of the implementations for those features are done on the model level. In this assignment you are going to update the advanced search view to include those options and be able to pass them as options into the `search` method on the Video model.

Update your feature spec with the following, and make it pass.

```ruby
...
  background do
    star_wars_1 = Fabricate(:video, title: "Star Wars: Episode 1")
    star_wars_2 = Fabricate(:video, title: "Star Wars: Episode 2")
    star_trek  = Fabricate(:video, title: "Star Trek")
    Fabricate(:video, title: "Bride Wars", description: "some wedding movie!")

    Fabricate(:review, video: star_wars_1, rating: 5, body: "awesome movie!!!")
    Fabricate(:review, video: star_wars_2, rating: 3)
    Fabricate(:review, video: star_trek,  rating: 4)
    Fabricate(:review, video: star_trek,  rating: 5)
    refresh_index
    sign_in

    click_on "Advanced Search"
  end
...

  scenario "user searches with title, description and review" do
    within(".advanced_search") do
      fill_in "query", with: "awesome movie"
      check "Include Reviews"
      click_button "Search"
    end
    expect(page).to have_content "Star Wars: Episode 1"
    expect(page).to have_no_content "Star Wars: Episode 2"
  end

  scenario "user filters search results with average rating" do
    within(".advanced_search") do
      fill_in "query", with: "Star"
      check "Include Reviews"
      select "4.4", from: "rating_from"
      select "4.6", from: "rating_to"

      click_button "Search"
    end
    expect(page).to have_content "Star Trek"
    expect(page).to have_no_content "Star Wars: Episode 1"
    expect(page).to have_no_content "Star Wars: Episode 2"
  end
....
```
