require 'rspec'
require 'rack/test'
require './diner'
require 'redis'

set :environment, :test

redis = Redis.new

# test data
redis.zadd('diner:test_key', 10.0, 'bar')
redis.zadd('diner:test_key', 5.0, 'baz')
redis.zadd('diner:test_key', 2.0, 'alpha')
redis.zadd('diner:test_key', 3.0, 'beta')

describe "the Diner interface" do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  it "returns json of: the diner key, and, the cardinality of the zset" do
    get '/test_key?command=card'
    last_response.should be_ok
    last_response.body.should == "{\"cardinality\":4}"
  end

  it "returns json of the rank of the element" do
    get '/test_key?command=rank&element=bar'
    last_response.should be_ok
    last_response.body.should == "{\"element\":\"bar\",\"rank\":3}"
  end

  it "returns json of the score of the element" do
    get '/test_key?command=score&element=bar'
    last_response.should be_ok
    last_response.body.should == "{\"element\":\"bar\",\"score\":\"10\"}"
  end

  it "returns json of the number incremented by" do
    post '/testkey2', {'command' => 'increment', 'element' => 'bar2', 'score' => '20.0'}
    last_response.should be_ok
    last_response.body.should == "{\"element\":\"bar2\",\"incremented_by\":\"20.0\"}"
  end
end
