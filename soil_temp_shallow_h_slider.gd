extends HSlider

func _on_value_changed(value: float) -> void:
	Global.soil_temp_shallow = value
