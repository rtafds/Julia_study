# Oxygen provides some out-of-the-box serialization & deserialization for most objects but requires the use of StructTypes when converting structs
using Oxygen
using HTTP
using StructTypes

struct Animal
    id::Int
    type::String
    name::String
end

# Add a supporting struct type definition so JSON3 can serialize & deserialize automatically
StructTypes.StructType(::Type{Animal}) = StructTypes.Struct()

@get "/get" function(req::HTTP.Request)
    # serialize struct into JSON automatically (because we used StructTypes)
    return Animal(1, "cat", "whiskers")
end

@post "/echo" function(req::HTTP.Request)
    # deserialize JSON from the request body into an Animal struct
    animal = json(req, Animal)
    # serialize struct back into JSON automatically (because we used StructTypes)
    return animal
end

# start the web server
serve()

# POST COMMAND example
#curl -X 'POST' \
#'http://127.0.0.1:8080/echo' \
#-H "Content-Type: application/json" \
#-d '{"id":2,"type":"dog","name":"aaa"}'