local item = getrenv()._G.classes.FPS.GetEquippedItem.Type
local original_ps = item.ProjectileSpeed
local original_pd = item.ProjectileDrop

hookmetamethod(getrenv()._G.classes.FPS.GetEquippedItem, "__index", function(self, index)
    if index == "ProjectileSpeed" then
        return 999999 
    elseif index == "ProjectileDrop" then
        return 0     end
    return rawget(self, index)
end)

hookmetamethod(getrenv()._G.classes.FPS.GetEquippedItem, "__newindex", function(self, index, value)
    if index == "ProjectileSpeed" or index == "ProjectileDrop" then
        rawset(self, index, original_ps) 
    else
        rawset(self, index, value)
    end
end)



	

