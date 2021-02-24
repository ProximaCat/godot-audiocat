# Godot AudioCat
A global multi-stream audio player for your project!
* It plays sound effects in parallel and cleans 'em automatically after playing
* You can set a loopable background OST... and fade to another OST for some extra drama!
* You can pause, fade in/out your OST or simply change the volume as you wish!

## How to install?
Basically set the script "Audio.gd" as an Autoload with name "Audio" in "Project -> Project Settings".

![ProjectSettings](https://i.imgur.com/RzsCMKT.png)

![Autoloading](https://i.imgur.com/Wi0aFjY.png)

Now you have audio in your entire game, even between scenes!

## How to use:
* **Audio.play_ost(filename)** - it can be "res://sound/.../file.ogg", or "file.ogg" (you can change the default "/audio/ost/" folder), or even "file" (the code will add ".ogg" at the end). This music will play in loop.
* **Audio.play_sfx(name)** - basically the above, but will play once and be discarged.
* **Audio.fade_play_ost(filename, speed = 3.0)** - do you remember when the sound goes down just before the Boss theme? That's the BLAM! you expect. It fades out the actual OST before playing the next, for an extra wow!
* **Audio.pause()**, **Audio.resume()** - pauses and unpauses the OST
* **Audio.fade_in(speed = 2.0)**, **Audio.fade_out(speed = 2.0)** - basically fades the actual OST
* **Audio.volume(sound = 100)** - 100 is normal; 0 is mute; 200 is.... please don't.

## F.A.Q
- **Which audio formats are supported?**

This code only plays OGG files. If you have MP3/WAV, consider to convert to OGG. It's better and also has good compression and native support.

- **Which folder should I add my music**?

Everywhere; although, the default directory folder is "res://audio/ost/" and "res://audio/sfx/". You can change it on Audio.gd, or by code "Audio.ost_folder" and "Audio."

- **Can I play two OSTs at the same time?**

Well, that ain't the idea, y'know. You can switch between two OSTs using the "play_soundtrack()" method; the switch will be almost instantly.

- **How many effects can I play at the same time?**

As many as your heart desire. The audio array has a loopable index of 999 items of play-once-and-discarg sounds, so.... go crazy.

- **Can I set the audio source in an object/node?**

Not yet. It's planned for a future release.

- **Do you have a simple demo for tests?**

Yes! Look at the "Releases" page.

## Credits
Code is by me, ProximaCat.
Personal Website - https://proximacat.com/
Twitter: https://twitter.com/proximacat

Godot Engine: https://godotengine.org/
