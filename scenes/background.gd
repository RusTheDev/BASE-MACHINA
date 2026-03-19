@tool
extends Node2D

var circle_count = 8
var second_radius = 350
@warning_ignore("integer_division")
var base_radius = second_radius/2
var green: Color = Color("006400")

func _draw():
	draw_rect(Rect2(-1280,-800,2560,1600), Color("000014ff"))
	
	for i in range(circle_count):
		var currentRadius = i * base_radius
		draw_circle(Vector2(0,0), currentRadius, green, false, 0.9, true)
	
	for i in range(circle_count):
		var currentRadius = i * second_radius
		draw_circle(Vector2(0,0), currentRadius, green, false, 3.4, true)
	
