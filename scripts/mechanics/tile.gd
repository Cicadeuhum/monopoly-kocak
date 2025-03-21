extends Node3D
class_name Tile

@export var index : int
@export var asset : Asset

var mesh : MeshInstance3D
var master : Pawn

func set_master(value: Pawn) -> void:
	master = value
	var sm = StandardMaterial3D.new()
	sm.albedo_color = value.color

	var new_mesh = mesh.mesh.duplicate()
	
	var old_material = mesh.mesh.surface_get_material(0)
	if old_material:
		var new_material = old_material.duplicate(true)
		new_material.albedo_color = value.color
		new_mesh.surface_set_material(0, new_material)

	mesh.mesh = new_mesh
