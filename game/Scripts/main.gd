extends Node2D

@export var day_label: Node
@export var tilemap: Node
@export_range(1,15) var map_size = 0
@export var camera: Node
@export var ui_node: Node
@export var army_list: Node

var mouse_start = Vector2(0,0)
var mouse_end = Vector2(0,0)
var selected_tile_position = Vector2i(0,0)
var selected_tile_data: TileData
var move_x = 0
var move_y = 0
var current: Vector2 = Vector2(0.0, 0.0)
var previous: Vector2 = Vector2(0.0, 0.0)
var absolute = false
var left_span = 0

func _ready() -> void:
	for y in range(map_size*2 - 1):
		if y < map_size:
			left_span = (y+1)/2
		elif y >= map_size:
			left_span = (map_size*2 -1 -y)/2
			
		if y < (map_size -1):
			for x in range(map_size + y):
				tilemap.set_cell(Vector2i(x - left_span,y), 0, Vector2i(0,1))
		elif y == map_size -1:
			for x in range(map_size*2 -1):
				tilemap.set_cell(Vector2i(x - left_span, y), 0, Vector2i(0,1))
		elif y > (map_size -1):
			for x in range(map_size*3 - 2 - y):
				tilemap.set_cell(Vector2i(x - left_span,y), 0, Vector2i(0,1))

	day_label.text = "Day " + str(global.day)

func _input(event):
	if Input.is_action_pressed("left_click"): 
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
	
	if Input.is_action_just_pressed("left_click"):
		mouse_start = get_local_mouse_position()
	
	if Input.is_action_just_released("left_click"):
		mouse_end = get_local_mouse_position()
		if mouse_start == mouse_end:
			selected_tile_position = tilemap.local_to_map(mouse_end)
			selected_tile_data = tilemap.get_cell_tile_data(selected_tile_position)

func _on_zoom_out_pressed() -> void:
	camera.zoom.x *= 0.9
	camera.zoom.y *= 0.9


func _on_zoom_in_pressed() -> void:
	camera.zoom.x *= 1.1
	camera.zoom.y *= 1.1


func _next_day() -> void:
	global.day += 1
	day_label.text = "Day " + str(global.day)
	global.supply += global.day*5
	global.steel += global.day
	global.wood += global.day*2
	global.money += global.day*10
	ui_node._update_resources()
