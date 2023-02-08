# Create a web-server with very few lines of code
# 最小のサンプル
using Oxygen
using HTTP

@get "/greet" function(req::HTTP.Request)
    return "hello world!"
end

# start the web server
serve()