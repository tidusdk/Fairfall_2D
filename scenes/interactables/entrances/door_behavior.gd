extends Node

@export_file("*.tscn") var destination_scene: String
@export var destination_arrival_id: StringName = &"WorkshopDoor"

@onready var interactable: Interactable = get_parent() as Interactable
@onready var entry_position: Marker2D = $"../EntryPosition"


func _ready() -> void:
	interactable.interacted.connect(_on_interacted)


func _on_interacted(player: PlayerController) -> void:
	SceneTransition.travel(
		player,
		entry_position.global_position,
		destination_scene,
		destination_arrival_id
	)
