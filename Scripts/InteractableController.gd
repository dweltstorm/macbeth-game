extends Node



func _on_block_interacted(body, interactable):
	body.get_quest().complete(body)
