# Middleware functions make it easy to create custom workflows to intercept all incoming requests and outgoing responses. They are executed in the same order they are passed in (from left to right).

# They can be set at the application, router, and route layer with the middleware keyword argument. All middleware is additive and any middleware defined in these layers will be combined and executed.

# Middleware will always be executed in the following order:

# application -> router -> route
# Now lets see some middleware in action:

using Oxygen
using HTTP

const CORS_HEADERS = [
    "Access-Control-Allow-Origin" => "*",
    "Access-Control-Allow-Headers" => "*",
    "Access-Control-Allow-Methods" => "POST, GET, OPTIONS"
]

# https://juliaweb.github.io/HTTP.jl/stable/examples/#Cors-Server
function CorsMiddleware(handler)
    return function(req::HTTP.Request)
        println("CORS middleware")
        # determine if this is a pre-flight request from the browser
        if HTTP.hasheader(req, "OPTIONS")  
            return HTTP.Response(200, CORS_HEADERS)  
        else 
            return handler(req) # passes the request to the AuthMiddleware
        end
    end
end

function AuthMiddleware(handler)
    return function(req::HTTP.Request)
        println("Auth middleware")
        # ** NOT an actual security check ** #
        if !HTTP.headercontains(req, "Authorization", "true")
            return HTTP.Response(403)
        else 
            return handler(req) # passes the request to your application
        end
    end
end

function middleware1(handle)
    function(req)
        println("middleware1")
        handle(req)
    end
end

function middleware2(handle)
    function(req)
        println("middleware2")
        handle(req)
    end
end

# set middleware at the router level
math = router("math", middleware=[middleware1])

# set middleware at the route level 
@get math("/divide/{a}/{b}", middleware=[middleware2]) function(req, a::Float64, b::Float64)
    return a / b
end

# set application level middleware
serve(middleware=[CorsMiddleware, AuthMiddleware])