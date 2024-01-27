extends Control
func _ready():
	visible=false
	$backround.visible = false
	EventHandler.battle_started.connect(self.init)
func init(character_name):
	print("omg")
	visible=true
	$AnimationPlayer.play("fade_in")
	get_tree().paused=true
	$backround/Panel/Label.text="Un %s re molesto apareció" %[character_name]

	


func _on_animation_player_animation_finished(anim_name):
	if anim_name=="fade_in":
		$AnimationPlayer.play("fade_out")
		$backround.visible=true
		
