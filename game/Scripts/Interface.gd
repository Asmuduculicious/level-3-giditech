extends CanvasLayer

@export var supply: Node
@export var steel: Node
@export var wood: Node
@export var money: Node
@export var craft_button: Node
@export var draft_button: Node
@export var trade_button: Node
@export var craft_menu: Node
@export var draft_menu: Node
@export var trade_menu: Node
@export var soldier_list: Node

func _ready() -> void:
	craft_menu.visible = false
	draft_menu.visible = false
	trade_menu.visible = false
	supply.text = ("Supplies: " + str(global.supply))
	steel.text = ("Steel: " + str(global.steel))
	wood.text = ("Wood: " + str(global.wood))
	money.text = ("Money: " + str(global.money))

func _update_resources() -> void:
	supply.text = ("Supplies: " + str(global.supply))
	steel.text = ("Steel: " + str(global.steel))
	wood.text = ("Wood: " + str(global.wood))
	money.text = ("Money: " + str(global.money))

func _process(float) -> void:
	pass
	
func _on_craft_button_pressed() -> void:
	if craft_menu.visible == true:
		craft_menu.visible = false
	else:
		craft_menu.visible = true
		draft_menu.visible = false
		trade_menu.visible = false

func _on_draft_button_pressed() -> void:
	for i in soldier_list.get_children():
		i._update_status()
	if draft_menu.visible == true:
		draft_menu.visible = false
	else:
		craft_menu.visible = false
		draft_menu.visible = true
		trade_menu.visible = false

func _on_trade_button_pressed() -> void:
	if trade_menu.visible == true:
		trade_menu.visible = false
	else:
		craft_menu.visible = false
		draft_menu.visible = false
		trade_menu.visible = true
		
