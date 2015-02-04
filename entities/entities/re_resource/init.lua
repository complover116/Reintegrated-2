 
AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
 
include('shared.lua')
 
function ENT:Initialize()
	self:SetModel( "models/props_junk/sawblade001a.mdl" )
	self:PhysicsInit( SOLID_VPHYSICS )      -- Make us work with physics,
	self:SetMoveType( MOVETYPE_NONE )   -- after all, gmod is a physics
	self:SetSolid( SOLID_VPHYSICS )         -- Toolbox
	self:SetRenderMode(RENDERMODE_TRANSCOLOR)
	self:SetColor(0,255,0)
	self.time = 0
	self.spawnedents = {}
    local phys = self:GetPhysicsObject()
	if (phys:IsValid()) then
		phys:Wake()
	end
end
 
function ENT:Use( activator, caller )
    return
end
 
function ENT:Think()
    if self.time < 60 then
		self.time = self.time + 1
	else
		self.time = 0
		local entnum = 0
		for k,v in pairs(self.spawnedents) do
			entnum = entnum + 1
			if !v:IsValid() || v == nil then
				self.spawnedents[v] = nil
				entnum = entnum - 1
				table.remove(self.spawnedents, k)
			end
		end
		if entnum < 25 then
			ent = ents.Create("re_money")
			ent:SetPos(self:GetPos()+Vector(0,0,10))
			
			ent:Spawn()
			ent:GetPhysicsObject():SetVelocity(Vector(math.random()*500 - 250,math.random()*500 - 250,300))
			table.insert(self.spawnedents, ent)
		end
	end
end