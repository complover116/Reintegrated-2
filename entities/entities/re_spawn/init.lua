 
AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
 
include('shared.lua')
 
function ENT:Initialize()
 
	self:SetModel( "models/xqm/podremake.mdl" )
	self:PhysicsInit( SOLID_VPHYSICS )      -- Make us work with physics,
	--self:SetMoveType( MOVETYPE_VPHYSICS )   -- after all, gmod is a physics
	self:SetSolid( SOLID_VPHYSICS )         -- Toolbox
 
        local phys = self:GetPhysicsObject()
	if (phys:IsValid()) then
		phys:Wake()
	end
end
 
function ENT:Use( activator, caller )
    return
end
 
function ENT:Think()
    -- We don't need to think, we are just a prop after all!
end