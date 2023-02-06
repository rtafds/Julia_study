(pwd() != @__DIR__) && cd(@__DIR__) # allow starting app from bin/ dir

using Example01
const UserApp = Example01
Example01.main()
