extends Node

var stuff_list : Array[Stuff] = []
var stuff_initial_position_list : Array[Vector2] = []
var table_width : float = 1920
var table_height : float = 1080
# Called when the node enters the scene tree for the first time.
func _ready():
	stuff_list = make_stuff_list(10)
	stuff_initial_position_list = make_position_list(10)
	
func _process(delta):
	pass
	
func make_position_list(count) -> Array[Vector2]:
	var position_list : Array[Vector2] = []
	for i in range(count):
		var position : Vector2 =  Vector2.ZERO
		position.x = randf_range(0,table_width)
		position.y = randf_range(0,table_height)
		position_list.append(position)
		
	return position_list
	
func place_stuff(stuff_list : Array[Stuff], stuff_position_list : Array[Vector2]) -> void:
	var count : int = stuff_list.size()
	
	for i in range(count):
		stuff_list[i].position = stuff_position_list[i]
	
	
func make_stuff_list(count : int) -> Array[Stuff]:
	var new_stuff_list : Array[Stuff] = []
	for i in range(count):
		new_stuff_list.append(make_stuff())
	return new_stuff_list
		
func make_stuff() -> Stuff:
	var new_stuff : Stuff = Stuff.new()
	return new_stuff
