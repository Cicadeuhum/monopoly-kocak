extends Node

@onready var tiles : Dictionary
@onready var pawns : Dictionary

@onready var current_turn := 0

func _on_ready() -> void:
	init_tiles()
	init_pawns()

func init_tiles() -> void:
	var a = get_tree().get_nodes_in_group("Tile")
	var i = 0
	for tile in a:
		if tile is Tile:
			tiles[i] = tile
			i = i + 1

func init_pawns() -> void:
	print("test KONOTL MASUk")
	var a = get_tree().get_nodes_in_group("Pawn")
	var i := 0
	print('test ',a)
	for pawn in a:
		if pawn is Pawn:
			pawn.turn_complete.connect(end_current_turn)
			pawn.index = i
			pawns[i] = pawn
			i = i + 1
	current_turn = 0
	get_pawn(0).start_turn()

func get_next_turn(value : int) -> int:
	return 0 if value >= pawns.size() else value 

func get_pawn(value : int) -> Pawn:
	return pawns.get(value)

func get_tile(value : int) -> Tile:
	return tiles.get(value)

func delete_pawn(value : int) -> void:
	if pawns.size() < 3: return
	
	pawns.erase(value)
	
	var next_turn = -1
	
	#Pawn terletak di awal atau tengah(sebelum akhir)
	if value < pawns.size() - 1:
		var temp = value
		var next_pawn = temp + 1
		for next_id in range(next_pawn, pawns.size() + 1):
			pawns[temp] = pawns[next_id]
			temp+=1
			pawns.erase(next_id)
		next_turn = value
	else:
		print('ets')
		next_turn = 0
	
	var turn = get_pawn(next_turn) as Pawn
	turn.start_turn()
	
	current_turn = next_turn
	print(current_turn)

func end_current_turn(value : int) -> void:
	var current = get_pawn(value) as Pawn
	current.end_turn()
	print('masuk', value)
	current_turn = get_next_turn(value + 1)
	print(current_turn)
	var next = get_pawn(current_turn) as Pawn
	next.start_turn()
