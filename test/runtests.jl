using SimpleCSV

x = [[1,2], [3,4]]

@time SimpleCSV.Fast.serialize(stdout, x)

@time SimpleCSV.Slow.serialize(stdout, x)
