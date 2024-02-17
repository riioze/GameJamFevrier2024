extends StaticBody2D

@export var HAND : RigidBody2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _integrate_forces(state):
	rotation_degrees = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position = Vector2(HAND.position.x,HAND.position.y+100)
	
	var angle : float = position.direction_to(Vector2(1920,1080)).angle()-PI/2
	
	rotation = angle
