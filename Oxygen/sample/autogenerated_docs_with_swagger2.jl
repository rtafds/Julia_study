using Oxygen
using SwaggerMarkdown

# Only the basic information is parsed from this route when generating docs
@get "/multiply/{a}/{b}" function (req, a::Float64, b::Float64)
    return a * b
end


# Here's another example of how to update a part of the schema yourself, but this way allows you to modify other properties defined at the root of the schema (title, summary, etc.)
mergeschema(
  Dict(
    "paths" => Dict(
      "/multiply/{a}/{b}" => Dict(
        "get" => Dict(
          "description" => "return the result of a * b"
        )
      )
    )
  )
)
serve()
