class_name Clock extends Sprite2D

@export var texture_list : Array[Texture]

func reset():
	texture = texture_list[0]
	
func run_clock(duration : float) -> bool:
	var texture_count : int = texture_list.size()
	
	if texture_count == 0: 
		await TimeManager.sleep(duration)
		return true
		
	for tex in texture_list:
		texture = tex
		await TimeManager.sleep(duration/texture_count)
		
	return true
