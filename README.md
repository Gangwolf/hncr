# hncr

A Hacker News API wrapper for the Crystal

## Installation

Add this to your application's `shard.yml`:

```yaml
dependencies:
  hncr:
    github: Gangwolf/hncr
    branch: master
```

## Usage

```crystal
require "hncr"

# Get ten stories of the 'top' category and print them
HN::Item.new(type: "top", count: 10) do |item|
  puts "#{ item["title"] }, by #{ item["by"] }\n#{ item["url"]? }\n\n"
end

# Get user by id and print the 'about' field 
HN::User.new(id: "jl") do |user|
  puts user["about"]
end

```
## API
###### NOTE: 
The API returns items concurrently, this means
items do not return in order. Its first response, first serve.

##### Items constructor:
`HN::Item(type, count, &block)`

* `type : String` One of the following strings for the type of story:
`new`, `top`, `best`, `ask`, `show`, or `job`. 

* `count : Int32` The number of stories to return.

* `&block` Block takes one argument that returns a JSON::Any struct
containing the item's json fields.

##### User constructor:
`HN::User(id, &block)`

* `id : String` The id of the user.

* `&block` Block takes one argument that returns a JSON::Any struct
containing the user's json fields.

## Contributing

1. Fork it ( https://github.com/Gangwolf/hncr/fork )
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request

## Contributors

- [Dan](https://github.com/Gangwolf) - creator, maintainer
