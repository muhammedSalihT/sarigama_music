import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';

ConcatenatingAudioSource createSongList(List<SongModel> song) {
  List<AudioSource> source = [];
  for (var songs in song) {
    source.add(AudioSource.uri(Uri.parse(songs.uri!)));
  }
  return ConcatenatingAudioSource(children: source);
}
