AddCSLuaFile()

shopitems = {}
shopitems["1"] = {name="Health Vial";ent="item_healthvial";cost=100}
shopitems["2"] = {name="Pistol Ammo";ent="item_box_srounds";cost=25}
shopitems["3"] = {name="Pistol";ent="weapon_pistol";cost=300}
shopitems["4"] = {name="Battery";ent="item_battery";cost=120}
shopitems["5"] = {name="SMG1";ent="weapon_smg1";cost=500}
shopitems["6"] = {name="SMG1 Ammo";ent="item_box_mrounds";cost=100}
shopitems["7"] = {name="Grenade";ent="weapon_frag";cost=75}
shopitems["8"] = {name="AR2";ent="weapon_ar2";cost=1000}
shopitems["9"] = {name="AR2 Ammo";ent="item_box_lrounds";cost=150}
shopitems["10"] = {name="Combine Ball";ent="item_ammo_ar2_altfire";cost=200}
shopitems["11"] = {name="SMG1 Grenade";ent="item_ammo_smg1_grenade";cost=200}

itemmodels = {}
itemmodels["item_battery"] = "models/items/battery.mdl"
itemmodels["item_healthvial"] = "models/healthvial.mdl"
print("ShopList loaded")