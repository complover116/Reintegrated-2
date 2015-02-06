AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )

include( "shared.lua" )

resource.AddFile("/sound/reintegrated/money_in.wav")
resource.AddFile("/sound/reintegrated/money_out.wav")
resource.AddFile("/sound/reintegrated/purchase.wav")

worldparams = {}
worldparams.exists = false
function GM:PlayerSpawn(ply)
	ply:SetModel("models/player/kleiner.mdl")
	ply:SetPlayerColor(Vector(1,1,1))
	ply:Give("weapon_physcannon")
	ply:Give("weapon_crowbar")
	ply:Give("re_holdingstuff")
	ply:SetNetworkedInt("itemitem_battery", 0)
	ply:SetNetworkedInt("itemitem_healthvial", 0)
	ply:AllowFlashlight( true )
	ply:SetupHands()
	--ply:SetPos(Vector(0,0,-100000))
	
end
function GM:InitPostEntity()
	if file.Exists("lua/rein_mapdata/"..game.GetMap()..".txt", "GAME") then
		print("Located map data file fot "..game.GetMap())
		worldparams.exists = true
		data = file.Read("lua/rein_mapdata/"..game.GetMap()..".txt", "GAME")
		_, start = string.find(data, "PARAMS")
		stop = string.find(data, "ENDPARAMS")
		paramdata  = string.sub(data, start+3, stop-2)
		print("PARAMETERS:"..start..":"..stop)
		print(paramdata)
		parameters = string.Explode("\n", paramdata)
		for _, paramstr in pairs(parameters) do
			paramdata = string.Explode("=", paramstr)
			worldparams[paramdata[1]] = paramdata[2]
		end
		if worldparams.custom_spawns then
			for k, v in pairs(ents.FindByClass("info_player_start")) do
				v:Remove()
			end
		end
		
		_, start = string.find(data, "ENTS")
		stop = string.find(data, "ENDENTS")
		entdata  = string.sub(data, start + 3, stop - 2)
		print("ENTITIES:")
		print(entdata)
		entities = string.Explode("\n", entdata)
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

function getModelCommand(ply, command, args)
	traceres = ply:GetEyeTrace()
	if !traceres.HitWorld then
		print(traceres.Entity:GetModel())
	end
end
concommand.Add("re_getmodel", getModelCommand)

function buyCommand(ply, command, args)
	if #args < 1 then return end
	bestD = 200
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