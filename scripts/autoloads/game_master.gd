extends Node

#var tiles : Dictionary
#var pawns : Dictionary
@onready var prison_list : Array[int] 

@onready var current_turn := 0
@onready var pawns := get_tree().get_nodes_in_group("Pawn")
@onready var tiles := get_tree().get_nodes_in_group("Tile")

func _ready() -> void:
	init_prison_list()

func _on_ready() -> void:
	get_pawn(current_turn).start_turn()
	
	for pawn in pawns:
		pawn.turn_complete.connect(end_current_turn)
	
	#init_tiles()
	#init_pawns()

#func init_tiles() -> void:
	#var a = get_tree().get_nodes_in_group("Tile")
	#var i = 0
	#for tile in a:
		#if tile is Tile:
			#tiles[i] = tile
			#i = i + 1
#
#func init_pawns() -> void:
	#print('cehck ini masuk')
	#var a = get_tree().get_nodes_in_group("Pawn")
	#var i := 0
	#for pawn in a:
		#if pawn is Pawn:
			#pawn.turn_complete.connect(end_current_turn)
			#pawn.index = i
			#pawns[i] = pawn
			#i = i + 1
	#current_turn = 0
	#get_pawn(0).start_turn()

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
		next_turn = 0
	
	var turn = get_pawn(next_turn) as Pawn
	turn.start_turn()
	
	current_turn = next_turn

func end_current_turn(value : int) -> void:
	var current = get_pawn(value) as Pawn
	current.end_turn()
	current_turn = value + 1
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
