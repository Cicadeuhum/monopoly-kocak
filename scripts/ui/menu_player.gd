extends Panel

var gm

func _ready() -> void:
	gm = GameMaster
	visible = true
	update_money()

""" UPDATE INFORMASI UANG (GACOR BOS)"""
func update_money() -> void:
	print("Check Money")
	$"%Money Label".text = "Rp " + "1000"
	# $"%Money Label".anchor_left

func set_turn(value: bool) -> void:
	visible = value

func roll_dice() -> int:
	var rand_num = RandomNumberGenerator.new()
	rand_num.randomize()
	return rand_num.randi_range(1, 6)

func _on_button_ngocok_pressed() -> void:
	var currentTurn = gm.getCurrTurn()
	var curr_player = gm.get_pawn(currentTurn)

	if curr_player.is_turn and not curr_player.can_move: return
	var res = roll_dice()
	curr_player.move_steps(res)

func _on_button_surrender_pressed() -> void:
	gm.delete_pawn(gm.current_turn)
