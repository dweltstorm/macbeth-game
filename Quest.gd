class_name Quest
extends Resource
signal completed(player)

@export var TITLE : String
@export var MAIN_TEXT : String
@export var COMPLETE_DIALOGUE : DialogueResource

func complete(body):
	if(body.quest_index < len(body.QUESTS)-1): body.quest_index += 1
	DialogueManager.show_dialogue_balloon(COMPLETE_DIALOGUE)
