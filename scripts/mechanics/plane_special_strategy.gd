extends SpecialStrategyBase
class_name PlaneSpecialStrategy

var picked_tile : Tile

func _ready() -> void:
	set_process_input(false)

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		var camera = get_viewport().get_camera_3d()
		if not camera:
			return
		
		var mouse_pos = event.position
		
		var ray_origin = camera.project_ray_origin(mouse_pos)
		var ray_direction = camera.project_ray_normal(mouse_pos)
		
		var ray_length = 1000.0
		var ray_end = ray_origin + ray_direction * ray_length
		
		var space_state = get_world_3d().direct_space_state
		var query = PhysicsRayQueryParameters3D.create(ray_origin, ray_end)
		var result = space_state.intersect_ray(query)
		
		if result:
			var clicked_object = result["collider"]
			print("Clicked object: ", clicked_object)
			
			var collision_point = result["position"]
			print("Collision point: ", collision_point)
		else:
			print("No object hit.")
	GameMaster.end_current_turn(GameMaster.current_turn)
	set_process_input(false)

func do(pawn : Pawn):
	set_process_input(true)
