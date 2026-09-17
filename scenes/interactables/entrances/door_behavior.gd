extends Node

@export_file("*.tscn") var destination_scene: String
@export var destination_arrival_id: StringName = &"WorkshopDoor"

@onready var interactable: Interactable = get_parent() as Interactable


func _ready() -> void:
	interactable.interacted.connect(_on_interacted)


func _on_interacted() -> void:
	if destination_scene.is_empty():
		push_warning("Door has no destination scene assigned")
		return
		
	SceneTransition.pending_arrival_id = destination_arrival_id
	
	var error: Error = get_tree().change_scene_to_file(destination_scene)

	if error != OK:
		push_error("Could not open destination scene: " + destination_scene	)
