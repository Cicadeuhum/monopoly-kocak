extends Camera3D

func get_active_camera() -> Camera3D:
	return get_viewport().get_camera_3d()

func get_object_from_view(point_position: Vector2) -> CollisionObject3D:
	var world_space = get_world_3d().direct_space_state
	var camera = get_active_camera()
	var start = camera.project_ray_origin(point_position)
	var ray_direction = camera.project_ray_normal(point_position)
	var end = start + ray_direction * 5000
	var query = PhysicsRayQueryParameters3D.create(start, end)
	var result = world_space.intersect_ray(query)
	if result.size() > 0:
		return result["collider"]
	else:
		return null
