# Similar to @staticfiles, this macro mounts each path and re-reads the file for each request. 
# This means that any changes to the files after the server has started will be displayed.

using Oxygen

# mount all files inside the "content" folder under the "/dynamic" path
@dynamicfiles("content", "dynamic")

# start the web server
serve()