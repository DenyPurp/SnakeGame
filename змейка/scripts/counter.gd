extends CanvasLayer

@export var head_snake : CharacterBody2D 
@onready var label: Label = %Label

func _process(_delta):
	if head_snake == null:
		return
	
	var count_circles = head_snake.count_circle
	label.text = "Круги: " + str(count_circles)
