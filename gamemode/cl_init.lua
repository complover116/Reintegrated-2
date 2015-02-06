include( "shared.lua" )

function GM:HUDPaint()
	self.BaseClass:HUDPaint()
	if deltaMonDis > 0 then
		draw.RoundedBox(4,0,32,128,32,Color(0,0,255,deltaMonDis))
		
		if deltaMon > 0 then
			draw.SimpleText( deltaMon, "Trebuchet24", 120, 48, Color(0,255,0, "+"..deltaMonDis), TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER )
			surface.SetMaterial(Material("silk/money_add.png","noclamp"))
		else
			draw.SimpleText( deltaMon, "Trebuchet24", 120, 48, Color(255,0,0, deltaMonDis), TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER )
			surface.SetMaterial(Material("silk/money_delete.png","noclamp"))
		end
			surface.SetDrawColor(color_white)
			surface.DrawTexturedRectUV(0,32,32,32,0,0,1,1)
	else
		if deltaMonDis > -32 then
			if deltaMon > 0 then
				surface.SetMaterial(Material("silk/money_add.png","noclamp"))
			else
				surface.SetMaterial(Material("silk/money_delete.png","noclamp"))
			end
			surface.SetDrawColor(color_white)
			surface.DrawTexturedRectUV(0,32+deltaMonDis,32,32,0,0,1,1)
		end
	end
	draw.RoundedBox(4,0,0,128,32,Color(0,255,0,100))
	draw.SimpleText( lastMoney, "Trebuchet24", 120, 16, Color(255,255,255), TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER )
	surface.SetMaterial(Material("silk/money.png","noclamp"))
	surface.SetDrawColor(color_white)
	surface.DrawTexturedRectUV(0,0,32,32,0,0,1,1)
end

function GM:Initialize()
	lastMoney = 0
	deltaMonDis = 0
	deltaMon = 0
end
function shopMenu()
        local Frame = vgui.Create( "DFrame" )
	Frame:SetPos( ScrW()/2 - 150, ScrH()/2 - 300 ) 
	Frame:SetSize( 300, 600 ) 
	Frame:SetTitle( "Shop Menu" ) 
	Frame:SetVisible( true ) 
	Frame:SetDraggable( true ) 
	Frame:ShowCloseButton( true )
	Frame:MakePopup()
	
	local Scroll = vgui.Create( "DScrollPanel", Frame ) //Create the Scroll panel
	Scroll:SetSize( 280, 570 )
	Scroll:SetPos( 10, 30 )

	local List = vgui.Create( "DIconLayout", Scroll )
	List:SetSize( 300, 200 )
	List:SetPos( 0, 0 )
	List:SetSpaceY( 5 ) //Sets the space in between the panels on the X Axis by 5
	List:SetSpaceX( 5 ) //Sets the space in between the panels on the Y Axis by 5

	for id, item in pairs(shopitems) do //Make a loop to create a bunch of panels inside of the DIconLayout
		local ListItem = List:Add( "DPanel" ) //Add DPanel to the DIconLayout
		ListItem:SetSize( 120, 40 )
		local DButton = vgui.Create( "DButton" )
		DButton:SetPos( 0, 0 )
		DButton:SetText( item.name.." - "..item.cost )
		DButton:SetParent(ListItem)
		DButton:SetSize( 120, 40 )
		DButton.DoClick = function()
			local menu = DermaMenu() 
			menu:AddOption( "1", function() RunConsoleCommand("re_buy", id) end )
			menu:AddOption( "2", function() RunConsoleCommand("re_buy", id) RunConsoleCommand("re_buy", id) end )
			menu:AddOption( "3", function() RunConsoleCommand("re_buy", id) RunConsoleCommand("re_buy", id) RunConsoleCommand("re_buy", id) end )
			menu:AddOption( "4", function() RunConsoleCommand("re_buy", id) RunConsoleCommand("re_buy", id) RunConsoleCommand("re_buy", id) RunConsoleCommand("re_buy", id) end )
			menu:AddOption( "5", function() RunConsoleCommand("re_buy", id) RunConsoleCommand("re_buy", id) RunConsoleCommand("re_buy", id) RunConsoleCommand("re_buy", id) RunConsoleCommand("re_buy", id) end )
			menu:Open()
		end
	end
end
function GM:Think()
	if deltaMonDis > -32 then deltaMonDis = deltaMonDis - 1 end
	if lastMoney != LocalPlayer():GetNetworkedInt("money") then
		if deltaMonDis > 0 then
			deltaMon = deltaMon + LocalPlayer():GetNetworkedInt("money") - lastMoney
		else
			deltaMon = LocalPlayer():GetNetworkedInt("money") - lastMoney
		end
		if LocalPlayer():GetNetworkedInt("money") - lastMoney > 0 then
			surface.PlaySound("reintegrated/money_in.wav")
		else
			surface.PlaySound("reintegrated/money_out.wav")
		end
		lastMoney = LocalPlayer():GetNetworkedInt("money")
		deltaMonDis = 500
	end
end


usermessage.Hook( "ShopMenu", shopMenu );