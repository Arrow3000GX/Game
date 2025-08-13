extends CollisionPolygon2D

var original_polygon = []

func _ready():
	original_polygon = polygon.duplicate()
	flip_polygon(true)
	

func flip_polygon(face_left: bool):
	var new_poly = []
	for point in original_polygon:
		var x = (point.x)
		if face_left:
			x = -x
		new_poly.append(Vector2(x, point.y))
	polygon = new_poly
