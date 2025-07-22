extends Button

@export var supply = 0
@export var wood = 0
@export var steel = 0
@export var money = 0
@export var product = []
@export var parent: Node


func _on_pressed() -> void:
	if global.supply >= supply and global.wood >= wood and global.steel >= steel and global.money >= money:
		global.supply -= supply
		global.wood -= wood
		global.steel -= steel
		global.money -= money
		global.equipment.append(product)
		parent._update_resources()
		
