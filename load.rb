require 'csv'
require 'elasticsearch'

client = Elasticsearch::Client.new

client.indices.delete index: :tweets if client.indices.exists? index: :tweets
client.indices.create index: :tweets
client.indices.put_mapping index: :tweets, type: :tweet, body: {
  tweet: {
    properties: {
      text: {
        type: :text,
        fielddata: true,
        analyzer: :kuromoji
      }
    }
  }
}
# read csv and put to elasticsearch
CSV.foreach('./data/tweets.csv', headers: true) do |row|
  # exclude mentions and retweets
  next unless row['in_reply_to_status_id'].empty?
  next unless row['in_reply_to_user_id'].empty?
  next unless row['retweeted_status_id'].empty?
  next unless row['retweeted_status_user_id'].empty?
  body = {
    text: row['text'].gsub(URI.regexp, ''), # remove URLs
    timestamp: DateTime.parse(row['timestamp'])
  }
  client.index index: :tweets, type: :tweet, id: row['tweet_id'], body: body
end
