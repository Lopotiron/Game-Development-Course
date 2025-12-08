extends Node3D

func _ready() -> void:
	await $ProtonScatter.ready
	pass

func _process(delta: float) -> void:
	pass
