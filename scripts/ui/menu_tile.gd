extends Panel

func _ready() -> void:
	visible = false

#func enable() -> void:
	#

func _on_button_buy_pressed() -> void:
	var player = GameMaster.get_pawn(GameMaster.current_turn)
	GameMaster.get_tile(player.tile_index).change_color(player.color)

func _on_button_upgrade_pressed() -> void:
	print("Tambah")

func _on_button_end_turn_pressed() -> void:
	visible = false
	var player = GameMaster.get_pawn(GameMaster.current_turn)
	player.turn_complete.emit(player.index)
