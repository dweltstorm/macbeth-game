extends CharacterBody3D


@export var SPEED: float = 5.0
@export var SPRINT_SPEED: float = 7.0
@export var JUMP_VELOCITY: float = 4.5
@export var SENSITIVITY: float = 0.003
@export var QUESTS: Array[Quest] = []
var quest_index = 0
var CURRENT_SPEED = SPEED

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = 50

@onready var head = $Head
@onready var camera = $Head/Camera3D
@onready var raycast = $Head/InteractRay
@onready var questtext = $HUD/QuestText

func get_quest():
	return QUESTS[quest_index]

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _unhandled_input(event):
	if event is InputEventMouseMotion:
		head.rotate_y(-event.relative.x * SENSITIVITY)
		camera.rotate_x(-event.relative.y * SENSITIVITY)
		camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-60), deg_to_rad(60))
		raycast.rotation.x = camera.rotation.x

func _process(_delta):
	questtext.text = "[center]CURRENT OBJECTIVE:\n%s" % get_quest().TITLE

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():velocity.y = JUMP_VELOCITY
		
	if Input.is_action_just_pressed("menu"): 
		get_tree().change_scene_to_file("res://Scenes/title_screen.tscn")
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	var direction = (head.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	CURRENT_SPEED = lerp(CURRENT_SPEED, SPRINT_SPEED if Input.is_action_pressed("sprint") else SPEED, 0.1)
	camera.fov = lerp(camera.fov, 95.0 if Input.is_action_pressed("sprint") else 80.0, 0.2)
	
	if direction:
		velocity.x = direction.x * CURRENT_SPEED
		velocity.z = direction.z * CURRENT_SPEED
	else:
		velocity.x = 0.0
		velocity.z = 0.0

	move_and_slide()


func _on_interactable_interacted(body, _interactable):	
	body.get_quest().complete(body)
	pass # Replace with function body.
