 
AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
 
include('shared.lua')
 
function ENT:Initialize()
	self:SetModel( "models/hunter/blocks/cube025x025x025.mdl" )
	self:PhysicsInit( SOLID_VPHYSICS )      -- Make us work with physics,
	self:SetMoveType( MOVETYPE_VPHYSICS )   -- after all, gmod is a physics
	self:SetSolid( SOLID_VPHYSICS )         -- Toolbox
	self:SetColor(0,255,0)
	self.amount = 100
    local phys = self:GetPhysicsObject()
	if (phys:IsValid()) then
		phys:Wake()
	end
end
 
function ENT:Use( activator, caller )
    return
end
 
function ENT:Think()
    for _, ply in pairs(player.GetAll()) do
		if ply:GetPos():Distance(self:GetPos()) < 100 then
			self:Remove()
			ply:SetNetworkedInt("money", ply:GetNetworkedInt("money")+self.amount)
			break
		end
	end
end