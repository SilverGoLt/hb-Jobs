exports.qtarget:Player({
	options = {
		{
			event = "",
			icon = "fa-solid fa-money-bill-transfer",
			label = "Billing",
            job = {['police'] = 0, ['ambulance'] = 0, ['mechanic'] = 0},
            action = function(entity) sendBillingRequest(entity) end
		},
	},
	distance = 2
})