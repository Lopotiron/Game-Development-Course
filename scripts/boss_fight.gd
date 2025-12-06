extends Node3D

@export var spawn_object = preload("res://scenes/document_folder.tscn");
var spawnNumber = 20;
var spawnRate = 5;
var time = 0.0;
@onready var player = $Player
@onready var spawnArea1 = $SpawnArea1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	time += delta
	if (time >= spawnRate):
		spawn()
		time = 0.0

func getRandomPosition() -> Vector3:
	var mesh_size = spawnArea1.get_aabb().size
	var global_scale2 = spawnArea1.global_transform.basis.get_scale()
	
	var half_size_x = (mesh_size.x * global_scale2.x) / 2.0
	var half_size_z = (mesh_size.z * global_scale2.z) / 2.0

	var x = randf_range(-abs(-half_size_x / 2), abs(half_size_x / 2))
	var z = randf_range(-abs(-half_size_z / 2), abs(half_size_z / 2))
	var y = spawnArea1.global_position.y + randf_range(1.0, 5.0)
	return spawnArea1.global_position + Vector3(x, y, z)

func spawn():
	var destination_position = player.global_position
	for i in range(0, spawnNumber):
		var obj = spawn_object.instantiate()
		obj.position = getRandomPosition()
		obj.setDestinationPosition(destination_position)
		add_child(obj)
