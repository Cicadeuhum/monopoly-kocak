extends AnimatableBody3D

func _ready() -> void:
	global_position = get_tile(0).global_position + Vector3(0, 0.5, 0)

func get_tile(index : int) -> Tile:
	for tile in get_tree().get_nodes_in_group("Tile"):
		if tile is Tile:
			return tile
	return null
