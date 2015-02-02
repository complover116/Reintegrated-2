include('shared.lua')

function ENT:Draw()
	self.BaseClass.Draw(self)
	local vWorldPos=Vector(13,5,30)
	vWorldPos:Rotate(self:GetAngles())
	vWorldPos=vWorldPos+self:GetPos()
	cam.Start3D2D( vWorldPos, self:GetAngles()+Angle(0,90,90), 0.3 )
                draw.DrawText("Shop", "Trebuchet24", 0, 0, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER )
    cam.End3D2D()
end