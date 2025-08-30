extends Node2D

@export var army_name: Node
@export var type = 0
@export var attack = 0
@export var hp = 0
@export var current_hp = 0
@export var selected = false

# In game information stored

@export var current_tile = Vector2i(0,0)
@export var target_tile = Vector2i(0,0)
var current_position = Vector2(0,0)

# When moving it, where it was and where it is moving to

var to_search = []
var searched = []
var tile_distance = {}
var currently_searching = Vector2i(0,0)
var distance = 0

# Used for searching for target tile

func _ready() -> void:
	var tmap: TileMapLayer = get_parent().parent.tilemap
	# Shortening variable name, tmap references the global tilemap
	global.tile_to_army[str(current_tile)].append(army_name.text)
	# When it is spawned, add it to the list of army currently on the tile
	
func _pathfinding() -> void:
	var tmap: TileMapLayer = get_parent().parent.tilemap
	
	# Triggers when this is moving
	
	to_search.append(tmap.local_to_map(tmap.map_to_local(current_tile) + Vector2(-96,0)))
	to_search.append(tmap.local_to_map(tmap.map_to_local(current_tile) + Vector2(96,0)))
	to_search.append(tmap.local_to_map(tmap.map_to_local(current_tile) + Vector2(-96,-111)))
	to_search.append(tmap.local_to_map(tmap.map_to_local(current_tile) + Vector2(96,-111)))
	to_search.append(tmap.local_to_map(tmap.map_to_local(current_tile) + Vector2(-96,111)))
	to_search.append(tmap.local_to_map(tmap.map_to_local(current_tile) + Vector2(96,111)))
	
	# Put all surrounding tile in an array
	
	for i in range(6):
		tile_distance[to_search[i]] = 1
		
	# Add them to dictionary with their starting distance being 1
	
	_search()
	

	 
func _search() -> void:
	var tmap: TileMapLayer = get_parent().parent.tilemap
	if to_search.size() > 0:
		# If there are still tiles to search
		currently_searching = to_search.pop_front()
		print(currently_searching)
		print(tmap.get_cell_tile_data(currently_searching))
		# Get the first one
		if tmap.get_cell_tile_data(currently_searching).get_custom_data("obstacle") == false:
			pass
			# Check if it's an obstacle, if it is then don't do anything
		elif searched.has(currently_searching) == true:
			pass
			# Check if it's already checked, if it is then don't do anything
		else:
			if currently_searching == target_tile:
			# If it has found the target tile
				to_search.clear()
				# Stop searching
				distance = tile_distance[currently_searching]
				# Get the amount of steps to get to there
			else:
				searched.append(currently_searching)
				# If it's not the target tile add it to searched array
				_get_surrounding(currently_searching, tile_distance[currently_searching] + 1)
				# Get the surrounding tiles of the tile currently_searching
				# As this is the second set of tiles, their tile distance increases by one
			_search()
			# Keep searching
	else:
		searched.clear()
		tile_distance.clear()
		print(distance)


func _get_surrounding(tile, distance) -> void:
	var tmap: TileMapLayer = get_parent().parent.tilemap
	to_search.append(tmap.local_to_map(tmap.map_to_local(tile) + Vector2(-96,0)))
	to_search.append(tmap.local_to_map(tmap.map_to_local(tile) + Vector2(96,0)))
	to_search.append(tmap.local_to_map(tmap.map_to_local(tile) + Vector2(-96,-111)))
	to_search.append(tmap.local_to_map(tmap.map_to_local(tile) + Vector2(96,-111)))
	to_search.append(tmap.local_to_map(tmap.map_to_local(tile) + Vector2(-96,111)))
	to_search.append(tmap.local_to_map(tmap.map_to_local(tile) + Vector2(96,111)))
	# Get the surrounding tiles

	tile_distance.merge({tmap.local_to_map(tmap.map_to_local(tile) + Vector2(-96,0)): distance})
	tile_distance.merge({tmap.local_to_map(tmap.map_to_local(tile) + Vector2(96,0)): distance})
	tile_distance.merge({tmap.local_to_map(tmap.map_to_local(tile) + Vector2(-96,-111)): distance})
	tile_distance.merge({tmap.local_to_map(tmap.map_to_local(tile) + Vector2(96,-111)): distance})
	tile_distance.merge({tmap.local_to_map(tmap.map_to_local(tile) + Vector2(-96,111)): distance})
	tile_distance.merge({tmap.local_to_map(tmap.map_to_local(tile) + Vector2(96,111)): distance})
	# Add them to the dictionary with the value being the distance
