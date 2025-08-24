extends Button

@export var army_scene: PackedScene
@export var soldier_panel: PackedScene
@export var parent: Node
@export var type = 0
@export var attack = 0
@export var hp = 0
@export var current_hp = 0
@export var money = 0
@export var supply = 0

var soldier_number = 0

func _on_button_pressed() -> void:
	if global.money >= money:
		global.money -= money
		parent._update_resources()

		soldier_number = global.soldier_list.pop_back()
		
		global.soldier.append([soldier_number, type, attack, hp, current_hp,""])
		
		var soldier = soldier_panel.instantiate()
		soldier.soldier_number = soldier_number
		soldier.type = type
		soldier.attack = attack
		soldier.hp = hp
		soldier.current_hp = hp
		parent.soldier_list.add_child(soldier)
		
		
		var army = army_scene.instantiate()
		army.army_name.text = str(soldier_number)
		army.position = parent.get_parent().tilemap.map_to_local(parent.get_parent().home_tile)
		army.tile = parent.get_parent().home_tile
		army.name = ("Army" + str(soldier_number))
		parent.get_parent().army_list.add_child(army)
		
		
		
