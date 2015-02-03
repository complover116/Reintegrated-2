 
AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
 
include('shared.lua')
 
function ENT:Initialize()
	self.orderlist = {}
	self.cooldown = 0
	self:SetModel( "models/props_lab/reciever_cart.mdl" )
	self:PhysicsInit( SOLID_VPHYSICS )      -- Make us work with physics,
	self:SetMoveType( MOVETYPE_NONE )   -- after all, gmod is a physics
	self:SetSolid( SOLID_VPHYSICS )         -- Toolbox
	self:SetUseType(SIMPLE_USE)
     --[[   local phys = self:GetPhysicsObject()
	if (phys:IsValid()) then
		phys:Wake()
	end]]--
end
 
function ENT:Use( activator, caller )
	umsg.Start( "ShopMenu" );
	umsg.End();
    return
end
 
function ENT:Think()
    if self.cooldown > 0 then
		self.cooldown = self.cooldown - 1
	else
		if #self.orderlist > 0 then
			ent = ents.Create(self.orderlist[1])
			local vWorldPos=Vector(5,5,-10)
			vWorldPos:Rotate(self:GetAngles())
			vWorldPos=vWorldPos+self:GetPos()
			ent:SetPos(vWorldPos)
			ent:Spawn()
			vel = Vector(300,0,0)
			vel:Rotate(self:GetAngles())
			ent:GetPhysicsObject():SetVelocity(vel)
			table.remove(self.orderlist, 1)
			self.cooldown = 2
			self:EmitSound("reintegrated/purchase.wav")
		end
	end
end