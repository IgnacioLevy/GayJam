extends Node

@export var mongolin_scene: PackedScene = preload("res://mongolin.tscn")

func _on_mongolin_timer_timeout():
# Create a new instance of the Mob scene.
	var mongolin = mongolin_scene.instantiate()

	# Choose a random location on the SpawnPath.
	# We store the reference to the SpawnLocation node.
	var mongolin_spawn_location = get_node("SpawnPath/SpawnLocation")
	# And give it a random offset.
	mongolin_spawn_location.progress_ratio = randf()

	var player_position =  $Mongo.position
	mongolin.initialize(mongolin_spawn_location.position, player_position)

	# Spawn the mob by adding it to the Main scene.
	add_child(mongolin)

