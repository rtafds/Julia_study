# All objects are automatically deserialized into JSON using the JSON3 library
# JSONで返せる
using Oxygen
using HTTP

@get "/data" function(req::HTTP.Request)
    return Dict("message" => "hello!", "value" => 99.3)
end

# start the web server
serve()