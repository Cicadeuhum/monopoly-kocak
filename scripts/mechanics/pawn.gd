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
	change_color()
	print(turn_complete.get_connections())

func _input(event: InputEvent) -> void:
	if is_turn && Input.is_action_just_pressed("ui_accept"):
		if tile_index >= 35:
			tile_index = -1
		
		move_to_tile(tile_index + 1)

func change_color() -> void:
	var sm = StandardMaterial3D.new()
	sm.albedo_color = color
	var new_mesh = mesh_child.mesh.duplicate()
	new_mesh.surface_set_material(0, sm)
	mesh_child.mesh = new_mesh

func move_to_tile(value : int) -> void:
	if not is_turn and not can_move:
		return
	
	can_move = false
	var new_pos = GameMaster.get_tile(value).global_position + Vector3(0, 0.5, 0)
	
	var tween = get_tree().create_tween()
	tween.set_ease(Tween.EASE_OUT)
	tween.set_trans(Tween.TRANS_ELASTIC)
	tween.tween_property(self, "global_position", new_pos, MOVE_TIME)
	await tween.finished
	
	tile_index = value
	can_move = true
	
func move_steps(value : int) -> void:
	var target = tile_index + value
	if target >= GameMaster.tiles.size():
		target = target % GameMaster.tiles.size()
	await move_to_tile(target)
	#GameMaster.get_tile(tile_index).set_master(self)
	
	var tile = GameMaster.get_tile(tile_index)
	if tile is TilePurchaseable:
		%"Menu Player".set_turn(false)
		%"Menu Tile".set_enable(true)
	elif tile is TileSpecial:
		tile.do(self)

	#turn_complete.emit(index)

func start_turn() -> void:
	is_turn = true
	can_move = true

func end_turn() -> void:
	is_turn = false
