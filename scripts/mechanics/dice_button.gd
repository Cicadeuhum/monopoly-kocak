extends Button

var pawn

func _on_pressed():
	var res = roll_dice()
	#print("Kocokan Dadu: ", res)
	GameMaster.get_pawn(GameMaster.current_turn).move_steps(res)
	
func roll_dice() -> int:
	var rand_num = RandomNumberGenerator.new()
	rand_num.randomize()
	return rand_num.randi_range(1, 6)
