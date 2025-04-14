# Copyright (c) 2025 Abraham Cuenca, Pixel Pilgrim Studios
# SPDX-License-Identifier: MIT

extends Control

var click_sound: AudioStreamOggVorbis = preload("res://assets/sounds/select.ogg")
var hover_sound: AudioStreamOggVorbis = preload("res://assets/sounds/hover.ogg")
@onready var start_button: Node = $VBoxContainer/StartButton
@onready var options_button: Node = $VBoxContainer/OptionsButton
@onready var credits_button: Node = $VBoxContainer/CreditsButton
@onready var quit_button: Node = $VBoxContainer/QuitButton


func _ready() -> void:
    start_button.text = tr("start_game")
    options_button.text = tr("options")
    credits_button.text = tr("credits")
    quit_button.text = tr("quit")
    start_button.pressed.connect(_on_start_pressed)
    options_button.pressed.connect(_on_options_pressed)
    credits_button.pressed.connect(_on_credits_pressed)
    quit_button.pressed.connect(_on_quit_pressed)
    var bg_music: AudioStreamWAV = preload("res://assets/music/bg_music.wav")
    AudioManager.play_music(bg_music)
    if OS.has_feature("mobile"):
        quit_button.hide()
    await get_tree().process_frame
    refresh_translations()


func _on_start_pressed() -> void:
    AudioManager.play_sfx(click_sound)
    SceneLoader.change_scene("res://scenes/level_1.tscn")


func _on_options_pressed() -> void:
    AudioManager.play_sfx(click_sound)
    SceneLoader.change_scene("res://ui/menus/wf_options_menu.tscn")


func _on_credits_pressed() -> void:
    AudioManager.play_sfx(click_sound)
    SceneLoader.change_scene("res://ui/menus/wf_credits_menu.tscn")


func _on_quit_pressed() -> void:
    AudioManager.play_sfx(click_sound)
    get_tree().quit()


func _on_start_button_mouse_entered() -> void:
    AudioManager.play_sfx(hover_sound)


func _on_options_button_mouse_entered() -> void:
    AudioManager.play_sfx(hover_sound)


func _on_credits_button_mouse_entered() -> void:
    AudioManager.play_sfx(hover_sound)


func _on_quit_button_mouse_entered() -> void:
    AudioManager.play_sfx(hover_sound)


func refresh_translations() -> void:
    start_button.text = tr("start_game")
    options_button.text = tr("options")
    credits_button.text = tr("credits")
    quit_button.text = tr("quit")
