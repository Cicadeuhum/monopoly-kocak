extends Node3D
class_name Tile

@export var index : int
@export var master : Pawn
@export var asset : Asset

@export var mesh : MeshInstance3D

func set_master(value : Pawn) -> void:
	master = value
	var sm = StandardMaterial3D.new()
	sm.albedo_color = value.color
	var new_mesh = mesh.mesh.duplicate()
	new_mesh.surface_set_material(0, sm)
	mesh.mesh = new_mesh
