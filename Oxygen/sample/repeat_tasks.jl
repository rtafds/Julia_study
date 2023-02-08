# The router() function has an interval parameter which is used to call a request handler on a set interval (in seconds).

#It's important to note that request handlers that use this property can't define additional function parameters outside of the default HTTP.Request parameter.

#    In the example below, the /repeat/hello endpoint is called every 0.5 seconds and "hello" is printed to the console each time.

using Oxygen

repeat = router("/repeat", interval=0.5, tags=["repeat"])

@get repeat("/hello") function()
    println("hello")
end

# you can override properties by setting route specific values 
@get repeat("/bonjour", interval=1.5) function()
    println("bonjour")
end

serve()
    