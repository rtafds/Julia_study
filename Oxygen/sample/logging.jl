# Oxygen provides a default logging format but allows you to customize the format using the access_log parameter. 
# This functionality is available in both the serve() and serveparallel() functions.
# You can read more about the logging options here

# Uses the default logging format
serve()

# Customize the logging format 
serve(access_log=logfmt"[$time_iso8601] \"$request\" $status")

# Disable internal request logging 
serve(access_log=nothing)