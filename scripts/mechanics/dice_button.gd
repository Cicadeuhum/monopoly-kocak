extends Button

var pawn

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pawn = get_node("/root/Node3D/Pawn")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_pressed():
	var res = roll_dice()
	#print("Kocokan Dadu: ", res)
	pawn.move_steps(res)
	
func roll_dice() -> int:
	var rand_num = RandomNumberGenerator.new()
	rand_num.randomize()
	return rand_num.randi_range(1, 6)
