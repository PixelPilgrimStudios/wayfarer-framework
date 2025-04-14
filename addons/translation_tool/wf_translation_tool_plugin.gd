# Copyright (c) 2025 Abraham Cuenca, Pixel Pilgrim Studios
# SPDX-License-Identifier: MIT

@tool
extends EditorPlugin

var button: Node
var open_button: Node
var language_editor_panel: Node


func _enter_tree() -> void:
    open_button = Button.new()
    open_button.name = "OpenLanguageEditorButton"
    open_button.text = "Open Language Editor"
    open_button.pressed.connect(_on_open_pressed)
    add_control_to_container(CONTAINER_TOOLBAR, open_button)
    language_editor_panel = preload("res://addons/translation_tool/wf_language_editor.tscn").instantiate()
    language_editor_panel.visible = false
    get_editor_interface().get_editor_main_screen().add_child(language_editor_panel)


func _exit_tree() -> void:
        if open_button:
            remove_control_from_container(CONTAINER_TOOLBAR, open_button)
            open_button.queue_free()
        if button:
            remove_control_from_container(CONTAINER_TOOLBAR, button)
            button.queue_free()
        if language_editor_panel:
            language_editor_panel.queue_free()
        if language_editor_panel:
            language_editor_panel.hide()
            language_editor_panel.queue_free()
            language_editor_panel.hide()
            language_editor_panel.queue_free()


func _on_open_pressed() -> void:
    if language_editor_panel.visible:
        language_editor_panel.hide()
    else:
        language_editor_panel.popup_centered()
