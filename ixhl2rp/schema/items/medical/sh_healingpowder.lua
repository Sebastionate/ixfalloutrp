ITEM.name = "Healing Powder"
ITEM.description = "A classic tribal cure."
ITEM.longdesc = "A pouch of ground up Broc Flower and Xander Root, rubbed directly onto a wound. Aids well in pain and bleeding, but the powder tends to make one's vision hazy for a short period."
ITEM.model = "models/mosi/fnv/props/health/healingpowder.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.category = "Medical"
ITEM.price = "4000"
ITEM.flag = "1"
ITEM.quantity = 1
ITEM.sound = "items/smallmedkit1.wav"
ITEM.weight = 0.05
ITEM.duration = 300


ITEM.functions.use = {
	name = "Use",
	icon = "icon16/heart.png",
	OnRun = function(item)
		local quantity = item:GetData("quantity", item.quantity)
	
		ix.chat.Send(item.player, "iteminternal", "applies their "..item.name..".", false)

		item.player:NewVegasNotify("You are suffering from Powder Haze! -1 PER", "messageSad", 8)

		curplayer = item.player:GetCharacter()
		curplayer:AddBoost("powderhaze", "perception", -1)
		itemname = item.name
		duration = item.duration

		timer.Simple(duration, function() 
			curplayer:RemoveBoost("powderhaze", "perception")
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