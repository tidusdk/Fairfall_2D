class_name Interactable
extends Area2D

signal interacted

@export var prompt_text: String = "Interact"

func interact() -> void:
	print("Interacted: ", prompt_text)
	interacted.emit()
