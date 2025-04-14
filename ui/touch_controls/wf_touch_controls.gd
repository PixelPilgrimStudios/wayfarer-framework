# Copyright (c) 2025 Abraham Cuenca, Pixel Pilgrim Studios
# SPDX-License-Identifier: MIT

extends CanvasLayer

func _ready() -> void:
    refresh()
    $LeftStick/LeftButton.pressed.connect(func():
        Input.action_press("ui_left")
    )
    $LeftStick/LeftButton.released.connect(func():
        Input.action_release("ui_left")
    )
    $LeftStick/RightButton.pressed.connect(func():
        Input.action_press("ui_right")
    )
    $LeftStick/RightButton.released.connect(func():
        Input.action_release("ui_right")
    )
    $AButton/TouchScreenButton.pressed.connect(func():
        Input.action_press("ui_accept")
    )
    $AButton/TouchScreenButton.released.connect(func():
        Input.action_release("ui_accept")
    )

func refresh() -> void:
    var forced: bool = SettingsManager.touch_controls_enabled
    var in_editor: bool = Engine.is_editor_hint()
    var debug_build: bool = OS.has_feature("debug")
    var on_real_device: bool = OS.has_feature("mobile")
    var should_show: bool = forced or on_real_device
    visible = should_show
    set_process(should_show)
    set_process_input(should_show)
    for child in get_children():
        _disable_node_recursively(child, not should_show)
    print("..:: [TouchControls] refresh → show:", should_show,
        "| forced:", forced,
        "| on_real_device:", on_real_device,
        "| debug:", debug_build,
        "| in_editor:", in_editor, " ::..")


func _disable_node_recursively(node: Node, disable: bool) -> void:
    if node is CanvasItem:
        node.visible = not disable
    if node is TouchScreenButton:
        node.visible = not disable
        if disable:
            node.action = ""
        else:
            if node.name == "TouchScreenButton":
                var parent = node.get_parent()
                match parent.name:
                    "LeftButton": node.action = "ui_left"
                    "RightButton": node.action = "ui_right"
                    "UpButton": node.action = "ui_up"
                    "DownButton": node.action = "ui_down"
                    "AButton": node.action = "ui_accept"
                    "BButton": node.action = "ui_cancel"
    for child in node.get_children():
        _disable_node_recursively(child, disable)
