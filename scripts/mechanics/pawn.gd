extends Node3D
class_name Pawn

@onready var mesh_child: MeshInstance3D = $Mesh
@export var color: Color
@export var index := 0

const MOVE_TIME := 1

var is_turn: bool = false
var money: float = 0
var assets: Array[Asset]
var tile_index := -1
var can_move := false
var jailed_turn := 0

signal turn_complete(index: int)

func _ready() -> void:
	change_color()

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

func move_to_tile(value: int) -> void:
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
	
func move_steps(value: int) -> void:
	var target = tile_index + value
	if target >= GameMaster.tiles.size():
		target = target % GameMaster.tiles.size()
	await move_to_tile(target)
	var tile = GameMaster.get_tile(tile_index)
	if tile is TilePurchaseable:
		%"Menu Player".set_turn(false)
		%"Menu Tile".set_enable(true)
	elif tile is TileSpecial:
		tile.do(self)

func move_to_specified_tile(value: int) -> void:
	await move_to_tile(value)
	var tile = GameMaster.get_tile(tile_index)
	if tile is TilePurchaseable:
		%"Menu Player".set_turn(false)
		%"Menu Tile".set_enable(true)
	elif tile is TileSpecial:
		tile.do(self)

func start_turn() -> void:
	is_turn = true
	can_move = true

func end_turn() -> void:
	is_turn = false

func updateMoney(money: float) -> void:
	self.money = money

func getMoney() -> float:
	return money