# If you don't want to use Oxygen's default response serializer, you can turn it off and add your own! 
# Just create your own special middleware function to serialize the response and add it at the end of your own middleware chain.

# Both serve() and serveparallel() have a serialize keyword argument which can toggle off the default serializer.

using Oxygen
using HTTP
using JSON3

@get "/divide/{a}/{b}" function(req::HTTP.Request, a::Float64, b::Float64)
    return a / b
end

# This is just a regular middleware function
function myserializer(handle)
    function(req)
        try
          response = handle(req)
          # convert all responses to JSON
          return HTTP.Response(200, [], body=JSON3.write(response)) 
        catch error 
            @error "ERROR: " exception=(error, catch_backtrace())
            return HTTP.Response(500, "The Server encountered a problem")
        end 
    end
end

# make sure 'myserializer' is the last middleware function in this list
serve(middleware=[myserializer], serialize=false)