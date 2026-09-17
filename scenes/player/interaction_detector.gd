class_name InteractionDetector
extends Area2D
signal target_updated(target: Interactable)

func _ready() -> void:
	area_entered.connect(_on_area_entered)
	area_exited.connect(_on_area_exited)


func _on_area_entered(area: Area2D) -> void:
	if area is Interactable:
		print("Available: ", area.prompt_text)


func _on_area_exited(area: Area2D) -> void:
	if area is Interactable:
		print("Left interaction range: ", area.prompt_text)
		
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("interact"):
		var target: Interactable = _find_nearest_interactable()
		
		if is_instance_valid(target):
			get_viewport().set_input_as_handled()
			target.interact()
			
func _find_nearest_interactable() -> Interactable:
	var nearest: Interactable = null
	var nearest_distance_squared: float = INF

	for area in get_overlapping_areas():
		if area is Interactable:
			var distance_squared: float = global_position.distance_squared_to(
				area.global_position
			)

			if distance_squared < nearest_distance_squared:
				nearest = area
				nearest_distance_squared = distance_squared

	return nearest

func _physics_process(delta: float) -> void:
	var target: Interactable = _find_nearest_interactable()
	target_updated.emit(target)
