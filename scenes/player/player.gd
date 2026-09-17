class_name PlayerController
extends CharacterBody2D

@export var move_speed: float = 220.0
@export var jump_speed: float = 380.0
@export var coyote_time: float = 0.1
@export var jump_buffer_time: float = 0.1

var _coyote_time_remaining: float = 0.0
var _jump_buffer_remaining: float = 0.0

func _physics_process(delta: float) -> void:
	if is_on_floor():
		_coyote_time_remaining = coyote_time
	else:
		_coyote_time_remaining = maxf(
			_coyote_time_remaining - delta,
			0.0
		)
		velocity += get_gravity() * delta

	_jump_buffer_remaining = maxf(
		_jump_buffer_remaining - delta,
		0.0
	)

	if Input.is_action_just_pressed("jump"):
		_jump_buffer_remaining = jump_buffer_time

	if _jump_buffer_remaining > 0.0 and _coyote_time_remaining > 0.0:
		velocity.y = -jump_speed
		_jump_buffer_remaining = 0.0
		_coyote_time_remaining = 0.0

	var direction: float = Input.get_axis("move_left", "move_right")
	velocity.x = direction * move_speed

	move_and_slide()
	
func respawn_at(spawn_position: Vector2) -> void:
	global_position = spawn_position
	velocity = Vector2.ZERO
	_coyote_time_remaining = 0.0
	_jump_buffer_remaining = 0.0
