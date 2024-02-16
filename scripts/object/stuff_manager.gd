extends Node

var stuff_list : Array[Stuff] = []
var initial_position_list : Array[Vector2] = []
var table_width : float = 1920
var table_height : float = 1080
var stuff_count : int = 6
@onready var stuff_scene : Resource = preload("res://scenes/stuff.tscn")

func _ready():
	round_setup()
	await TimeManager.sleep(1)
	scramble_stuff(4)

func get_random_list_id(count : int, list_count : int) -> Array[int]:
	count = min(count,list_count)
	var id_list : Array[int] = []
	
	for i in range(count):
		var random_id : int = randi_range(0,list_count)
		while id_list.has(random_id):
			random_id = randi_range(0,list_count)
		id_list.append(random_id)
		
	return id_list
		
func scramble_stuff(count : int) -> void :
	count = min(count,stuff_count)
	var id_to_scramble_list : Array[int] = get_random_list_id(count,stuff_count)
	
	for id in id_to_scramble_list:
		stuff_list[id].position = random_table_position()
	
func round_setup() -> void:
	stuff_list = make_stuff_list(stuff_count)
	initial_position_list = make_position_list(stuff_count)
	place_stuff(stuff_list,initial_position_list)

func random_table_position() -> Vector2:
	var position : Vector2 = Vector2.ZERO
	position.x = randf_range(0,table_width)
	position.y = randf_range(0,table_height)
	return position
	
func make_position_list(count) -> Array[Vector2]:
	var position_list : Array[Vector2] = []
	for i in range(count):
		var position : Vector2 = random_table_position()
		position_list.append(position)
		
	return position_list
	
func place_stuff(stuff_list : Array[Stuff], position_list : Array[Vector2]) -> void:
	var count : int = stuff_list.size()
	
	for i in range(count):
		stuff_list[i].position = position_list[i]
	
	
func make_stuff_list(count : int) -> Array[Stuff]:
	var new_stuff_list : Array[Stuff] = []
	for i in range(count):
		new_stuff_list.append(make_stuff())
	return new_stuff_list
		
func make_stuff() -> Stuff:
	var stuff_instance : Stuff = stuff_scene.instantiate()
	add_child(stuff_instance)
	return stuff_instance
