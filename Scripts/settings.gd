extends VBoxContainer

signal exit_settings

func _ready():
	GlobalControl.change_volume(0, $MasterSoundSlider.value)
	GlobalControl.change_volume(1, $MusicSoundSlider.value)
	GlobalControl.change_volume(2, $SFXSoundSlider.value)
	
func _process(_delta):
	pass

func _on_master_sound_slider_value_changed(value):
	GlobalControl.change_volume(0, value)

func _on_music_sound_slider_value_changed(value):
	GlobalControl.change_volume(1, value)

func _on_sfx_sound_slider_value_changed(value):
	GlobalControl.change_volume(2, value)

func _on_main_menu_btn_pressed():
	exit_settings.emit()

func _on_resolution_dropdown_item_selected(index):
	if index == 0:
		DisplayServer.window_set_size(Vector2(1920, 1080))
	if index == 1:
		DisplayServer.window_set_size(Vector2(1024, 768))
	if index == 2:
		DisplayServer.window_set_size(Vector2(800, 600))
