ITEM.name = "Gecko Kebab"
ITEM.model = "models/fnv/clutter/food/iguanabits.mdl"
ITEM.hunger = 15
ITEM.description = "A delicious, but simple skewered dish."
ITEM.longdesc = "Diced gecko meat on a stick, alongside bits of pepper and fruit. Very tasty."
ITEM.quantity = 1
ITEM.price = 20
ITEM.width = 1
ITEM.height = 2
ITEM.sound = "fosounds/fix/npc_human_eating_food_chewy_02.mp3"
ITEM.flag = "5"
ITEM:Hook("use", function(item)
	item.player:EmitSound(item.sound or "items/battery_pickup.wav")
	item.player:addRadiation(1)
	ix.chat.Send(item.player, "iteminternal", "takes a bite of their "..item.name..".", false)
end)
ITEM.weight = 0.1


ITEM:DecideFunction()