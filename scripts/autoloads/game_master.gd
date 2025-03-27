extends Node

@onready var prison_list : Array[int] 

@onready var current_turn := 0
@onready var pawns := get_tree().get_nodes_in_group("Pawn")
@onready var tiles := get_tree().get_nodes_in_group("Tile")

func _ready() -> void:
	init_prison_list()
	
	for pawn in pawns:
		pawn.turn_complete.connect(end_current_turn)
	
	get_pawn(current_turn).start_turn()

func get_next_turn(value : int) -> int:
	return 0 if value >= pawns.size() else value

func init_prison_list() -> void:
	for i in range(pawns.size()):
		prison_list.append(0)

func get_pawn(value : int) -> Pawn:
	return pawns.get(value)

func get_tile(value : int) -> Tile:
	return tiles.get(value)

func delete_pawn(value : int) -> void:
	if pawns.size() < 3: return
	pawns.remove_at(value)
	
	var next_turn = (0 if pawns.size() == value else value)
	
	var turn = get_pawn(next_turn) as Pawn
	turn.start_turn()
	
	current_turn = next_turn

func end_current_turn() -> void:
	var current = get_pawn(current_turn) as Pawn
	current.end_turn()
	current_turn = current_turn + 1
	if current_turn >= pawns.size():
		current_turn = 0
	cycle_next_turn()

func cycle_next_turn():
	if prison_list[current_turn] > 0:
		prison_list[current_turn] = prison_list[current_turn] - 1
		print("Blud ini masih dipenjara: sisa ", prison_list[current_turn] + 1)
		if current_turn >= pawns.size() - 1:
			current_turn = 0
		else:
			current_turn = current_turn + 1
		cycle_next_turn()
	
	get_pawn(current_turn).start_turn()

func prison_pawn(pawn_index : int, prison_time : int = 3) -> void:
	prison_list[pawn_index] = prison_time
