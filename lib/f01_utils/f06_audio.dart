import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/widgets.dart';
// import 'package:flame_audio/flame_audio.dart';

class MyAudio {

  static AudioCache audioCache = AudioCache(prefix: 'assets/audio/');
  bool bgmIsPlaying = false;
  AudioPlayer? audioPlayer;

  // late Settings settings;
  MyAudio._internal();

  /// [_instance] represents the single static instance of [AudioManager].
  static final MyAudio _instance = MyAudio._internal();

  /// A getter to access the single instance of [AudioManager].
  static MyAudio get instance => _instance;

  List<String> files =[
    'sfx/jump14.wav'
  ];
  static const List<String> bgmFiles =[
    'music/when_snow_become_ashes.ogg'
  ];

  Future<void> init() async {
    await audioCache.loadAll(bgmFiles);
    await audioCache.loadAll(files);
  }

  Future<void> startBgmMusic  ({ String? fileName, double volume = 1.0}) async {
    if (audioPlayer != null && audioPlayer!.state != PlayerState.STOPPED) {
      audioPlayer!.stop();
    }
    bgmIsPlaying = true;
    audioPlayer = await audioCache.loop(fileName??bgmFiles[0], volume: volume);
  }
  Future<void> stopBgmMusic() async {
    if(audioPlayer!=null){
      await audioPlayer!.stop();
    }
    bgmIsPlaying = false;
  }
  Future<void> resumeBgmMusic() async {
    if(audioPlayer!=null){
      await audioPlayer!.resume();
    }
    bgmIsPlaying = true;
  }
  Future<void> pauseBgmMusic() async {
    if(audioPlayer!=null){
      await audioPlayer!.pause();
    }
    bgmIsPlaying = false;
  }
  Future<AudioPlayer> playSfx(String fileName, {double volume = 1.0}) {
    return audioCache.play(fileName, volume: volume, mode: PlayerMode.LOW_LATENCY);
  }
}

