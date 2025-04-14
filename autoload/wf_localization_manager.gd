# Copyright (c) 2025 Abraham Cuenca, Pixel Pilgrim Studios
# SPDX-License-Identifier: MIT

extends Node

func load_translation(path: String) -> void:
    TranslationServer.clear()
    var file_name: String = path.get_file()
    path = "res://translations/%s" % file_name
    var locale: Resource = ResourceLoader.load(path)
    if locale and locale is Translation:
        TranslationServer.set_locale(locale.locale)
        TranslationServer.add_translation(locale)
        SettingsManager.locale = locale.locale
        SettingsManager.save()
    else:
        push_error("[LocalizationManager] Failed to load: " + path)


func load_saved_translation() -> void:
    var fallback_locale = "en"
    var locale = SettingsManager.locale if SettingsManager.locale != "" else fallback_locale
    var path = "res://translations/%s.tres" % locale
    if path.ends_with(".translation"):
        path = "res://translations/%s.tres" % fallback_locale
        SettingsManager.locale = fallback_locale
        SettingsManager.save()
    load_translation(path)
