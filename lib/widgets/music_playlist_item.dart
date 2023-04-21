import 'package:dart_mpd/dart_mpd.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:libadwaita/libadwaita.dart';

import '../controllers/mpd_controller.dart';

class MusicPlaylistItem extends StatelessWidget {
  MusicPlaylistItem(
      {Key? key, required this.song, required this.currentSongIndex})
      : super(key: key);
  final MpdSong song;
  final int currentSongIndex;

  final mpdController = Get.find<MpdController>();

  @override
  Widget build(BuildContext context) {
    String title = 'unknown';
    String artist = 'unknown';
    if (song.title is String) title = song.title as String;
    if (song.artist is String) artist = song.artist as String;
    return AdwActionRow(
      title: '$title - $artist',
      start: currentSongIndex == song.id
          ? const Icon(
              Icons.music_note_rounded,
              color: Colors.tealAccent,
            )
          : const Icon(Icons.music_note_rounded),
      end: popupMenuInMusicPlaylistItem(id: song.id),
    );
  }

  Widget popupMenuInMusicPlaylistItem({required int? id}) {
    return ToggleButtons(renderBorder: false, isSelected: const [
      false,
      false
    ], children: [
      IconButton(
          icon: const Icon(Icons.play_arrow),
          tooltip: '播放',
          onPressed: () {
            if (currentSongIndex != id) {
              mpdController.playThisSong(id!);
            }
          }),
      IconButton(
          icon: const Icon(Icons.delete),
          tooltip: '删除',
          onPressed: () {
            mpdController.deleteFromList(id!);
          })
    ]);
  }
}
