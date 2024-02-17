class_name Hand extends RigidBody2D

var input_direction : Vector2 = Vector2.ZERO	

var hand_origin : Vector2 = Vector2(1920/2, 1080/2)
var hand_separation_origin : float = 100

var shoulder_origin : Vector2 = Vector2(1920/2, 1080)
var shoulder_separation_origin : float = 1920 /2

@export var elbow_node : Node2D

enum hand_side {Left, Right}

@export var side : Side

var speed : float = 50000

var teleport_position : Vector2 = Vector2.ZERO
var is_teleporting: bool = false

var forearm_lenght : float = 700
var arm_lenght : float = 700

@onready var stuff_manager : StuffManager = SceneManager.game.get_node("stuffs")
var closest_stuff : Stuff
var old_closest_stuff : Stuff
var picked_stuff : Stuff

@export var pickup_distance : float = 50

func _ready():
	hand_origin += side.multiplicator * Vector2(hand_separation_origin,0)
	shoulder_origin += side.multiplicator * Vector2(shoulder_separation_origin,0)
	teleport_position = hand_origin
	is_teleporting = true
	
func _integrate_forces(state):
	if is_teleporting:
		var t = state.get_transform()
		t.origin.x = teleport_position.x
		t.origin.y = teleport_position.y
		is_teleporting = false
		state.set_transform(t)
		
func get_closest_stuff() -> Stuff:
	var stuff_list = stuff_manager.stuff_list
	if(stuff_list.size() == 0): return null
	
	var closest : Stuff = stuff_manager.stuff_list[0]
	var closest_distance = position.distance_to(closest.position)
	for stuff in stuff_list:
		var distance = position.distance_to(stuff.position)
		if distance < closest_distance:
			closest_distance = distance
			closest = stuff
			
	if(closest_distance > pickup_distance): return null
	return closest
		
func _process(delta):
	#print(shoulder_origin.distance_to(position))
	if shoulder_origin.distance_to(position) > arm_lenght + forearm_lenght:
		input_direction = position.direction_to(shoulder_origin).normalized()
	else :
		input_direction = Input.get_vector(
			"Move"+side.name+"ArmToLeft",
			"Move"+side.name+"ArmToRight",
			"Move"+side.name+"ArmToTop",
			"Move"+side.name+"ArmToBottom"
		)
	
	elbow_node.position = Math.circle_intersections(position,shoulder_origin,forearm_lenght,arm_lenght)[side.elbow_id]
	
	closest_stuff = get_closest_stuff()
	if closest_stuff != old_closest_stuff:
		if old_closest_stuff != null: old_closest_stuff.unhover()
		if closest_stuff != null: closest_stuff.hover()
		
func _physics_process(delta):
	set_linear_velocity(delta*speed*input_direction)

func _input(event):
	if event.is_action_pressed("Grab"+side.name):
		pick_up()
	elif event.is_action_released("Grab"+side.name):
		let_go()
		
func let_go():
	if picked_stuff == null : return
	picked_stuff.let_go()
	picked_stuff = null
	
func pick_up():
	if closest_stuff == null : return
	closest_stuff.pick_up(self)
	picked_stuff = closest_stuff
