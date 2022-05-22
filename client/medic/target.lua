exports.qtarget:Player({
	options = {
		{
			event = "",
			icon = "fa-solid fa-briefcase-medical",
			label = "Use Medikit",
            job = 'ambulance',
			canInteract = function(entity)
				local health = GetEntityHealth(entity)
				local max = GetPedMaxHealth(entity)
				return health < max
			end,
			action = function(entity) startHealing('medikit') end
		},
		{
			event = "",
			icon = "fa-solid fa-briefcase-medical",
			label = "Defib",
			canInteract = function(entity)
				local isDead = DecorGetBool(entity, 'isDead')
				print(isDead)
				if isDead then
					return true
				else
					return false
				end
			end,
			action = function(entity) useDefib(entity) end,
            job = 'ambulance'
		},
	},
	distance = 3
})