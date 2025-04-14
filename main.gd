# Copyright (c) 2025 Abraham Cuenca, Pixel Pilgrim Studios
# SPDX-License-Identifier: MIT


extends Control


func _ready() -> void:
    var args: PackedStringArray = OS.get_cmdline_args()
    if "--dev" in args:
        print("..:: Running in dev mode ::..")
    SettingsManager.load_settings()
    LocalizationManager.load_saved_translation()
    if "--skip-splash" in args:
        print("..:: Skipping Splash Screen... Jumping to main menu ::..")
        SceneLoader.change_scene("res://ui/menus/wf_main_menu.tscn")
    else:
        SceneLoader.change_scene("res://ui/splash_screens/wf_splash_screen.tscn")
