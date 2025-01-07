extends AnimatableBody3D

var tile_index := 0
var can_move := true

const move_time := 1

func _ready() -> void:
	move_to_tile(0)

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		if tile_index >= 35:
			tile_index = -1
		
		move_to_tile(tile_index + 1)

func get_tile(index : int) -> Tile:
	for tile in get_tree().get_nodes_in_group("Tile"):
		if tile is Tile:
			if tile.index == index:
				return tile
	return null

func move_to_tile(index : int) -> void:
	if not can_move:
		return
	
	can_move = false
	var new_pos = get_tile(index).global_position + Vector3(0, 0.5, 0)
	
	var tween = get_tree().create_tween()
	tween.set_ease(Tween.EASE_OUT)
	tween.set_trans(Tween.TRANS_ELASTIC)
	tween.tween_property(self, "global_position", new_pos, move_time)
	await tween.finished
	
	tile_index = index
	can_move = true
