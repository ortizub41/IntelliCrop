extends Node


var plantselected
var toolselected
var snow = 0
var soil_temp_deep = 0
var soil_temp_shallow = 0
var surface_temp = 0
var humidity = 0
var transpiration = 0
var evapo_transpiration = 0
var pressure = 0
var wind = 0
var storm_runoff = 0
var companion_score = 1.4
var cover_crop_score = 1
var env_factor_score = 1
var quality_score = get_average([companion_score, cover_crop_score, env_factor_score])
var seed_type = {NONE = 0, CARROT = 1, ONION = 2}
var tool_type = {NONE = 0, SHOVEL = 1}
var vegetable_count = {CARROT = 0, ONION = 0}
var numofcarrots = vegetable_count['CARROT']
var numofonions = vegetable_count['ONION']


func get_average(numbers: Array) -> float:
	if numbers.is_empty():
		return 0.0

	var sum := 0.0
	for n in numbers:
		sum += n

	return sum / numbers.size()
