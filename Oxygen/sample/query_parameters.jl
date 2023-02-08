# Use the queryparams() function to extract and parse parameters from the url
# クエリをPOSTできる。
using Oxygen
using HTTP

@get "/query" function(req::HTTP.Request)
    # extract & return the query params from the request object
    return queryparams(req)
end

# start the web server
serve()

# POST example
#curl -X 'GET' \
#'http://127.0.0.1:8080/query?hoge=hoge' \
#-H 'accept: */*'