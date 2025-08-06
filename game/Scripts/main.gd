extends Node2D

@export var tilemap: Node
@export var map_size_x = 0
@export var map_size_y = 0
@export var camera: Node
var move_x = 0
var move_y = 0
var tile = 0
var current: Vector2 = Vector2(0.0, 0.0)
var previous: Vector2 = Vector2(0.0, 0.0)
var absolute = false

func _ready() -> void:
	for i in range(map_size_x):
		for a in range(map_size_y):
			tile = randi_range(1,3)
			if tile == 1:
				tilemap.set_cell(Vector2i(i,a), 0, Vector2i(0,1))
			elif tile == 2:
				tilemap.set_cell(Vector2i(i,a), 0, Vector2i(0,2))
			elif tile == 3:
				tilemap.set_cell(Vector2i(i,a), 0, Vector2i(0,3))

func _input(event):
	if Input.is_mouse_button_pressed(1):
		previous.x = event.position.x
		previous.y = event.position.y
		if absolute == false:
			absolute = true
			current.x = event.position.x
			current.y = event.position.y
		else:
			absolute = false
			previous.x = event.position.x
			previous.y = event.position.y
		move_x = current.x - previous.x
		move_y = current.y - previous.y
		camera.position.x += move_x
		camera.position.y += move_y
	else:
		absolute = false
