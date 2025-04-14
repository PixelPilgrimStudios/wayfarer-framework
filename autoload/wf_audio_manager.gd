# Copyright (c) 2025 Abraham Cuenca, Pixel Pilgrim Studios
# SPDX-License-Identifier: MIT

extends Node

const MUSIC_BUS: String = "Music"
const SFX_BUS: String = "SFX"

@onready var music_player: AudioStreamPlayer = AudioStreamPlayer.new()
@onready var sfx_player: AudioStreamPlayer = AudioStreamPlayer.new()


func _ready() -> void:
    add_child(music_player)
    add_child(sfx_player)
    music_player.bus = MUSIC_BUS
    sfx_player.bus = SFX_BUS
    update_volume()


func update_volume() -> void:
    var db: float = linear_to_db(SettingsManager.volume)
    AudioServer.set_bus_volume_db(AudioServer.get_bus_index(MUSIC_BUS), db)
    AudioServer.set_bus_volume_db(AudioServer.get_bus_index(SFX_BUS), db)


func play_music(stream: AudioStream) -> void:
    if music_player.playing:
        music_player.stop()
    music_player.stream = stream
    music_player.volume_db = 0
    music_player.play()


func stop_music() ->void:
    if music_player.playing:
        music_player.stop()


func play_sfx(stream: AudioStream) -> void :
    sfx_player.stream = stream
    sfx_player.volume_db = 0
    sfx_player.play()


func _fade_out_music(_fade_time: float) -> void:
    var timer = Timer.new()
    timer.wait_time = 0.05
    timer.one_shot = false
    add_child(timer)
    timer.start()
    while music_player.volume_db > -80:
        music_player.volume_db -= 5
        await timer.timeout
    timer.stop()
    timer.queue_free()


func _fade_in_music(_fade_time: float) -> void:
    var timer: Timer = Timer.new()
    timer.wait_time = 0.05
    timer.one_shot = false
    add_child(timer)
    timer.start()
    while music_player.volume_db < 0:
        music_player.volume_db += 5
        await timer.timeout
    music_player.volume_db = 0
    timer.stop()
    timer.queue_free()
