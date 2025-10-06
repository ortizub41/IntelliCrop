extends StaticBody2D

var plant = Global.plantselected
var plantgrowing = false
var plant_grown = false
var nodes_in_range = []

func _ready():
	connect("body_entered", Callable(self, "_on_Area2D_body_entered"))
	connect("body_exited", Callable(self, "_on_Area2D_body_exited"))

func _on_Area2D_body_entered(body):
	nodes_in_range.append(body)
	print("Node entered: ", body.name)

func _on_Area2D_body_exited(body):
	nodes_in_range.erase(body)
	print("Node exited: ", body.name)

func get_nodes_within_circle():
	return nodes_in_range

func _physics_process(delta: float):
	if plantgrowing == false:
		plant = Global.plantselected

func _on_area_2d_area_entered(area: Area2D):
	if not plantgrowing:
		match plant:
			1:
				plantgrowing = true
				$carrotgrowtimer.start()
				$plant.play("carrotgrowing")
			2:
				plantgrowing = true
				$oniongrowtimer.start()
				$plant.play("oniongrowing")

func _on_carrotgrowtimer_timeout():
	var carrot_plant = $plant
	match carrot_plant.frame:
		0:
			carrot_plant.frame = 1
			$oniongrowtimer.start()
		1:
			carrot_plant.frame = 2
			plant_grown = true

func _on_oniongrowtimer_timeout():
	var onion_plant = $plant
	match onion_plant.frame:
		0:
			onion_plant.frame = 1
			$oniongrowtimer.start()
		1:
			onion_plant.frame = 2
			plant_grown = true

func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int):
	if plant_grown:
		match plant:
			1:
				if Global.toolselected:
					Global.numofcarrots += 1
					_is_plant_growing_or_grown(false, false, $plant)
			2:
				if Global.toolselected:
					Global.numofonions += 1
					_is_plant_growing_or_grown(false, false, $plant)

func _is_plant_growing_or_grown(is_growing, is_grown, plant):
	plantgrowing = is_growing
	plant_grown = is_grown
	if not plantgrowing and not plant_grown:
		plant.play("none")
