using SimpleCSV

using Test
using Profile
using PProf

# x = [[1,2], [3,4]]
x = [collect(1:100) for i in 1:100]

@testset "SimpleCSV" begin

    @testset "fast" begin
        # once to warm up...
        path, io = mktemp()
        SimpleCSV.Fast.serialize(io, x)

        # ...and once under profiler
        Profile.Allocs.clear()
        path, io = mktemp()
        @time Profile.Allocs.@profile sample_rate=1 SimpleCSV.Fast.serialize(io, x)
        PProf.Allocs.pprof(out="fast", web=false)
    end

    @testset "slow" begin
        # once to warm up...
        path, io = mktemp()
        SimpleCSV.Slow.serialize(io, x)

        # ...and once under profiler
        path, io = mktemp()
        Profile.Allocs.clear()
        @time Profile.Allocs.@profile sample_rate=1 SimpleCSV.Slow.serialize(io, x)
        PProf.Allocs.pprof(out="slow", web=false)
    end

    # to diff the two profiles:
    #
    # $ cd test
    # $ pprof -http localhost:1234 -relative_percentages=false -diff_base slow.pb.gz fast.pb.gz
end
