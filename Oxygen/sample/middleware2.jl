# /docs generation broken when custom middleware is set #80

using Oxygen
using HTTP

include("proto/generated/greet/route.jl")
using .Route
Route.init_routes()

function run()
    serve(port=8000, middleware=[Route.greet_middleware])
end