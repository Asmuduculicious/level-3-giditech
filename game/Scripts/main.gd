extends Node2D

@export var day_label: Node
@export var tilemap: Node
@export_range(1,15) var map_size = 0
@export var camera: Node
@export var ui_node: Node
@export var army_list: Node
@export var home_tile = Vector2i(0,0)
@export var submenu_open: bool
@export var mouse_follow: Node

var mouse_on_tile = Vector2i(0,0)
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
var army_on_tile = []
var selected_army = ""

var army_generated = []

func _ready() -> void:
	for y in range(map_size*2 - 1):
		if y < map_size:
			left_span = (y+1)/2
		elif y >= map_size:
			left_span = (map_size*2 -1 -y)/2
			
		if y < (map_size -1):
			for x in range(map_size + y):
				tilemap.set_cell(Vector2i(x - left_span,y), 0, Vector2i(0,1))
				global.tile_to_army[str(Vector2i(x-left_span, y))] = []
		elif y == map_size -1:
			for x in range(map_size*2 -1):
				tilemap.set_cell(Vector2i(x - left_span, y), 0, Vector2i(0,1))
				global.tile_to_army[str(Vector2i(x-left_span, y))] = []
		elif y > (map_size -1):
			for x in range(map_size*3 - 2 - y):
				tilemap.set_cell(Vector2i(x - left_span,y), 0, Vector2i(0,1))
				global.tile_to_army[str(Vector2i(x-left_span, y))] = []
		
		if y == (map_size*2) -2:
			tilemap.set_cell(Vector2i(-left_span, y), 0, Vector2i(1,3))
			home_tile = Vector2i(-left_span, y)
	
	#print(global.tile_to_army)

	day_label.text = "Day " + str(global.day)
	submenu_open = false
	
func _process(delta: float) -> void:
	mouse_follow.position = get_local_mouse_position()

func _input(event):
	if Input.is_action_pressed("left_click") and submenu_open == false: 
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
	
	if Input.is_action_just_pressed("left_click") and submenu_open == false:
		mouse_start = get_local_mouse_position()
	
	if Input.is_action_just_released("left_click") and submenu_open == false:
		mouse_end = get_local_mouse_position()
		if mouse_start == mouse_end:
			selected_tile_position = tilemap.local_to_map(mouse_end)
			selected_tile_data = tilemap.get_cell_tile_data(selected_tile_position)
			# If they didn't click and drag get the data of the tile they selected
			if mouse_on_tile == tilemap.local_to_map(mouse_end):
			# Gets the tile only if they are actually clicking on a tile
				if global.selected.size() == 0:
					# If they haven't selected anything
					army_on_tile = global.tile_to_army[str(selected_tile_position)]
					print(army_on_tile)
					# Get an array of what is on the tile from the global variable that is an dictionary with the key being the tile
					for i in range(army_on_tile.size()):
					# Repeat for each thing in the array
						for u in range(army_list.get_children().size()):
							army_generated.append(army_list.get_children()[u].name)
						# For all nodes instantiated, get their name to put into this array
						army_list.get_children()[army_generated.find("Army" + str(army_on_tile[i]))].selected = true
						# Get all the children, and get the ones selected and make them selected
						global.selected.append(army_list.get_children()[army_generated.find("Army" + str(army_on_tile[i]))])
						# Get all the selected children into an array
						print(global.selected)
						# Prints everything selected
					army_generated.clear()
					# Clears the array of all children after using it
				else:
					# if you have something selected
					print(global.selected.size())
					for i in range(army_list.get_children().size()):
						army_generated.append(army_list.get_children()[i])
							# Add all children name to an array
					for i in range(global.selected.size()):
						# Repeats for everything selected
						army_list.get_children()[army_generated.find(global.selected[i])].position = tilemap.map_to_local(selected_tile_position)
						# Finds all children that is selected in the instantiated scene and set their position to the new tile
	
					global.selected.clear()


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


func _on_area_2d_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	mouse_on_tile = body.local_to_map(get_local_mouse_position())
