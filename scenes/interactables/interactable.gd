class_name Interactable
extends Area2D

signal interacted(player: PlayerController)

@export var prompt_text: String = "Interact"

func interact(player: PlayerController) -> void:
	print("Interacted: ", prompt_text)
	interacted.emit(player)
