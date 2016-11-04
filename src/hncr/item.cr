require "./categories"
require "http/client"
require "json"

module HN
  class Item
    private getter :item_channel
    @item_channel = Channel(JSON::Any).new

    def initialize(type : String, count : Int32, &block)
      Categories.parse(type)
      rescue ArgumentError
        raise ArgumentError.new("#{type} is not a category!")
      else
        get_item_json(type, count)
        count.times do
          yield item_channel.receive
        end
    end

    private def get_item_json(type, count)
      item_json = JSON.parse (HTTP::Client.get "https://hacker-news.firebaseio.com/v0/#{type}stories.json").body
      (item_json.size - count).times do
        item_json.as_a.pop
      end
      item_json.each do |item_id|
        spawn do
          while response = HTTP::Client.get "https://hacker-news.firebaseio.com/v0/item/#{item_id}.json"
            item_channel.send JSON.parse response.body
          end
        end
      end
    end
  end
end
