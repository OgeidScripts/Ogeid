-----fubcao de tp e de prompt-----
function TweenTp(x, y, z, speed)
  local tween_s = game:GetService('TweenService')
  local tweeninfo = TweenInfo.new(speed, Enum.EasingStyle.Linear)
  local lp = game.Players.LocalPlayer
    local cf = CFrame.new(Vector3.new(x, y, z))
    local a = tween_s:Create(lp.Character.HumanoidRootPart, tweeninfo, {CFrame = cf})
    a:Play()
    
    return a
end

function TaT(x, y, z, speed, pp)
	local twp = TweenTp(x, y, z, speed)
	twp.Completed:Wait()

	task.wait(0.5)

	local prompt = pp:FindFirstChildWhichIsA("BasePart", true)
		and pp:FindFirstChildWhichIsA("ProximityPrompt", true)

	if prompt then
		fireproximityprompt(prompt)
	end
end

----------Funcao do AutoRaid----------
local AutoRaidEnabled = false

-- Função principal do AutoRaid focado
function ARF()
    if game.PlaceId == 131073412590872 then
        print("Proibido fora de raid")
	else

    local player = game.Players.LocalPlayer
    local hrp = player.Character:WaitForChild("HumanoidRootPart")
    local currentEnemy = nil

    spawn(function()
        while AutoRaidEnabled do
            -- Se não tem alvo válido, procura o próximo
            if not currentEnemy
               or not currentEnemy.Parent
               or not currentEnemy.Character
               or not currentEnemy.Character:FindFirstChild("Humanoid")
               or currentEnemy.Character.Humanoid.Health <= 0 then

                currentEnemy = nil

                for _, enemy in pairs(workspace.Enemys:GetChildren()) do
                    local char = enemy.Character
                    local humanoid = char and char:FindFirstChild("Humanoid")
                    if humanoid and humanoid.Health > 0 then
                        currentEnemy = enemy
                        break -- pega o PRIMEIRO válido
                    end
                end
            end

            -- Se tem alvo válido, ataca
            if currentEnemy and currentEnemy.Character then
                local hrpEnemy = currentEnemy.Character:FindFirstChild("HumanoidRootPart")
                local humanoid = currentEnemy.Character:FindFirstChild("Humanoid")
					if hrpEnemy then
                    -- Move perto do NPC
                    hrp.CFrame = hrpEnemy.CFrame * CFrame.new(0, 0, 3)
                    -- Ataca
                    pcall(function()
                        game:GetService("ReplicatedStorage").RemoteFunctions.Character.PVP.Punch:InvokeServer(3)
                    end)
				    humanoid:TakeDamage(humanoid.MaxHealth)		
                end
            end

            task.wait(0.05) -- pequeno delay
        end
    end)
end

----------Funcao de roubar o banco----------
function LvUp()
	local C4 = workspace.World.Map.Map_Scripts_Parts.Bank.Vault.Door.C4.ProximityPrompt
			C4.Enabled = true
			C4.RequiresLineOfSight = false
			C4.HoldDuration = 0
	local twp
	twp = TweenTp(11, -14, -587, 3)
	twp.Completed:Wait()

	task.wait(0.5)
		fireproximityprompt(C4)
			
	task.wait(12)
	
	local Roubo = workspace.World.Map.Map_Scripts_Parts.Bank.Cash:GetChildren()[5].ProximityPrompt
	Roubo.RequiresLineOfSight = false
	Roubo.HoldDuration = 0

		twp = TweenTp(52, -12, -587, 2)
		twp.Completed:Wait()

	task.wait(0.2)
	
		for i = 1, 12 do
			fireproximityprompt(Roubo)
			task.wait(0.1)
		end

task.wait(2)
	twp = TweenTp(898, -264, -335, 3)
end
