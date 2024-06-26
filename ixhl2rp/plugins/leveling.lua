local PLUGIN = PLUGIN
PLUGIN.name = "Leveling"
PLUGIN.author = "Scrat Knapp"
PLUGIN.desc = "A very simple leveling system."

ix.char.RegisterVar("Level", {
    field = "level",
    fieldType = ix.type.number,
    default = 1,
    isLocal = true,
    bNoDisplay = true
})

ix.char.RegisterVar("XP", {
    field = "xp",
    fieldType = ix.type.number,
    default = 0,
    isLocal = true,
    bNoDisplay = true
})

ix.char.RegisterVar("XPToNextLevel", {
    field = "xptonextlevel",
    fieldType = ix.type.number,
    default = 250,
    isLocal = true,
    bNoDisplay = true
})

ix.char.RegisterVar("LifetimeXP", {
    field = "lifetimexp",
    fieldType = ix.type.number,
    default = 0,
    isLocal = true,
    bNoDisplay = true
})

ix.char.RegisterVar("NoLevel", {
    field = "nolevel",
    fieldType = ix.type.boolean,
    default = false,
    isLocal = true,
    bNoDisplay = true
})

ix.command.Add("CharSetNoLevel", {
	adminOnly = true,
	arguments = {
		ix.type.character,
		ix.type.bool,
	},
	OnRun = function(self, client, target, nolevel)
		
		target:SetNoLevel(nolevel)
		
		if (target:GetNoLevel() == true) then
			return client:Notify(target:GetName() .. "has been set to be exempt from leveling.")
		end

		if (target:GetNoLevel() == false) then
			return client:Notify(target:GetName() .. "has been set to allow leveling.")
		end
	end
})

ix.command.Add("CharRewardXP", {
    description = "Add XP to a character.",
    adminOnly = true,
    arguments = {
    ix.type.character, 
    ix.type.number},
    OnRun = function(self, client, target, points)

        if (target:GetNoLevel() == true) then 
            return "Character is set to be exempt from experience and levelups."
        end 

        if (points <= 0) then
            return "Cannot give zero or negative XP."
        end 

        local currentxp = target:GetXP()
        local currentlifetimexp = target:GetLifetimeXP()
        local currentlevel = target:GetLevel()
        local currentskillpoints = target:GetSkillPoints()

        if (currentlevel == 5) then
            return "Character is max level."
        end 

        target:SetXP(currentxp + points)
        target:SetLifetimeXP(currentlifetimexp + points)

        if (target:GetXP() >= target:GetXPToNextLevel()) then 
            target:SetLevel(currentlevel + 1)

            if (target:GetLevel() == 5) then
                target:SetXP (target:GetXP() - target:GetXPToNextLevel())
                target:SetXPToNextLevel(target:GetXPToNextLevel() * 1.20)
                target:SetXPToNextLevel(math.floor(target:GetXPToNextLevel()))
                target:SetSkillPoints(target:GetSkillPoints() + 5)
    
                client:Notify(target:GetName() .. " has gained " .. points .. " XP and has reached the maximum Level of " .. target:GetLevel() .. "!")
                target:GetPlayer():NewVegasNotify("You receive " .. points .. " XP, and reach the maximum " .. target:GetLevel().. "! No more XP can be gained." ,"messageNeutral", 8)
                return
            end 


            target:SetXP (target:GetXP() - target:GetXPToNextLevel())
            target:SetXPToNextLevel(target:GetXPToNextLevel() * 1.20)
            target:SetXPToNextLevel(math.floor(target:GetXPToNextLevel()))
            target:SetSkillPoints(target:GetSkillPoints() + 5)

            

            client:Notify(target:GetName() .. " has gained " .. points .. " XP and has reached Level " .. target:GetLevel() .. "!")
            target:GetPlayer():NewVegasNotify("You receive " .. points .. " XP, and reach Level " .. target:GetLevel().. "!" ,"messageNeutral", 8)

        else 
            client:Notify(target:GetName() .. " has gained " .. points .. " XP.")
            target:GetPlayer():NewVegasNotify("You receive " .. points .. " XP!", "messageNeutral", 8)
        end 
        

    end
})
