class_name RoundManager extends Node

var day : int = 0
@onready var game_manager : GameManager = SceneManager.game

# 1st day 
# 3 stuff
# 1 moving
# 5 sec read
# 10 sec order

# increase
# 0.25 second less order every day
# 2.5 second more order every 10 day

# 1 new stuff every 2 days
# 1 new moving item every 3 days

@export var recognition_duration : float = 8
@export var ordering_duration : float = 15
@export var stuff_count : int = 3
@export var moving_stuff_count : int = 1

@export var recognition_incr : float = 0
@export var ordering_incr : float = -0.25
@export var stuff_incr : int = 1
@export var moving_stuff_incr : int = 1

@export var recognition_delay : int = 1
@export var ordering_delay : int = 1
@export var stuff_delay : int = 2
@export var moving_stuff_delay : int = 3

func new_round():
	day += 1
	if(day > 1): incr()
	game_manager.stuff_manager.round_setup(stuff_count)
	game_manager.process_round()

func incr():
	recognition_duration += incr_elem(recognition_incr,recognition_delay)
	recognition_duration += incr_elem(-10 * recognition_incr, 10 * recognition_delay)
	ordering_duration += incr_elem(ordering_incr,ordering_delay)
	ordering_duration += incr_elem(-10 * ordering_incr, 10 * ordering_delay)
	stuff_count += incr_elem(stuff_incr,stuff_delay)
	moving_stuff_count += incr_elem(moving_stuff_incr,moving_stuff_delay)
	
func incr_elem(incr, delay):
	return incr if day % delay == 0 else 0
