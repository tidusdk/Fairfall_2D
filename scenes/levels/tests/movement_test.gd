extends Node2D

@export var fall_limit_y: float = 700.0

@onready var player: PlayerController = $Player
@onready var player_spawn: Marker2D = $PlayerSpawn

func _ready() -> void:
	player.respawn_at(player_spawn.global_position)
	
func _physics_process(delta: float) -> void:
	if player.global_position.y > fall_limit_y:
		player.respawn_at(player_spawn.global_position)
