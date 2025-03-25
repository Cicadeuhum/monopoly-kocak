extends Button

func _on_pressed():
	var curr_player : Pawn = GameMaster.get_pawn(GameMaster.current_turn)
	if curr_player.is_turn and not curr_player.can_move: return
	var res = roll_dice()
	#print("Kocokan Dadu: ", res)
	curr_player.move_steps(res)
	
func roll_dice() -> int:
	var rand_num = RandomNumberGenerator.new()
	rand_num.randomize()
	return rand_num.randi_range(1, 6)
