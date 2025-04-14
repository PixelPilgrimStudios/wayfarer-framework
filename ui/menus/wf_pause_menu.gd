# Copyright (c) 2025 Abraham Cuenca, Pixel Pilgrim Studios
# See LICENSE file for full details

extends CanvasLayer

@onready var title_label = $Panel/VBoxContainer/TitleLabel
@onready var resume_button = $Panel/VBoxContainer/ResumeButton
@onready var options_button = $Panel/VBoxContainer/OptionsButton
@onready var quit_button = $Panel/VBoxContainer/QuitButton
@onready var options_popup = $OptionsMenu


func _ready() -> void:
    visible = false
    options_popup.visible = false
    process_mode = Node.PROCESS_MODE_ALWAYS
    resume_button.pressed.connect(_on_resume_pressed)
    options_button.pressed.connect(_on_options_pressed)
    quit_button.pressed.connect(_on_quit_pressed)
    _refresh_translations()


func _refresh_translations() -> void:
    title_label.text = tr("paused")
    resume_button.text = tr("resume")
    options_button.text = tr("options")
    quit_button.text = tr("quit_to_menu")


func _input(event) -> void:
    if event.is_action_pressed("ui_cancel"):
        _toggle()


func _toggle() -> void:
    if not visible:
        get_tree().paused = true
        visible = true
    else:
        get_tree().paused = false
        visible = false


func _on_resume_pressed() -> void:
    _toggle()


func _on_options_pressed() -> void:
    options_popup.visible = true


func _on_quit_pressed():
    get_tree().paused = false
    SceneLoader.change_scene("res://ui/menus/wf_main_menu.tscn")
