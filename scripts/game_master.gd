extends Node

var tiles : Dictionary
var pawns : Dictionary

var current_turn := 0

func _ready() -> void:
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
	var a = get_tree().get_nodes_in_group("Pawn")
	var i := 0
	for pawn in a:
		if pawn is Pawn:
			pawn.turn_complete.connect(end_current_turn)
			pawn.index = i
			pawns[i] = pawn
			i = i + 1
	current_turn = 0
	get_pawn(0).start_turn()

func get_pawn(value : int) -> Pawn:
	return pawns.get(value)

func get_tile(value : int) -> Tile:
	return tiles.get(value)

func end_current_turn(value : int) -> void:
	var current = get_pawn(value) as Pawn
	current.end_turn()
	current_turn = value + 1
	if current_turn >= pawns.size():
		current_turn = 0
	var next = get_pawn(current_turn) as Pawn
	next.start_turn()
