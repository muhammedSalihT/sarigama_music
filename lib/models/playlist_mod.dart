import 'package:hive/hive.dart';
part 'playlist_mod.g.dart';

@HiveType(typeId: 1)
class PlayListModel {
  @HiveField(0)
  int? id;
  @HiveField(1)
  String name;
  @HiveField(2)
  List<dynamic> songListdb;

  PlayListModel({required this.name, this.songListdb = const [], this.id});
}

