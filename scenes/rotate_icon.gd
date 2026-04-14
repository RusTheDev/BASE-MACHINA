@tool

extends Node2D

func _draw() -> void:
	var radius: float = 30
	var arc_thickness: float = 5
	
	var start_angle: float = -deg_to_rad(90)
	var end_angle: float = deg_to_rad(0)
	
	var start_angle1: float = deg_to_rad(90)
	var end_angle1: float = deg_to_rad(180)
	
	var first_tri_point: float = radius + 10
	var second_tri_point: float = first_tri_point + 10
	var mid_tri_point: float = (first_tri_point + second_tri_point)/2
	
	var triangle_points = PackedVector2Array([Vector2(first_tri_point,0),Vector2(second_tri_point,0),Vector2(mid_tri_point,10)])
	var triangle_points1 = PackedVector2Array([Vector2(-first_tri_point,0),Vector2(-second_tri_point,0),Vector2(-mid_tri_point,-10)])
	
	draw_circle(Vector2.ZERO, radius, Color.WHITE)
	draw_circle(Vector2(12, -12), radius - 20, Color.BLACK)
	
	draw_arc(Vector2.ZERO, radius + 15, start_angle, end_angle, 20, Color.WHITE, arc_thickness)
	draw_arc(Vector2.ZERO, radius + 15, start_angle1, end_angle1, 20, Color.WHITE, arc_thickness)
	
	draw_polygon(triangle_points,[ Color.WHITE ])
	draw_polygon(triangle_points1,[ Color.WHITE ])
	
