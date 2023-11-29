extends Node


func _on_block_interacted(body, interactable):
	interactable.queue_free()
