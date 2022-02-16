using SimpleCSV

using Test
using Profile
using PProf

x = [[1,2], [3,4]]

@testset "SimpleCSV" begin

  @testset "fast" begin
    # once to warm up...
    SimpleCSV.Fast.serialize(stdout, x)

    # ...and once under profiler
    Profile.Allocs.clear()
    Profile.Allocs.@profile sample_rate=1 SimpleCSV.Fast.serialize(stdout, x)
    PProf.Allocs.pprof(out="fast", web=false)
  end

  @testset "slow" begin
    # once to warm up...
    SimpleCSV.Slow.serialize(stdout, x)

    # ...and once under profiler
    Profile.Allocs.clear()
    Profile.Allocs.@profile SimpleCSV.Slow.serialize(stdout, x)
    PProf.Allocs.pprof(out="slow", web=false)
  end
end
