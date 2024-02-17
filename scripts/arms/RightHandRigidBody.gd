extends RigidBody2D

@export var SPEED : int = 100
@export var STARTING_POS : Vector2 = Vector2(1000,100)

# Called when the node enters the scene tree for the first time.
func _ready():
	position = STARTING_POS # Replace with function body.
	set_linear_velocity(Vector2(0,0))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
		
	
func _integrate_forces(state):
	rotation_degrees = 0

func _input(event):
	set_linear_velocity(SPEED*Input.get_vector("MoveRightArmToLeft","MoveRightArmToRight","MoveRightArmToTop","MoveRightArmToBottom"))
