class_name Side extends Resource

@export var name : String = "Side"
#@export var hand_origin : Vector2 = Vector2.ZERO
#@export var shoulder_origin : Vector2 = Vector2.ZERO
@export var is_mirrored : bool = false #left is mirrored

var multiplicator : int :
	get : return -1 if is_mirrored else 1

var elbow_id : int :
	get : return 0 if is_mirrored else 1
