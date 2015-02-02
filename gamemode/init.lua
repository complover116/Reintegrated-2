AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )

include( "shared.lua" )

function GM:PlayerSpawn(ply)
	ply:SetModel("models/player/kleiner.mdl")
	ply:SetPlayerColor(Vector(1,1,1))
	ply:Give("weapon_physcannon")
	ply:Give("weapon_crowbar")
	--ply:SetPos(Vector(0,0,-100000))
	
end
function GM:Initialize()
	if file.Exists("lua/rein_mapdata/"..game.GetMap()..".txt", "GAME") then
		print("Located map data file fot "..game.GetMap())
		data = file.Read("lua/rein_mapdata/"..game.GetMap()..".txt", "GAME")
		entities = string.Explode("\n", data)
		for _, entstr in pairs(entities) do
			entdata = string.Explode(":", entstr)
			ent = ents.Create(entdata[1])
			entpos = string.Explode(" ", entdata[2])
			entang = string.Explode(" ", entdata[3])
			ent:SetPos(Vector(entpos[1],entpos[2],entpos[3]))
			ent:SetAngles(Angle(entang[1],entang[2],entang[3]))
			ent:Spawn()
		end
	else
	end
end
function GM:PlayerInitialSpawn(ply)
	ply:SetNetworkedInt("money", 1000)
end
-- Choose the model for hands according to their player model.
function GM:PlayerSetHandsModel( ply, ent )

	local simplemodel = player_manager.TranslateToPlayerModelName( ply:GetModel() )
	local info = player_manager.TranslatePlayerHands( simplemodel )
	if ( info ) then
		ent:SetModel( info.model )
		ent:SetSkin( info.skin )
		ent:SetBodyGroups( info.body )
	end

end

function setMoneyCommand(ply, command, args)
	if #args < 1 then return end
	ply:SetNetworkedInt("money", args[1])
end
concommand.Add("re_setmoney", setMoneyCommand)

function getPosCommand(ply, command, args)
	print(ply:GetPos())
end
concommand.Add("re_getmypos", getPosCommand)

function buyCommand(ply, command, args)
	if #args < 1 then return end
	bestD = 20
	for _, ent in pairs(ents.FindByClass("re_shop")) do
		if ent:GetPos():Distance(ply:GetPos()) < bestD then
			shop = ent
			bestD = ent:GetPos():Distance(ply:GetPos())
		end
	end
	if shop == nil || !shop:IsValid() then return end
	item = args[1]
	print("Buying item id "..item)
	if ply:GetNetworkedInt("money") >= shopitems[item].cost then
		ply:SetNetworkedInt("money", ply:GetNetworkedInt("money") - shopitems[item].cost)
		table.insert(shop.orderlist, shopitems[item].ent)
	end
end
concommand.Add("re_buy", buyCommand)