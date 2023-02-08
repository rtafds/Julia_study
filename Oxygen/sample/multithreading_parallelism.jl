# For scenarios where you need to handle higher amounts of traffic, you can run Oxygen in a multithreaded mode. 
# In order to utilize this mode, julia must have more than 1 thread to work with. You can start a julia session with 4 threads using the command below

#julia --threads 4
# serveparallel(queuesize=1024) Starts the webserver in streaming mode and spawns n - 1 worker threads. 
# The queuesize parameter sets how many requests can be scheduled within the queue (a julia Channel) before they start getting dropped. 
# Each worker thread pops requests off the queue and handles them asynchronously within each thread.

using Oxygen
using StructTypes
using Base.Threads

# Make the Atomic struct serializable
StructTypes.StructType(::Type{Atomic{Int64}}) = StructTypes.Struct()

x = Atomic{Int64}(0);

@get "/show" function()
    return x
end

@get "/increment" function()
    atomic_add!(x, 1)
    return x
end

# start the web server in parallel mode
serveparallel()
