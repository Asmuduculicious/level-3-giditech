extends PanelContainer
var soldier_number = 0

@export var unit_name: Node
@export var type: Node
@export var attack: Node
@export var hp: Node
@export var current_hp: Node

func _process(float) -> void:
	unit_name.text = (str(global.soldier[soldier_number][0] + 1))
	type.text = (str(global.soldier[soldier_number][1]))
	attack.text = (str(global.soldier[soldier_number][2]))
	hp.text = (str(global.soldier[soldier_number][3]) + "/")
	current_hp.text = (str(global.soldier[soldier_number][4]))
