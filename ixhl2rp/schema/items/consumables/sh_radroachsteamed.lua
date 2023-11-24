ITEM.name = "Steamed Radroach"
ITEM.model = "models/mosi/fnv/props/food/steamedradroach.mdl"
ITEM.hunger = 25
ITEM.description = "A culinary dish made of Radroach."
ITEM.longdesc = "When in the hands of a more skilled cook, even the godawful Radroach can be considerably more palatable."
ITEM.quantity = 1
ITEM.price = 20
ITEM.width = 2
ITEM.height = 1
ITEM.sound = "fosounds/fix/npc_human_eating_food_chewy_02.mp3"
ITEM.flag = "5"
ITEM:Hook("use", function(item)
	item.player:addRadiation(5)
	item.player:EmitSound(item.sound or "items/battery_pickup.wav")
	ix.chat.Send(item.player, "iteminternal", "takes a bite of their "..item.name..".", false)
end)
ITEM.weight = 0.1
ITEM.heal = 3
ITEM.healot = 2
ITEM:DecideFunction()