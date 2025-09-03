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
var result_distance = 0

# Used for searching for target tile

func _ready() -> void:
	# Shortening variable name, tmap references the global tilemap
	global.tile_to_army[str(current_tile)].append(army_name.text)
	# When it is spawned, add it to the list of army currently on the tile
	
func _pathfinding() -> void:
	# This triggers after you attempt to move an army
	
	
	searched.append(current_tile)
	tile_distance[current_tile] = 0
	# This adds the current tile to the searched tile list
	
	if current_tile.y % 2 == 1:
		if global.tile_to_army.has(str(current_tile + Vector2i(0,-1))):
			to_search.append(current_tile + Vector2i(0, -1))
		if global.tile_to_army.has(str(current_tile + Vector2i(+1,-1))):
			to_search.append(current_tile + Vector2i(+1, -1))
		if global.tile_to_army.has(str(current_tile + Vector2i(-1, 0))):
			to_search.append(current_tile + Vector2i(-1, 0))
		if global.tile_to_army.has(str(current_tile + Vector2i(1,0))):
			to_search.append(current_tile + Vector2i(1, 0))
		if global.tile_to_army.has(str(current_tile + Vector2i(1,1))):
			to_search.append(current_tile + Vector2i(1, 1))
		if global.tile_to_army.has(str(current_tile + Vector2i(0,1))):
			to_search.append(current_tile + Vector2i(0, 1))
	else:
		if global.tile_to_army.has(str(current_tile + Vector2i(-1,-1))):
			to_search.append(current_tile + Vector2i(-1, -1))
		if global.tile_to_army.has(str(current_tile + Vector2i(0,-1))):
			to_search.append(current_tile + Vector2i(0, -1))
		if global.tile_to_army.has(str(current_tile + Vector2i(-1, 0))):
			to_search.append(current_tile + Vector2i(-1, 0))
		if global.tile_to_army.has(str(current_tile + Vector2i(1,0))):
			to_search.append(current_tile + Vector2i(1, 0))
		if global.tile_to_army.has(str(current_tile + Vector2i(-1,1))):
			to_search.append(current_tile + Vector2i(-1, 1))
		if global.tile_to_army.has(str(current_tile + Vector2i(0,1))):
			to_search.append(current_tile + Vector2i(0, 1))
	
	# Put all surrounding tile in an array to be searched
	
	for i in range(to_search.size()):
		tile_distance[to_search[i]] = 1
		
	# Add them to dictionary with their starting distance being 1
	
	_search()
	

func _search() -> void:
	
	# This is self-repeating and will repeat until there are no more tile to search
	
	if to_search.size() > 0:
		# If there are still tiles to search
		currently_searching = to_search.pop_front()
		
		# Gets the first item in the list of things to search
		
		
		if global.tile_info.has(str(currently_searching)):
			
			if currently_searching == target_tile:
				# When it has found the target tile
				result_distance = tile_distance[currently_searching]
				# Gets the resultant distance
				print(result_distance)
				
				to_search.clear()
				searched.clear()
				tile_distance.clear()
				# Clears everything
				
				
			else:
				# When it has found a tile that isn't the target
				searched.append(currently_searching)
				# Adds the current tile to the tiles searched
				_get_surrounding(currently_searching, tile_distance[currently_searching] + 1)
				# Get the surrounding tiles and add them to the to search list
				# Their distance from the starting point is 1 further from the current
				_search()
		
		if global.tile_info[str(currently_searching)].has("obstacle"):
			pass
			# Check if it's an obstacle, if it is then don't do anything
		elif searched.has(currently_searching):
			pass
			# Check if it's already checked, if it is then don't do anything


func _get_surrounding(tile, distance) -> void:
	if tile.y % 2 == 0:
		if global.tile_info.has(str(tile + Vector2i(-1, -1))):
			# Checks if the tile to the up left exists
			if (not searched.has(tile + Vector2i(-1, -1)) 
			and not global.tile_info[str(tile + Vector2i(-1, -1))].has("obstacle")
			and not to_search.has(tile + Vector2i(-1, -1))):
				# Only runs if the tile haven't been checked before
				# And it is not an obstacle
				# And it is not already in the to search
				tile_distance[tile + Vector2i(-1, -1)] = distance
				to_search.append(tile + Vector2i(-1, -1))
				# Add this to the tile distance dictionary

		if global.tile_info.has(str(tile + Vector2i(0, -1))):
			# Checks if the tile to the up left exists
			if (not searched.has(tile + Vector2i(0, -1)) 
			and not global.tile_info[str(tile + Vector2i(0, -1))].has("obstacle")
			and not to_search.has(tile + Vector2i(0, -1))):
				# Only runs if the tile haven't been checked before
				# And it is not an obstacle
				# And it is not already in the to search
				tile_distance[tile + Vector2i(0, -1)] = distance
				to_search.append(tile + Vector2i(0, -1))
				# Add this to the tile distance dictionary

		if global.tile_info.has(str(tile + Vector2i(-1, 0))):
			# Checks if the tile to the up left exists
			if (not searched.has(tile + Vector2i(-1, 0)) 
			and not global.tile_info[str(tile + Vector2i(-1, 0))].has("obstacle")
			and not to_search.has(tile + Vector2i(-1, 0))):
				# Only runs if the tile haven't been checked before
				# And it is not an obstacle
				# And it is not already in the to search
				tile_distance[tile + Vector2i(-1, 0)] = distance
				to_search.append(tile + Vector2i(-1, 0))
				# Add this to the tile distance dictionary

		if global.tile_info.has(str(tile + Vector2i(1, 0))):
			# Checks if the tile to the up left exists
			if (not searched.has(tile + Vector2i(1, 0)) 
			and not global.tile_info[str(tile + Vector2i(1, 0))].has("obstacle")
			and not to_search.has(tile + Vector2i(1, 0))):
				# Only runs if the tile haven't been checked before
				# And it is not an obstacle
				# And it is not already in the to search
				tile_distance[tile + Vector2i(1, 0)] = distance
				to_search.append(tile + Vector2i(1, 0))
				# Add this to the tile distance dictionary

		if global.tile_info.has(str(tile + Vector2i(-1, 1))):
			# Checks if the tile to the up left exists
			if (not searched.has(tile + Vector2i(-1, 1)) 
			and not global.tile_info[str(tile + Vector2i(-1, 1))].has("obstacle")
			and not to_search.has(tile + Vector2i(-1, 1))):
				# Only runs if the tile haven't been checked before
				# And it is not an obstacle
				# And it is not already in the to search
				tile_distance[tile + Vector2i(-1, 1)] = distance
				to_search.append(tile + Vector2i(-1, 1))
				# Add this to the tile distance dictionary

		if global.tile_info.has(str(tile + Vector2i(0, 1))):
			# Checks if the tile to the up left exists
			if (not searched.has(tile + Vector2i(0, 1)) 
			and not global.tile_info[str(tile + Vector2i(0, 1))].has("obstacle")
			and not to_search.has(tile + Vector2i(0, 1))):
				# Only runs if the tile haven't been checked before
				# And it is not an obstacle
				# And it is not already in the to search
				tile_distance[tile + Vector2i(0, 1)] = distance
				to_search.append(tile + Vector2i(0, 1))
				# Add this to the tile distance dictionary
	else:
		if global.tile_info.has(str(tile + Vector2i(0, -1))):
			# Checks if the tile to the up left exists
			if (not searched.has(tile + Vector2i(0, -1)) 
			and not global.tile_info[str(tile + Vector2i(0, -1))].has("obstacle")
			and not to_search.has(tile + Vector2i(0, -1))):
				# Only runs if the tile haven't been checked before
				# And it is not an obstacle
				# And it is not already in the to search
				tile_distance[tile + Vector2i(0, -1)] = distance
				to_search.append(tile + Vector2i(0, -1))
				# Add this to the tile distance dictionary

		if global.tile_info.has(str(tile + Vector2i(+1, -1))):
			# Checks if the tile to the up left exists
			if (not searched.has(tile + Vector2i(+1, -1)) 
			and not global.tile_info[str(tile + Vector2i(+1, -1))].has("obstacle")
			and not to_search.has(tile + Vector2i(+1, -1))):
				# Only runs if the tile haven't been checked before
				# And it is not an obstacle
				# And it is not already in the to search
				tile_distance[tile + Vector2i(+1, -1)] = distance
				to_search.append(tile + Vector2i(+1, -1))
				# Add this to the tile distance dictionary

		if global.tile_info.has(str(tile + Vector2i(-1, 0))):
			# Checks if the tile to the up left exists
			if (not searched.has(tile + Vector2i(-1, 0)) 
			and not global.tile_info[str(tile + Vector2i(-1, 0))].has("obstacle")
			and not to_search.has(tile + Vector2i(-1, 0))):
				# Only runs if the tile haven't been checked before
				# And it is not an obstacle
				# And it is not already in the to search
				tile_distance[tile + Vector2i(-1, 0)] = distance
				to_search.append(tile + Vector2i(-1, 0))
				# Add this to the tile distance dictionary

		if global.tile_info.has(str(tile + Vector2i(1, 0))):
			# Checks if the tile to the up left exists
			if (not searched.has(tile + Vector2i(1, 0)) 
			and not global.tile_info[str(tile + Vector2i(1, 0))].has("obstacle")
			and not to_search.has(tile + Vector2i(1, 0))):
				# Only runs if the tile haven't been checked before
				# And it is not an obstacle
				# And it is not already in the to search
				tile_distance[tile + Vector2i(1, 0)] = distance
				to_search.append(tile + Vector2i(1, 0))
				# Add this to the tile distance dictionary

		if global.tile_info.has(str(tile + Vector2i(0, 1))):
			# Checks if the tile to the up left exists
			if (not searched.has(tile + Vector2i(0, 1)) 
			and not global.tile_info[str(tile + Vector2i(0, 1))].has("obstacle")
			and not to_search.has(tile + Vector2i(0, 1))):
				# Only runs if the tile haven't been checked before
				# And it is not an obstacle
				# And it is not already in the to search
				tile_distance[tile + Vector2i(0, 1)] = distance
				to_search.append(tile + Vector2i(0, 1))
				# Add this to the tile distance dictionary

		if global.tile_info.has(str(tile + Vector2i(1, 1))):
			# Checks if the tile to the up left exists
			if (not searched.has(tile + Vector2i(1, 1)) 
			and not global.tile_info[str(tile + Vector2i(1, 1))].has("obstacle")
			and not to_search.has(tile + Vector2i(1, 1))):
				# Only runs if the tile haven't been checked before
				# And it is not an obstacle
				# And it is not already in the to search
				tile_distance[tile + Vector2i(1, 1)] = distance
				to_search.append(tile + Vector2i(1, 1))
				# Add this to the tile distance dictionary
