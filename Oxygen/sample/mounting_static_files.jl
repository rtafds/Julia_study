# You can mount static files using this handy macro which recursively searches a folder for files and mounts everything. 
# All files are loaded into memory on startup.
using Oxygen

# mount all files inside the "content" folder under the "/static" path
@staticfiles("content", "static")

# start the web server
serve()