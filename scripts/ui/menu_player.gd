extends Panel

#@onready var button_ngocok: Button = $"CenterContainer/VBoxContainer/Button Ngocok"

func _ready() -> void:
	visible = true

func set_turn(value: bool) -> void:
	visible = value

func roll_dice() -> int:
	var rand_num = RandomNumberGenerator.new()
	rand_num.randomize()
	return rand_num.randi_range(1, 6)

func _on_button_ngocok_pressed() -> void:
	#print('test')
	var curr_player = GameMaster.get_pawn(GameMaster.current_turn)
	print(GameMaster.current_turn)
	if curr_player.is_turn and not curr_player.can_move: return
	
	var res = roll_dice()
	#print("Kocokan Dadu: ", res)
	curr_player.move_steps(res)

func _on_button_surrender_pressed() -> void:
	GameMaster.delete_pawn(GameMaster.current_turn)
