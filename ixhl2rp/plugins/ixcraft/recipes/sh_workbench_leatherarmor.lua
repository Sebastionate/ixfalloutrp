RECIPE.name = "Leather Armor"
RECIPE.description = "Fabricate a set of leather armor. One of the most basic forms of protection in the wasteland, leather armor offers basic protection without being overly encumbering to the wearer."
RECIPE.model = "models/thespireroleplay/items/clothes/group052.mdl"
RECIPE.category = "Armor"
RECIPE.requirements = {
	["leather"] = 6,
	["cloth"] = 2,
	["adhesive"] = 4,
}

RECIPE.results = {
	["leatherarmor"] = 1
}


RECIPE:PostHook("OnCanSee", function(recipeTable, client)
	if (client:GetCharacter():GetSkill("repair", 0) < 5) then 
		return false
	end 

	for _, v in pairs(ents.FindByClass("ix_station_workbench")) do
		if (client:GetPos():DistToSqr(v:GetPos()) < 200 * 40) then
			return true
		end
	end

	return false
	
end)


