extends Node2D

var supply = 5
var steel = 4
var wood = 3
var money = 10
var soldier = []
var weapon = []
var armor = []
var day = 1

var soldier_list = []

func _ready():
	for i in range(100):
		soldier_list.append(i)
	print(soldier_list)
