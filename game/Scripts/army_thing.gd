extends Node2D

@export var army_name: Node
@export var type = 0
@export var attack = 0
@export var hp = 0
@export var current_hp = 0
@export var tile = Vector2i(0,0)
@export var selected = false
var tile_list = []


func _ready() -> void:
	tile_list = global.tile_to_army[str(tile)]
	tile_list.append(army_name.text)
	global.tile_to_army[tile] = tile_list
	#print(global.tile_to_army)
