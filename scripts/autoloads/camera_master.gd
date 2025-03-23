extends Camera3D

func get_object_from_view(point_position: Vector2) -> CollisionObject3D:
	var world_space = get_world_3d().direct_space_state
	var start = project_ray_origin(point_position)
	var ray_direction = project_ray_normal(point_position)
	var end = start + ray_direction * 1000
	var query = PhysicsRayQueryParameters3D.create(start, end)
	var result = world_space.intersect_ray(query)
	if result.has("collider"):
		return result["collider"]
	else:
		return null
