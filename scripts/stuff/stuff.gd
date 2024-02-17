class_name Stuff extends RigidBody2D

#@export var texture_list : Array[Texture]
@onready var sprite_node : Sprite2D = $Sprite2D
@export_range(0,1) var table_friction : float = 0.2
@export_range(0,1) var air_friction : float = 0.01

var teleport_position : Vector2 = Vector2.ZERO
var is_teleporting: bool = false

var is_changing_scale : bool = false

var new_scale : float :
	set(value):
		#is_changing_scale = 
		get_child(0).scale = Vector2.ONE * value
		get_child(1).scale = Vector2.ONE * value
		new_scale = value
		
@export var hover_scale : float = 1.5
@export var pickup_scale : float = 2
@onready var follow_node : RigidFollowNode = $RigidFollowNode

var is_picked_up : bool = false

var is_airborn : bool = false

#func _ready():
	#sprite_node.texture = texture_list.pick_random()

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
	#print("hover")
	new_scale = hover_scale

func unhover():
	#print("hunover")
	new_scale = 1
	
func pick_up(hand : Hand):
	#print("pick up")
	is_picked_up = true
	follow_node.active = true
	follow_node.followed = hand
	new_scale = pickup_scale
	
func let_go():
	#print("let go")
	is_picked_up = false
	follow_node.active = false
	follow_node.followed = null
	new_scale = 1
	
