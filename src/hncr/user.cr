require "http/client"
require "json"

module HN
  struct User
    def initialize(id : String, &block)
      yield get_user(id)
    end

    private def get_user(id)
      user_json = JSON.parse (HTTP::Client.get "https://hacker-news.firebaseio.com/v0/user/#{id}.json").body
    end
  end
end
