extends Tile
class_name TilePurchaseable

@export_category("Asset")
@export var asset : Array[Asset]

var built_asset : Array[bool] = [false,false,false,false]
var build_pos : Array[Vector3] = [
									Vector3(0.3, 0.6, 0.7),
									Vector3(0.0, 0.6, 0.7),
									Vector3(-0.3, 0.6, 0.7),
									Vector3(0.0, 0.6, 0.7)
									]

@export_category("Properties")
@export var mesh : MeshInstance3D
var master : Pawn

# Func buat set kepemilikan tile
func set_master(value: Pawn) -> void:
	master = value
	set_color(value.color)
	
	var childs = self.get_children(true)
	for child in childs:
		if child is MeshInstance3D:
			set_color(value.color, child)

# Func buat ganti warna objek" yang ada di tile dan inherit MeshInstance3D
func set_color(target_color : Color, target_mesh : MeshInstance3D = mesh) -> void:
	var sm = StandardMaterial3D.new()
	sm.albedo_color = target_color
	var new_mesh = target_mesh.mesh.duplicate()
	var old_material = target_mesh.mesh.surface_get_material(0)
	var new_material
	if old_material:
		new_material = old_material.duplicate(true)
		
	else:
		new_material = StandardMaterial3D.new()
	new_material.albedo_color = target_color
	new_mesh.surface_set_material(0, new_material)
	target_mesh.mesh = new_mesh

# Func buat bangun bangunan
func build_asset(asset_index : int) -> void:
	if asset_index == 3 and can_make_landmark() == false:
		return
	
	built_asset[asset_index] = true
	var new_build = MeshInstance3D.new()
	self.add_child(new_build)
	new_build.mesh = asset[asset_index].mesh
	new_build.position = build_pos[asset_index]
	
	if master != null:
		set_color(master.color, new_build)

# Func kasih status bisa bikin landmark ato ga
func can_make_landmark() -> bool:
	for i in range(3):
		if built_asset[i] == false:
			return false
	return true

# Func cek landmark udah kebuat ato blom
func is_landmark_built() -> bool:
	return built_asset[3]
