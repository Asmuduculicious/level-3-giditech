extends CanvasLayer

@export var supply: Node
@export var steel: Node
@export var wood: Node
@export var money: Node
@export var craft_button: Node
@export var draft_button: Node
@export var trade_button: Node

func _ready() -> void:
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
