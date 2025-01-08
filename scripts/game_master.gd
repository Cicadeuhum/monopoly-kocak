extends Node

var tiles : Array[Tile]

func _ready() -> void:
	init_tiles_dict()

func init_tiles_dict() -> void:
	var a = get_tree().get_nodes_in_group("Tile")
	for tile in a:
		if tile is Tile:
			tiles.append(tile)
