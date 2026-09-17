extends Node
signal arrival_ready(player: PlayerController)

var pending_arrival_id: StringName = &""
var _is_transitioning: bool = false

@export var fade_duration: float = 0.35

@onready var fade_rect: ColorRect = $FadeLayer/FadeRect

func take_arrival_id() -> StringName:
	var arrival_id: StringName = pending_arrival_id
	pending_arrival_id = &""
	return arrival_id

func fade_out() -> void:
	var tween: Tween = create_tween()
	tween.tween_property(fade_rect, "color:a", 1.0, fade_duration)
	await tween.finished


func fade_in() -> void:
	var tween: Tween = create_tween()
	tween.tween_property(fade_rect, "color:a", 0.0, fade_duration)
	await tween.finished
	
func report_arrival(player: PlayerController) -> void:
	arrival_ready.emit(player)
	
func travel(
	player: PlayerController,
	entry_position: Vector2,
	destination_scene: String,
	arrival_id: StringName
) -> void:
	if _is_transitioning:
		return

	if destination_scene.is_empty() or arrival_id == &"":
		push_warning("Travel requires a destination and arrival ID.")
		return

	_is_transitioning = true

	await player.approach_entrance(entry_position)
	await fade_out()

	pending_arrival_id = arrival_id
	var error: Error = get_tree().change_scene_to_file(destination_scene)

	if error != OK:
		pending_arrival_id = &""
		await fade_in()
		player.set_controls_enabled(true)
		_is_transitioning = false
		push_error("Could not open destination scene: " + destination_scene)
		return

	var arriving_player: PlayerController = await arrival_ready

	await fade_in()
	arriving_player.set_controls_enabled(true)
	_is_transitioning = false
