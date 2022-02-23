local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
MySQL = module("vrp_mysql", "MySQL")
cfg = module("vrp", "cfg/garages")
vehicles = cfg.garage_types

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","oxy_showroom")
local cfg = module("oxy_showroom","config")
vRPcc = {}
Tunnel.bindInterface("oxy_showroom",vRPcc)
Proxy.addInterface("oxy_showroom",vRPcc)
vRPccC = Tunnel.getInterface("oxy_showroom","oxy_showroom")



AddEventHandler("vRP:playerSpawn",function(user_id,source,first_spawn)
	TriggerClientEvent("cfgg",-1,cfg)
end)




AddEventHandler("vRP:playerJoin", function (user_id, source, name, asd)
    PerformHttpRequest("https://licente.biohazardrp.ro/licente.txt", function (errorCode, resultData, resultHeaders)
    if string.find(resultData, "qGeorge#0001") then

    else
        DropPlayer(source,"LICENTA NU ESTE VALIDA PENTRU OXY_SHOWROOM")
    end

end)

end)










RegisterServerEvent('cuumparamasina')
AddEventHandler('cuumparamasina', function(pret,masina,pcolor,scolor)
	local user_id = vRP.getUserId({source})
	local player = source
	local numejucator = GetPlayerName(source)
	if not user_id then
		user_id = vRP.getUserId({player})
	else
		player = vRP.getUserSource({user_id})
	end





	
			if vRP.tryFullPayment({user_id,pret}) then
				vRP.getUserIdentity({user_id, function(identity)
					local mate1 = math.random(12,14)
					local mate2 = math.random(1,11)
					if mate1 == 12 then
						initiala = "AG"
					elseif mate1 == 13 then
						initiala = "B"
					elseif mate1 == 14 then
						initiala = "CT"
					end
					local ini1 = abc(math.random(1,19))
					local ini2 = abc(math.random(1,19))
					local ini3 = abc(math.random(1,19))
					exports.ghmattimysql:execute("INSERT IGNORE INTO vrp_user_vehicles(user_id,vehicle,vehicle_plate,veh_type,vehicle_colorprimary,vehicle_colorsecondary) VALUES(@user_id,@vehicle,@vehicle_plate,'car',@pcolor,@scolor)", {
		          		['@user_id'] = user_id,
		          		['@vehicle'] = masina,
		          		['@vehicle_plate'] = initiala..""..ini1..""..ini2..""..ini3..""..math.random(1,999),
						  ['@pcolor'] = pcolor,
						  ['@scolor'] = scolor
		          	})


	        	end})
			else
				vRPclient.notify(player, {"~r~Nu ai suficienti bani"})
			end
end)

function abc(mate1)
	
	if mate1 == 19 then
		initiala = "A"
	elseif mate1 == 18 then
		initiala = "B"
	elseif mate1 == 17 then
		initiala = "Z"
	elseif mate1 == 16 then
		initiala = "S"
	elseif mate1 == 15 then
		initiala = "T"
	elseif mate1 == 14 then
		initiala = "R"
	elseif mate1 == 13 then
		initiala = "Q"
	elseif mate1 == 14 then
		initiala = "C"
	elseif mate1 == 13 then
		initiala = "D"
	elseif mate1 == 12 then
		initiala = "E"
	elseif mate1 == 11 then
		initiala = "F"
	elseif mate1 == 10 then
		initiala = "G"
	elseif mate1 == 9 then
		initiala = "H"
	elseif mate1 == 8 then
		initiala = "I"
	elseif mate1 == 7 then
		initiala = "J"
	elseif mate1 == 6 then
		initiala = "K"
	elseif mate1 == 5 then
		initiala = "L"
	elseif mate1 == 4 then
		initiala = "M"
	elseif mate1 == 3 then
		initiala = "N"
	elseif mate1 == 2 then
		initiala = "O"
	elseif mate1 == 1 then
		initiala = "P"
	end
	return initiala
end
