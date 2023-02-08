# Disabling the internal logger can provide some massive performance gains, which can be helpful in some scenarios. 
# Anecdotally, i've seen a 2-3x speedup in serve() and a 4-5x speedup in serveparallel() performance.

# This is how you disable internal logging in both modes
serve(access_log=nothing)
serveparallel(access_log=nothing)
