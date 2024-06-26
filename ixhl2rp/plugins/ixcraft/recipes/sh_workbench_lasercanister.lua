RECIPE.name = "Laser Canister"
RECIPE.description = "Create a makeshift energy battery, for use in a Homemade Laser Rifle."
RECIPE.model = "models/mosi/fallout4/ammo/flare.mdl"
RECIPE.category = "Energy Ammo"
RECIPE.requirements = {
	["tincan"] = 1,
	["acid"] = 1,
	["nuclearmaterial"] = 1,
	["adhesive"] = 1,
}

RECIPE.results = {
	["ammo_lasercanisterammo"] = 1
}


RECIPE:PostHook("OnCanSee", function(recipeTable, client)
	if (client:GetCharacter():GetSkill("science", 0) < 5) then 
		return false
	end 

	for _, v in pairs(ents.FindByClass("ix_station_workbench")) do
		if (client:GetPos():DistToSqr(v:GetPos()) < 200 * 40) then
			return true
		end
	end

	return false
	
end)


