class_name Stuff extends RigidBody2D

@export var sprite : Resource
@onready var sprite_node : Sprite2D = $Sprite2D
@export_range(0,1) var table_friction : float = 0.2
@export_range(0,1) var air_friction : float = 0.01

var teleport_position : Vector2 = Vector2.ZERO
var is_teleporting: bool = false

@export var hover_scale : float = 1.5
@export var pickup_scale : float = 2
@onready var follow_node : RigidFollowNode = $RigidFollowNode

var is_airborn : bool = false

func _integrate_forces(state):
	if is_teleporting:
		var t = state.get_transform()
		t.origin.x = teleport_position.x
		t.origin.y =  teleport_position.y
		is_teleporting = false
		state.set_transform(t)

func _physics_process(delta):
	_apply_friction()

func _apply_friction():
	var friction : float = air_friction if is_airborn else table_friction
	angular_velocity = lerp(angular_velocity, 0.0, friction)
	linear_velocity = lerp(linear_velocity, Vector2.ZERO, friction)
	
func hover():
	scale = Vector2.ONE * hover_scale

func unhover():
	scale = Vector2.ONE
	
func pick_up(hand : Hand):
	scale = Vector2.ONE * pickup_scale
	follow_node.active = true
	follow_node.followed = hand
	
func let_go():
	scale = Vector2.ONE
	follow_node.active = false
	follow_node.followed = null
	
