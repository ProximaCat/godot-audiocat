extends Node2D

var audio = "trek"
onready var volume_slider = get_node("Interactive/HSlider")

# first music to listen
func _ready():
	# short term for "res://audio_cat/audio/ost/POL-galactic-trek-short.ogg
	# you can change the defaukt OST folder by changing "Audio.ost_folder"
	Audio.play_ost("galaxy")
	volume_slider.value = 100

# ---------- button/volume effects for OST ----------
func _on_Button_pressed():
	self.audio = "trek"
	Audio.play_ost("galaxy")
	volume_slider.value = 100


func _on_Button2_pressed():
	self.audio = "ninja"
	Audio.play_ost("ninjapanda")
	volume_slider.value = 100
	pass # Replace with function body.


func _on_Button3_pressed():
	volume_slider.value = 100
	if self.audio == "ninja":
		self.audio = "trek"
		Audio.fade_play_ost("galaxy", 1.0)
	else:
		self.audio = "ninja"
		Audio.fade_play_ost("ninjapanda", 1.0)
		
func _on_HSlider_value_changed(value):
	Audio.volume(value)
	pass # Replace with function body.


# ------ Now the SFX -----

func _on_Button4_pressed():
	Audio.play_sfx("jump")
	pass # Replace with function body.


func _on_Button5_pressed():
	Audio.play_sfx("pickup")
	pass # Replace with function body.


func _on_Button6_pressed():
	Audio.play_sfx("powerup")
	pass # Replace with function body.


func _on_Button7_pressed():
	Audio.play_sfx("space")
	pass # Replace with function body.


func _on_Button8_pressed():
	Audio.play_sfx("roar")
	pass # Replace with function body.
