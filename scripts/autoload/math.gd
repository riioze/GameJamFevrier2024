extends Node

func circle_intersections(pos1 : Vector2,pos2 : Vector2,r1 : float,r2 : float) -> Array[Vector2]:
	var x1 = pos1.x
	var y1 = pos1.y
	var x2 = pos2.x
	var y2 = pos2.y
	
#	print(x1)
	
	var X = x2-x1
	var Y = y2-y1
	var R = r2-r1
	
	var a = 2*X
	var b = 2*Y
	var c = X**2 + Y**2 - (r2**2 - r1**2)
#	print(a,b,c)
	var ac = a*c
	var a2pb2= a**2+b**2
	
	var D = (2*ac)**2 - 4*a2pb2 * (c**2-(b*r1)**2)
	
	var d = sqrt(D)
	
	var xA = x2 - (2*ac - d) / (2*a2pb2)
	var xB = x2 - (2*ac + d) / (2*a2pb2)
	
	var yA
	var yB
	
	if b != 0:
		yA = y1 + (c-a*(xA-x1)) / b
		yB = y1 + (c-a*(xB-x1)) / b
	else:
#		print("b = 0")
		yA = y1 + b/2 + sqrt(r2**2 - ((2*c-a**2)/(2*a))**2)
		yB = yA
	
	var posA = Vector2(xA,yA)
	var posB = Vector2(xB,yB)
	
	var res : Array[Vector2] = []
	if(y1 >= y2):
		res = [posA,posB]
	else:
		res = [posB,posA]
#	var res = [Vector2(yA,xA),Vector2(xB,yB)]
#	var res = [Vector2(xA,0),Vector2(xB,0)]
#	print(res)
	return res
