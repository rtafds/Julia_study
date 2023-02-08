# Request handlers are just functions, which means there are many valid ways to express them
#  Request handlers don't have to be defined where the routes are. They can be imported from other modules and spread across multiple files
#  Just like the request handlers, routes can be declared across multiple modules and files

# いろんな書き方ができる
using Oxygen

# 以下の四つは全く処理になる。
@get "/greet" function()
    "hello world!"
end

@get "/saluer" () -> begin
    "Bonjour le monde!"
end
# -> は無名関数
# https://mashiroyuya.hatenablog.com/entry/julia_anonymousfunction
@get "/saludar" () -> "¡Hola Mundo!"
@get "/salutare" f() = "ciao mondo!"

# This function can be declared in another module
function subtract(req, a::Float64, b::Float64)
  return a - b
end

# register foreign request handlers like this
@get "/subtract/{a}/{b}" subtract

# start the web server
serve()

