local network = {
    {name = "lua",      IP = "210.26.23.12"},
    {name = "derain",   IP = "203.15.26.31"}
}

table.sort(network, function(a, b) return a.name < b.name end)

for _, t in pairs(network) do
    print(t.name, t.IP)
end
