@tool
extends Node2D

var circle_count = 8
var second_radius = 170
@warning_ignore("integer_division")
var base_radius = second_radius/2
var center = Vector2(640,400)
var green: Color = Color("006400")

func _draw():
	draw_rect(Rect2(0, 0,1280,800), Color("000014ff"))
	
	for i in range(circle_count):
		var currentRadius = i * base_radius
		draw_circle(center, currentRadius, green, false, 0.9, true)
	
	for i in range(circle_count):
		var currentRadius = i * second_radius
		draw_circle(center, currentRadius, green, false, 3.4, true)
