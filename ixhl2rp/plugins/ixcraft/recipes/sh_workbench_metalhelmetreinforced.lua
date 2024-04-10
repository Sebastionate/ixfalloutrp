RECIPE.name = "Metal Helmet, Reinforced"
RECIPE.description = "Reinforce a metal helmet. A lot of extra weight, but the soreness in your neck is worth its added protection."
RECIPE.model = "models/fallout/apparel/helmetmetalarmor.mdl"
RECIPE.category = "Armor"
RECIPE.requirements = {
    ["metalhelmet"] = 1,
	["metalupgrade3"] = 1,
    ["ballisticfiber"] = 1,
	["adhesive"] = 2,
}

RECIPE.results = {
	["metalhelmetreinforced"] = 1
}

RECIPE.blueprint = "blueprintmetalarmorreinforced"

RECIPE:PostHook("OnCanSee", function(recipeTable, client)
	if (client:GetCharacter():GetSkill("repair", 0) < 40) then 
		return false
	end 

	for _, v in pairs(ents.FindByClass("ix_station_workbench")) do
		if (client:GetPos():DistToSqr(v:GetPos()) < 200 * 40) then
			return true
		end
	end

	return false
	
end)


