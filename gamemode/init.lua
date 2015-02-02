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