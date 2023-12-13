ITEM.name = "Super Stimpak"
ITEM.description = "A rarer medical treatment item for heavy wounds."
ITEM.longdesc = "A one use, injectable stimpak dialed up to eleven, suitable for the worst injuries. Has a side effect of a feeling of weakness for a modest period of time.\n\n+65 HP\n-1 END, AGI\nMedical DC to Stabilize: 15"
ITEM.model = "models/mosi/fnv/props/health/superstimpak.mdl"
ITEM.width = 1
ITEM.height = 2
ITEM.category = "Medical"
ITEM.price = "4000"
ITEM.flag = "1"
ITEM.quantity = 1
ITEM.sound = "fosounds/fix/npc_human_using_stimpak.mp3"
ITEM.weight = 0.05
ITEM.duration = 450
ITEM.heal = 65


ITEM.functions.use = {
	name = "Use",
	icon = "icon16/heart.png",
	OnRun = function(item)
		local quantity = item:GetData("quantity", item.quantity)
	
		ix.chat.Send(item.player, "iteminternal", "injects their "..item.name..".", false)
		item.player:GetCharacter():GetInventory():Add("dirtysyringe", 1)

		local curplayer = item.player:GetCharacter()
		local itemname = item.name
		local duration = item.duration

		item.player:AdjustHealth("heal", item.heal)
		item.player:NewVegasNotify("Restored " .. item.heal .. " health.", "messageNeutral", 4)
		curplayer:AddBoost("stimpaksickness", "endurance", -1)
		curplayer:AddBoost("stimpaksickness", "agility", -1)

		timer.Simple(duration, function() 
			curplayer:RemoveBoost("stimpaksickness", "endurance")
			curplayer:RemoveBoost("stimpaksickness", "agility")
			curplayer:GetPlayer():NewVegasNotify(itemname .. " has worn off.", "messageNeutral", 8)
			curplayer:GetPlayer():EmitSound("cwfallout3/ui/medical/wear_off.wav" or "items/battery_pickup.wav")
		end)


			quantity = quantity - 1
			if (quantity >= 1) then
				item:SetData("quantity", quantity)
				return false
			end

			return true
		end,
	

	OnCanRun = function(item)
		return (!IsValid(item.entity))
	end
}


function ITEM:GetDescription()
	if (!self.entity or !IsValid(self.entity)) then
		local quant = self:GetData("quantity", self.quantity)
		local str = self.longdesc.."\n \nThere's only "..quant.." uses left."

		return str
	else
		return self.desc
	end
end

if (CLIENT) then
	function ITEM:PaintOver(item, w, h)

		draw.SimpleText(item:GetData("quantity", item.quantity).."/"..item.quantity, "DermaDefault", 3, h - 1, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM, 1, color_black)
	end
end