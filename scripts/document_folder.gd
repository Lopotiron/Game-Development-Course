extends CharacterBody3D

var damage = 10
var speed = 30;
var destination_position = Vector3(0, 0, 0);

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await get_tree().create_timer(5.0).timeout
	queue_free()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position = position.move_toward(destination_position, delta * speed)
	
func setDestinationPosition(position):
	destination_position = position


func _on_hit_player_area_body_entered(body: Node3D) -> void:
	if (body.is_in_group("player")):
		get_tree().call_group("player", "hurt", damage)
		queue_free()
