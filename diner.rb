require 'sinatra'
require 'redis'
require 'json'

redis = Redis.new

get '/:key' do
  key     = params[:key]
  command = params[:command]
  element = params[:element]

  if command == 'card'
    value = redis.zcard(make_key(key))
    res = { "cardinality" => value }
  elsif command == 'rank'
    rank = redis.zrank(make_key(key), element)
    res = { "element" => element, "rank" => rank }
  elsif command == 'score'
    score = redis.zscore(make_key(key), element)
    res = { "element" => element, "score" => score }
  end

  res.to_json
end

post '/:key' do
  key     = params[:key]
  command = params[:command]
  element = params[:element]
  score   = params[:score]

  if command == 'increment'
    redis.zincrby(make_key(key), score, element)
    { "element" => element, "incremented_by" => score }.to_json
  end
end

private
def make_key(key)
  'diner:' + key
end
