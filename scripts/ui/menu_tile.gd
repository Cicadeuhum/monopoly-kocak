extends  Panel
class_name MenuTile

@onready var button_buy: Button = $"MarginContainer/VBoxContainer/HBoxContainer/Panel Buy/Button Buy"
@onready var button_upgrade: Button = $"MarginContainer/VBoxContainer/HBoxContainer/Panel Upgrade/Button Upgrade"

const disabled_color = 50

func _ready() -> void:
	visible = false

func set_enable(value : bool) -> void:
	visible = value
	if value == false :
		end_player_turn()
		%"Menu Player".set_turn(true)
		return
	var player = GameMaster.get_pawn(GameMaster.current_turn)
	var tile = GameMaster.get_tile(player.tile_index)
	if tile is TilePurchaseable and tile.master != player:
		button_buy.disabled = false
		button_upgrade.disabled = true
	else:
		button_buy.disabled = true
		button_upgrade.disabled = false

func end_player_turn() -> void:
	var player = GameMaster.get_pawn(GameMaster.current_turn)
	print("before: ", GameMaster.current_turn)
	#player.turn_complete.emit(GameMaster.current_turn)
	GameMaster.end_current_turn(GameMaster.current_turn)
	print("after: ", GameMaster.current_turn)

func _on_button_buy_pressed() -> void:
	var player = GameMaster.get_pawn(GameMaster.current_turn)
	var buy_tile = GameMaster.get_tile(player.tile_index) as TilePurchaseable
	if buy_tile:
		buy_tile.set_master(player)
		buy_tile.build_asset(0)
		buy_tile.build_asset(1)
		buy_tile.build_asset(2)
	set_enable(false)

func _on_button_upgrade_pressed() -> void:
	print("Tambah")

func _on_button_end_turn_pressed() -> void:
	set_enable(false)
