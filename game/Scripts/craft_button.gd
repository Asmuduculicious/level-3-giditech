extends Button

@export var supply = 0
@export var wood = 0
@export var steel = 0
@export var money = 0
@export var product = ""
@export var parent: Node
@export var weapon: bool
@export var armor: bool

func _on_pressed() -> void:
	if (global.supply >= supply  
	and global.woood >= wood
	and global.steel >= steel
	and global.money >= money):
		global.supply -= supply
		global.wood -= wood
		global.steel -= steel
		global.money -= money
		if weapon == true:
			global.weapon.append(product)
		if armor == true:
			global.armor.append(product)
		parent._update_resources()
		
