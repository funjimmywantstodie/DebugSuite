local run, err = loadfile("DebugSuite.lua")
assert(run, err)
return run()
