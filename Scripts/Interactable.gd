extends StaticBody3D
class_name Interactable

signal interacted(body, interactable)

@export var PROMPT_MESSAGE = "Interact"
@export var PROMPT_ACTION = "interact"

func interact(body):
	emit_signal("interacted", body, self)


func _on_interacted(body, interactable):
	pass # Replace with function body.
