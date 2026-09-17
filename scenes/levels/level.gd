class_name GameLevel
extends Node2D

@export var player: PlayerController
@export var default_spawn: Marker2D
@export var fall_limit_y: float = 700.0


func _ready() -> void:
	var arrival_id: StringName = SceneTransition.take_arrival_id()
	var spawn: Marker2D = _find_arrival(arrival_id)
	player.respawn_at(spawn.global_position)
	
func _find_arrival(arrival_id: StringName) -> Marker2D:
	if arrival_id == &"":
		return default_spawn

	var marker_path: NodePath = NodePath("ArrivalPoints/" + String(arrival_id))
	var marker: Marker2D = get_node_or_null(marker_path) as Marker2D

	if is_instance_valid(marker):
		return marker

	push_warning("Arrival point not found: " + String(arrival_id))
	return default_spawn


func _physics_process(_delta: float) -> void:
	if player.global_position.y > fall_limit_y:
		player.respawn_at(default_spawn.global_position)
