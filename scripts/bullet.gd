extends Node3D
class_name Bullet

var damage = 10
var bullet_speed = 20
var fire_rate = 1
var can_fire: bool = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await get_tree().create_timer(5.0).timeout
	queue_free()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position += transform.basis * Vector3(0, 0, -bullet_speed) * delta

func _on_boss_hit_area_body_entered(body: Node3D) -> void:
	if (body.is_in_group("boss")):
		get_tree().call_group("boss", "hurt", damage)
		queue_free()
