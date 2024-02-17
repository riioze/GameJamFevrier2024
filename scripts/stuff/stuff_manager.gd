class_name StuffManager extends Node

var stuff_list : Array[Stuff] = []
var initial_position_list : Array[Vector2] = []
var table_width : float = 1920
var table_height : float = 1080
var table_margin : float = 70
var stuff_count : int = 6
var stuff_padding : float = 250
#@onready var round_manager : RoundManager = SceneManager.game.round_manager
signal incr_sanity_signal(grade : Grade)

@export var texture_list : Array[Texture]

@onready var stuff_scene : Resource = preload("res://scenes/stuff/stuff.tscn")

func check_stuff_list_positions():
	for id in range(stuff_count):
		check_stuff_position(id)
		await TimeManager.sleep(0.25)
	return true

func check_stuff_position(id : int):
	var distance = stuff_list[id].position.distance_to(initial_position_list[id])
	var grade_list : Array[Grade] = SceneManager.game.get_node("sanity").grade_list
	var points:int = 0
	for grade : Grade in grade_list:
		if distance < grade.distance_floor:
			stuff_list[id].grade_sprite.texture = grade.sprite
			stuff_list[id].grade_sprite.visible = true
			incr_sanity_signal.emit(grade)
			SceneManager.game.gain_score(points)
			return
		points+=1
	
func scramble_stuff(count : int) -> void :
	count = min(count,stuff_count)
	var id_to_scramble_list : Array[int] = get_random_list_id(count,stuff_count)
	
	for id in id_to_scramble_list:
		var new_position = random_table_position()
		stuff_list[id].new_position = new_position
		#stuff_list[id].is_teleporting = true
		
func get_random_list_id(count : int, list_count : int) -> Array[int]:
	count = min(count,list_count)
	var id_list : Array[int] = []
	
	for i in range(count):
		var random_id : int = randi_range(0,list_count-1)
		while id_list.has(random_id):
			random_id = randi_range(0,list_count-1)
		id_list.append(random_id)
		
	return id_list
	
func round_setup(count) -> void:
	clear_stuff()
	#count = 20
	stuff_count = min(texture_list.size(), count)
	stuff_list = make_stuff_list(stuff_count)
	initial_position_list = make_position_list(stuff_count)
	place_stuff(stuff_list,initial_position_list)
	
func clear_stuff():
	for stuff in stuff_list:
		stuff.delete()
	stuff_list.clear()
	initial_position_list.clear()

func random_table_position() -> Vector2 :
	var position : Vector2 = Vector2.ZERO
	position.x = randf_range(table_margin,table_width-table_margin)
	position.y = randf_range(table_margin,table_height-table_margin)
	return position

func lowest_distance(position,pos_list):
	var lowest = position.distance_to(pos_list[0]) 
	for pos in pos_list:
		var distance = position.distance_to(pos)
		lowest = min(lowest, distance)
	return lowest
	
func make_position_list(count) -> Array[Vector2]:
	var position_list : Array[Vector2] = []
	for i in range(count):
		var position : Vector2 = random_table_position()
		if(position_list.size() > 0):
			var dist = lowest_distance(position,position_list)
			while dist < stuff_padding:
				#print(dist)
				position = random_table_position()
				dist = lowest_distance(position,position_list)
		position_list.append(position)
	
	return position_list
	
func place_stuff(stuff_list : Array[Stuff], position_list : Array[Vector2]) -> void:
	var count : int = stuff_list.size()
	
	for i in range(count):
		stuff_list[i].position = position_list[i]
	
func make_stuff_list(count : int) -> Array[Stuff]:
	var texture_list_copy = texture_list.duplicate()
	var new_stuff_list : Array[Stuff] = []
	for i in range(count):
		var new_stuff : Stuff = make_stuff()
		var texture_id : int = randi_range(0,texture_list_copy.size()-1)
		var texture : Texture = texture_list_copy[texture_id]
		texture_list_copy.remove_at(texture_id)
		new_stuff.sprite_node.texture = texture 
		new_stuff_list.append(new_stuff)
	return new_stuff_list
		
func make_stuff() -> Stuff:
	var stuff_instance : Stuff = stuff_scene.instantiate()
	add_child(stuff_instance)
	return stuff_instance
