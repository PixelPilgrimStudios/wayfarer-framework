# Copyright (c) 2025 Abraham Cuenca, Pixel Pilgrim Studios
# SPDX-License-Identifier: MIT

extends Node

@export var config_path := "user://settings.cfg"
var volume := 1.0
var locale := "en"
var touch_controls_enabled := false
var previous_scene := ""


func _ready() -> void:
    check_for_touch_flag()
    load_settings()


func save() -> void:
    var config = ConfigFile.new()
    config.set_value("audio", "volume", volume)
    config.set_value("localization", "locale", locale)
    config.set_value("input", "touch_controls_enabled", touch_controls_enabled)
    config.save(config_path)


func load_settings() -> void:
    var config: ConfigFile = ConfigFile.new()
    var err: Error = config.load(config_path)
    if err != OK:
        print("..:: [SettingsManager] No config found, using defaults ::..")
        return
    volume = config.get_value("audio", "volume", 1.0)
    locale = config.get_value("localization", "locale", "en")
    touch_controls_enabled = config.get_value("input", "touch_controls_enabled", false)
    TranslationServer.set_locale(locale)
    var path = "res://translations/%s.tres" % locale
    if ResourceLoader.exists(path):
        LocalizationManager.load_translation(path)

func check_for_touch_flag():
    var args = OS.get_cmdline_args()
    if "--touch" in args:
        print("..:: Touch mode enabled via --touch flag")
        touch_controls_enabled = true
        save()
