extends Panel
class_name MenuGamble

var chosen : int

@onready var button_front: Button = $"MarginContainer/VBoxContainer/HBoxContainer/Panel Front/Button Front"
@onready var button_back: Button = $"MarginContainer/VBoxContainer/HBoxContainer/Panel Back/Button Back"
@onready var button_end_turn: Button = $"MarginContainer/VBoxContainer/Panel End Turn/Button End Turn"

func _ready() -> void:
	visible = false

func set_enable(value : bool) -> void:
	visible = value
	
	if value:
		chosen = randi_range(0, 1)
		print("CHOSEN: ", chosen)
	else:
		chosen = -1

func _on_button_front_pressed() -> void:
	if chosen == 0:
		print("ANDA MENANG!")
	else:
		print("ANDA KALAH!")
	
	set_enable(false)
	GameMaster.end_current_turn()


func _on_button_back_pressed() -> void:
	if chosen == 1:
		print("ANDA MENANG!")
	else:
		print("ANDA KALAH!")
	
	set_enable(false)
	GameMaster.end_current_turn()


func _on_button_end_turn_pressed() -> void:
	set_enable(false)
	GameMaster.end_current_turn()
