extends PanelContainer
var soldier_number = 0

@export var unit_name: Node
@export var type_label: Node
@export var attack_label: Node
@export var hp_label: Node
@export var current_hp_label: Node
@export var weapon: Node
@export var armor: Node

var type = 0
var attack = 0
var hp = 0
var current_hp = 0

var current_weapon = ""
var current_armor = ""

func _ready() -> void:
	unit_name.text = (str(soldier_number))
	type_label.text = (str(type))
	attack_label.text = (str(attack))
	hp_label.text = (str(hp))
	current_hp_label.text = (str(current_hp))

	for i in range(global.armor.size()):
		armor.add_item(str(global.armor[i]))
	for i in range(global.weapon.size()):
		weapon.add_item(str(global.weapon[i]))

func _update_status() -> void:
	current_weapon = weapon.get_item_text(weapon.selected)
	current_armor = armor.get_item_text(armor.selected)
	armor.clear()
	weapon.clear()
	weapon.add_item(current_weapon)
	armor.add_item(current_armor)
	if current_weapon == "Level 0 gun":
		attack_label.text = "1"
	elif current_weapon == "Level 1 gun":
		attack_label.text = "3"
	elif current_weapon == "Level 2 gun":
		attack_label.text = "6"
	elif current_weapon == "Level 3 gun":
		attack_label.text = "10"
		
	if current_armor == "Level 0 armor":
		hp_label.text = "5"
	elif current_armor == "Level 1 armor":
		hp_label.text = "7"
	elif current_armor == "Level 2 armor":
		hp_label.text = "13"
	elif current_armor == "Level 3 armor":
		hp_label.text = "21"
		
	for i in range(global.armor.size()):
		armor.add_item(str(global.armor[i]))
	for i in range(global.weapon.size()):
		weapon.add_item(str(global.weapon[i]))
	if not weapon.get_item_text(weapon.selected) == "Level 0 gun":
		weapon.add_item("Level 0 gun")
	if not armor.get_item_text(armor.selected) == "Level 0 armor":
		armor.add_item("Level 0 armor")
	

func _on_armor_item_selected(index: int) -> void:
	if not current_armor == "Level 0 armor":
		global.armor.append(current_armor)
	if not armor.get_item_text(index) == "Level 0 armor":
		global.armor.erase(armor.get_item_text(index))
	for i in get_parent().get_children():
		i._update_status()

func _on_weapon_item_selected(index: int) -> void:
	if not current_weapon == "Level 0 gun":
			global.weapon.append(current_weapon)
	if not weapon.get_item_text(weapon.selected) == "Level 0 gun":
		global.weapon.erase(weapon.get_item_text(weapon.selected))
	for i in get_parent().get_children():
		i._update_status()
