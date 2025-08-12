extends Button

var soldier_number = 0
@export var army_scene: PackedScene
@export var soldier_panel: PackedScene
@export var parent: Node
@export var type = 0
@export var attack = 0
@export var hp = 0
@export var current_hp = 0
@export var money = 0
@export var supply = 0

func _on_button_pressed() -> void:
	if global.money >= money:
		global.money -= money
		parent._update_resources()

		soldier_number = len(global.soldier)
		global.soldier.append([soldier_number, type, attack, hp, current_hp,""])
		var soldier = soldier_panel.instantiate()
		soldier.soldier_number = soldier_number
		parent.soldier_list.add_child(soldier)
		
		var army = army_scene.instanciate()
		
		
		
