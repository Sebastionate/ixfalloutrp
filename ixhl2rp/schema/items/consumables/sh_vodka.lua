ITEM.name = "Vodka"
ITEM.model = "models/mosi/fallout4/props/alcohol/vodka.mdl"
ITEM.thirst = 18
ITEM.description = "A bottle of Vodka."
ITEM.longdesc = "A bottle of Red Star brand vodka. Was especially popular in the Soviet Union before the war, and has its fans today - especially as a mixer."
ITEM.quantity = 1
ITEM.price = 5
ITEM.width = 1
ITEM.height = 2
ITEM.sound = "fosounds/fix/npc_humandrinking_soda_01.mp3"
ITEM.flag = "5"
ITEM:Hook("use", function(item)
	item.player:addRadiation(-10)
	item.player:EmitSound(item.sound or "items/battery_pickup.wav")
	ix.chat.Send(item.player, "iteminternal", "takes a swig of their "..item.name..".", false)
end)
ITEM.weight = 0.1


ITEM:DecideFunction()