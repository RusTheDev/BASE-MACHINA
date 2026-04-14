@tool

extends Node2D

func _draw() -> void:
	var white: Color = Color(1.0, 1.0, 1.0, 1.0)
	var tri_point: float = 10
	var trep_point: float = 20
	var top_trep: float = 6
	var bottom_trep: float = top_trep + 10
	var triangle_points = PackedVector2Array([Vector2(-tri_point,-10),Vector2(tri_point,-10),Vector2(0,0)])
	var trepozoid_points = PackedVector2Array([Vector2(-trep_point,top_trep),Vector2(trep_point,top_trep),Vector2(trep_point+4,bottom_trep),Vector2(-trep_point-4,bottom_trep)])
	
	draw_line(Vector2(0,-10),Vector2(0,-30),white,6.0)
	draw_polygon(triangle_points, [white])
	draw_polygon(trepozoid_points, [white])
