local UIS = game:GetService("UserInputService")

local oldkey = nil
local ticker = nil
local limitsecond = 0.32
local AVGVALUES = {}

local avg = script.Parent.avg
local ms = script.Parent.ms
local ty = script.Parent.ty
local tys = script.Parent.tys

function AVG(Table)
	local collection = 0
	local num = 0
	for i,v in pairs(Table) do
		num = i
		collection = collection + v
	end
	collection = collection/num
	collection = tostring(collection):split(".")
	return collection[1]
end

local mt = {}
setmetatable(AVGVALUES,mt)

UIS.InputBegan:Connect(function(input,pro)
	if not pro and input and  input.KeyCode ~= Enum.KeyCode.Unknown then
		if rawequal(oldkey,nil) then
			oldkey = input
		end
		if rawequal(ticker,nil) then
			ticker = tick()
		end
		if rawequal(input,oldkey) and (tick() - ticker) <limitsecond then
			local timer = tick()-ticker
			timer = tostring(timer):split(".")
			timer = tostring(timer[2])
			table.insert(AVGVALUES,string.sub(timer,1,3))
			local AVG = AVG(AVGVALUES)
			ms.Text = "millisecond:"..string.sub(timer,1,3).." (ms.)"
			avg.Text = "AVG:"..AVG
			AVG = tonumber(AVG)
			timer = tonumber(string.sub(timer,1,3))
			if AVG >=158 then	
				ty.Text = "AVG Type:Slow"
				ty.TextColor3 = Color3.fromRGB(234, 0, 0)
			elseif AVG >= 100 and AVG <= 157 then
				ty.Text = "AVG Type:Normal"
				ty.TextColor3 = Color3.fromRGB(255, 226, 1)
			elseif AVG >= 50 and AVG <= 99 then
				ty.Text = "AVG Type:Fast"
				ty.TextColor3 = Color3.fromRGB(34, 255, 0)
			elseif AVG <= 49 then
				ty.Text = "AVG Type:Fastest"
				ty.TextColor3 = Color3.fromRGB(20, 200, 255)
			end
			if timer >=158 then	
				tys.Text = "ms Type:Slow"
				tys.TextColor3 = Color3.fromRGB(234, 0, 0)
			elseif timer >= 100 and timer <= 157 then
				tys.Text = "ms Type:Normal"
				tys.TextColor3 = Color3.fromRGB(255, 226, 1)
			elseif timer >= 50 and timer <= 99 then
				tys.Text = "ms Type:Fast"
				script.Parent.tys.TextColor3 = Color3.fromRGB(34, 255, 0)
			elseif timer <= 49 then
				tys.Text = "ms Type:Fastest"
				tys.TextColor3 = Color3.fromRGB(20, 200, 255)
			end
			oldkey = nil
			ticker = nil
		else
			oldkey = nil
			ticker = nil
		end
		oldkey = input
		ticker = tick()		
	end
end)