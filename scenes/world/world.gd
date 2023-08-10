extends Node2D
class_name World 

@onready var tile_map: TileMap = $TileMap
@onready var tank: Tank = get_tree().get_first_node_in_group("Tank")

enum TILE_PARTICLES { NONE, WATER, DIRT, GRASS }

@export var water_color: GradientTexture1D
@export var dirt_color: GradientTexture1D
@export var grass_color: GradientTexture1D

@onready var tile_particle_ramps = {
	TILE_PARTICLES.NONE: null,
	TILE_PARTICLES.WATER: water_color,
	TILE_PARTICLES.DIRT: dirt_color,
	TILE_PARTICLES.GRASS: grass_color
}


static var _instance: World = null


func _ready():
	_instance = self if _instance == null else _instance
	

static func get_tile_data_at(position: Vector2) -> TileData:
	var local_position: Vector2i = _instance.tile_map.local_to_map(position)
	return _instance.tile_map.get_cell_tile_data(0, local_position)


static func get_custom_data_at(position: Vector2, custom_data_name: String) -> Variant:
	var data = get_tile_data_at(position)
	return data.get_custom_data(custom_data_name)


static func get_gradient_at(position: Vector2) -> GradientTexture1D:
	var tile_type = get_custom_data_at(position, "particle_type")
	return _instance.tile_particle_ramps.get(tile_type, null)


static func get_closest_crate_to(position: Vector2) -> Crate:
	var closest: Crate = null
	var closest_distance = INF
	for child in _instance.tile_map.get_children():
		if child is Crate:
			var dist = position.distance_to(child.position)
			if !closest || (dist < closest_distance):
				closest = child
				closest_distance = dist
	
	return closest
	
	
	
	
	
