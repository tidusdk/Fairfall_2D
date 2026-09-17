extends Label

@export var detector: InteractionDetector


func _ready() -> void:
	hide()
	detector.target_updated.connect(_on_target_updated)


func _on_target_updated(target: Interactable) -> void:
	if not is_instance_valid(target):
		hide()
		return

	text = "E — " + target.prompt_text
	show()
