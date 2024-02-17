class_name HandsManager extends Node

@onready var RightHand : Hand = $RightArm/Hand/Body
@onready var LeftHand : Hand = $LeftArm/Hand/Body

@onready var RightHandSprite : Sprite2D = $RightArm/Hand/HandSprite
@onready var LeftHandSprite : Sprite2D = $LeftArm/Hand/HandSprite

func activate(state : bool) -> void:
	LeftHandSprite.visible = state
	RightHandSprite.visible = state
	
	RightHand.active = state
	LeftHand.active = state
