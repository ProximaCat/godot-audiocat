extends Node2D

# 			------ AUDIO -------
# 	Game with sound! This class is responsible to work on playing
# 	common audio, like games and such. 

# PLEASE rename this two default folders!
var ost_folder = "res://audio/ost/"
var sfx_folder = "res://audio/sfx/"

# multiple audio stream library;
# 1) effects plays once and is removed from memory
#2) ost has separated index
var audio_library = {} 

# only one loopable ost at the time!
var ost_player = null 

# Tween for effects
var tween = null

# for the multiple audio stream control
var audio_number = 0


# User cases:
# - "boss4", plays from default folder (loads "boss4.ogg"
# - "res://files/audio....", for the absolute path
# - "explosion1.ogg", plays from the default folder.
func get_full_filename(filename, default_folder):
	# if not a direct res:// file is found, a string can be made using the default folder
	if filename.find("res:/") < 0:
		filename = default_folder + filename 
	# ... only OGG sounds can be played:
	if filename.find(".ogg") < 0:
		filename = filename + ".ogg"
	
	return filename


# All you need to do is to call this function for background music!
func play_ost(filename):
	
	var soundname = self.get_full_filename(filename, ost_folder)
	if not ResourceLoader.exists(soundname): return
	
	# volume back to normal, load file, set as loop... and play
	ost_player.volume_db = 0
	ost_player.stream = load(soundname)
	ost_player.stream.loop = true
	ost_player.play()
	

# Now the "play once" audio effect
func play_sfx(filename):
	
	var soundname = self.get_full_filename(filename, sfx_folder)
	if not ResourceLoader.exists(soundname): return
	
	# set a new audio channel and add to the child
	var audio_player = AudioStreamPlayer.new()
	self.add_child(audio_player)
	
	# setup this new audio channel
	audio_player.volume_db = 0
	audio_player.stream = load(soundname)
	audio_player.stream.loop = false
	audio_player.play()
	
	# add that channel into the library
	audio_library["audio" + str(audio_number)] = audio_player
	
	# event for when stopping to play the sound
	audio_player.connect("finished", self, "remove_audio_after_played", [{"object": audio_player, "index": "audio" + str(audio_number)}] )
	
	# control the position and the number of active audios
	audio_number = audio_number + 1
	if audio_number > 999: audio_number = 0 # so it won't go above 2^64, y'know, people are crazy


# after the audio effect is complete, the audio channel is removed, deleted from array and cleaned from RAM
func remove_audio_after_played(options):
	self.remove_child(options['object'])
	audio_library.erase(options['index'])


func volume(sound = 100):
	if ost_player == null: return
	ost_player.volume_db = sound - 100
	



# --- FADE OUT TO PLAY THE NEXT ost ---

func fade_play_ost(name, speed = 3.0):
	
	var soundname = self.get_full_filename(name, ost_folder)
	if not ResourceLoader.exists(soundname): return
	
	#var filename = effects_folder + name + ".ogg"
	#if not Utils.file_exist(filename): return
	
	if ost_player == null: # no sound being played right now? play it!
		play_ost(soundname)
		return
	
	# Tween fade-out for music switch
	tween.interpolate_property(ost_player, "volume_db", 0, -80, speed, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT) #volume down
	tween.interpolate_callback(self, speed + 0.2, "play_ost", soundname) #execute after volume down
	tween.start()

# -------------- END FADE OUT --------------

# basically fade out the actual sound
func fade_out(speed = 2.0):
	if ost_player == null: return
	tween.interpolate_property(ost_player, "volume_db", 0, -80, speed, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT) #volume down
	tween.start()

#fade in the actual sound
func fade_in(speed = 2.0):
	if ost_player == null: return
	tween.interpolate_property(ost_player, "volume_db", -80, 0, speed, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT) #volume down
	tween.start()

# pause the ost player
func pause():
	if ost_player == null: return
	if ost_player.playing: ost_player.stop()

#un-pause the ost player
func resume():
	if ost_player == null: return
	if ost_player.playing: ost_player.play()


# ------------ READY? ----------------

func _ready():
	
	self.ost_player = AudioStreamPlayer.new()
	self.add_child(ost_player)

	tween = Tween.new()
	self.add_child(tween)
