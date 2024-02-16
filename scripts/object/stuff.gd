class_name Stuff extends RigidBody2D

@export var sprite : Resource
@onready var sprite_node : Sprite2D = $Sprite2D
@export_range(0,1) var table_friction : float = 0.2
@export_range(0,1) var air_friction : float = 0.01

var is_airborn : bool = false

func _ready():
	pass # Replace with function body.


func _physics_process(delta):
	_apply_friction()

func _apply_friction():
	var friction : float = air_friction if is_airborn else table_friction
	angular_velocity = lerp(angular_velocity, 0.0, friction)
	linear_velocity = lerp(linear_velocity, Vector2.ZERO, friction)
