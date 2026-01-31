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
AutoRaidEnabled = false

function ARF()
    -- Bloqueia fora da raid
    if game.PlaceId ~= 101026405220822 then
        warn("Você está fora da raid")
        return
    end

    local Players = game:GetService("Players")
    local player = Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local hrp = character:WaitForChild("HumanoidRootPart")

    local currentEnemy = nil

    -- Desativa shift lock
    player:SetAttribute("Canshiftlock", false)

    task.spawn(function()
        while AutoRaidEnabled do
            task.wait(0.2)

            -- Se não tiver inimigo válido, procura outro
            if not currentEnemy
            or not currentEnemy.Parent
            or not currentEnemy.Character
            or not currentEnemy.Character:FindFirstChild("Humanoid")
            or currentEnemy.Character.Humanoid.Health <= 0 then

                currentEnemy = nil

                for _, enemy in ipairs(workspace.Enemys:GetChildren()) do
                    local char = enemy:FindFirstChild("Character")
                    local humanoid = char and char:FindFirstChild("Humanoid")
                    local enemyHRP = char and char:FindFirstChild("HumanoidRootPart")

                    if humanoid and humanoid.Health > 0 and enemyHRP then
                        currentEnemy = enemy
                        break
                    end
                end
            end

            -- Se achou inimigo, vai até ele
            if currentEnemy and currentEnemy.Character then
                local enemyHRP = currentEnemy.Character:FindFirstChild("HumanoidRootPart")
                if enemyHRP then
                    hrp.CFrame = enemyHRP.CFrame * CFrame.new(0, 0, -3)
                end
            end
        end

        -- Quando desligar, devolve shift lock
        player:SetAttribute("Canshiftlock", true)
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
