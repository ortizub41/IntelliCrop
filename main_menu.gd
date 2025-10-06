extends Control

func _physics_process(delta: float) -> void:
	$SnowHSlider.tooltip_text = str(Global.snow)
	$SoilTempDeepHSlider.tooltip_text = str(Global.soil_temp_deep)
	$SoilTempShallowHSlider.tooltip_text = str(Global.soil_temp_shallow)
	$SurfaceTempHSlider.tooltip_text = str(Global.surface_temp)
	$HumidityHSlider.tooltip_text = str(Global.humidity)
	$TranspirationHSlider.tooltip_text = str(Global.transpiration)
	$EvaportranspirationHSlider.tooltip_text = str(Global.evapo_transpiration)
	$PressureHSlider.tooltip_text = str(Global.pressure)
	$WindHSlider.tooltip_text = str(Global.wind)
	$StormRunOffHSlider.tooltip_text = str(Global.storm_runoff)

func _on_close_button_pressed() -> void:
	hide()
