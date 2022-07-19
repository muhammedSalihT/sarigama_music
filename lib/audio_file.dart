import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class AudioFile extends StatefulWidget {
  final AudioPlayer advancedPlayer;
  const AudioFile({Key? key, required this.advancedPlayer}) : super(key: key);

  @override
  State<AudioFile> createState() => _AudioFileState();
}

class _AudioFileState extends State<AudioFile> {
  Duration _duration = Duration();
  Duration _position = Duration();
  //final String Path = _audioPlayer.setAudioSource(AudioSource.uri(Uri.parse(uri!)));
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
