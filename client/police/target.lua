exports.qtarget:Player({
	options = {
		{
			event = "",
			icon = "fa-solid fa-handcuffs",
			label = "Antrankiai",
            job = {['police'] = 0},
            action = function(entity) cuffPlayer(entity) end
		},
		{
			event = "",
			icon = "fa-solid fa-handcuffs",
			label = "Tempti Asmeni",
            job = {['police'] = 0},
			canInteract = function(entity)
				return DecorGetBool(entity, 'isCuffed')
			end,
            action = function(entity) dragPlayer(entity) end
		},
	},
	distance = 2
})