extends Panel

func _ready() -> void:
	visible = false


func _on_button_buy_pressed() -> void:
	print("Beli")

func _on_button_upgrade_pressed() -> void:
	print("Tambah")

func _on_button_sell_pressed() -> void:
	print("Jual")

func _on_button_end_turn_pressed() -> void:
	visible = false
