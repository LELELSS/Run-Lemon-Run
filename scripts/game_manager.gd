extends Node

@onready var money_label: Label = $"../CanvasLayer/money_label"


var score = 0

func add_point():
	score += 1
	print(score)
	
func _process(delta: float) -> void:
	money_label.text = "Money: " + str(score)
