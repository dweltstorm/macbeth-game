extends RayCast3D

@onready var reticle = $"../../HUD/Reticle"
@onready var prompt_label = $"../../HUD/Prompt"

func _ready():
	add_exception(owner)

func _physics_process(_delta):
	var can_interact = is_colliding() and get_collider() is Interactable
	reticle.HOVERING = can_interact
	prompt_label.visible = can_interact
	if can_interact:
		prompt_label.text = "[E] " + get_collider().PROMPT_MESSAGE
		if Input.is_action_just_pressed("interact"):
			get_collider().interact(owner)
