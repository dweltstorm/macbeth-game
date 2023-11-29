extends Container

@export var MIN_RADIUS : float = 5.0
@export var MAX_RADIUS : float = 10.0
var HOVERING : bool = false
@export var COLOR : Color = Color.WHITE

var current_radius = MIN_RADIUS
func _process(_delta):
	var factor = 0.5
	current_radius = lerp(current_radius, MAX_RADIUS if HOVERING else MIN_RADIUS, factor)
	queue_redraw()

func _draw():
	draw_circle(Vector2(0, 0), current_radius, COLOR)
