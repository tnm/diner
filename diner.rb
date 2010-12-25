require 'sinatra'
require 'redis'
require 'json'

redis = Redis.new

get '/:key' do
  key = params[:key]
  command = params[:command]
  element = params[:element]

  if command == 'card'
    value = redis.zcard(make_key(key))
    data = [
        {'diner_key' => key}, 
        {"cardinality" => value}
    ].to_json

  elsif command == 'rank'
    rank = redis.zrank(make_key(key), element)
    data = [
        {'diner_key' => key}, 
        {"element" => element, "rank" => rank}
   ].to_json

  elsif command == 'score'
    score = redis.zscore(make_key(key), element)
    data = [
        {'diner_key' => key}, 
        {"element" => element, "score" => score}
  ].to_json

  end
end

post '/:key' do
  key = params[:key]
  command = params[:command]
  element = params[:element]
  score = params[:score]

  if command == 'increment'
    redis.zincrby(make_key(key), score, element)
    success = [
        {'diner_key' => key, 'status' => 'success'}, 
        {"element" => element, "incremented_by" => score}
    ].to_json
  end
end

private
def make_key(key)
  'diner:' + key
end

