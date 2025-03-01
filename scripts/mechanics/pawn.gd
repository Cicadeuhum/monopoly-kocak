extends Node3D
class_name Pawn

@export var color : Color
@export var index := 0

@onready var mesh_child: MeshInstance3D = $Mesh

var is_turn := false
var money : float = 0
var assets : Array[Asset]

var tile_index := -1
var can_move := false
var jailed_turn := 0

const MOVE_TIME := 1

signal turn_complete(index)

func _ready() -> void:
	#move_to_tile(0)
	pass

func _input(event: InputEvent) -> void:
	if is_turn && Input.is_action_just_pressed("ui_accept"):
		if tile_index >= 35:
			tile_index = -1
		
		move_to_tile(tile_index + 1)

func init() -> void:
	var new_material = StandardMaterial3D.new()
	new_material.albedo_color = color
	mesh_child.material_override = new_material
	#set_surface_override_material(0, new_material)

func get_tile(value : int) -> Tile:
	for tile in get_tree().get_nodes_in_group("Tile"):
		if tile is Tile:
			if tile.index == value:
				return tile
	return null

func move_to_tile(value : int) -> void:
	print("THIS PAWN INDEX = " + str(index))
	if not is_turn and not can_move:
		return
	
	can_move = false
	var new_pos = get_tile(value).global_position + Vector3(0, 0.5, 0)
	
	var tween = get_tree().create_tween()
	tween.set_ease(Tween.EASE_OUT)
	tween.set_trans(Tween.TRANS_ELASTIC)
	tween.tween_property(self, "global_position", new_pos, MOVE_TIME)
	await tween.finished
	
	tile_index = value
	can_move = true
	turn_complete.emit(index)

func start_turn() -> void:
	is_turn = true
	can_move = true
	print("Saya pawn " + str(index) + " start")

func end_turn() -> void:
	is_turn = false
	print("Saya pawn " + str(index) + " end")
