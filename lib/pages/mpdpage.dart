import 'package:dart_mpd/dart_mpd.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import "package:libadwaita/libadwaita.dart";
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

import '../controllers/mpd_controller.dart';
import '../widgets/music_playlist_item.dart';

class MpdPage extends StatelessWidget {
  MpdPage({Key? key}) : super(key: key);
  final mpdController = Get.put(MpdController());

  @override
  Widget build(BuildContext context) {
    return AdwClamp.scrollable(
        child: Column(children: [
      //播放信息
      Obx(() {
        return Card(
            child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SleekCircularSlider(
                        appearance: CircularSliderAppearance(
                          angleRange: 360,
                          customColors: CustomSliderColors(
                              hideShadow: true,
                              progressBarColor: Theme.of(context).primaryColor),
                        ),
                        min: 0,
                        max: 100,
                        initialValue: ((mpdController
                                            .currentSongCurrentTime.value /
                                        mpdController
                                            .currentSongDuration.value *
                                        100) >=
                                    0 &&
                                (mpdController.currentSongCurrentTime.value /
                                        mpdController
                                            .currentSongDuration.value *
                                        100) <=
                                    100)
                            ? mpdController.currentSongCurrentTime.value /
                                mpdController.currentSongDuration.value *
                                100
                            : 0,
                        onChange: (value) => mpdController.seek((value /
                                100 *
                                mpdController.currentSongDuration.value)
                            .toString()),
                      ),
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(mpdController.currentSong.value.title is String
                                ? mpdController.currentSong.value.title
                                    as String
                                : 'Loading...'),
                            Text(
                                mpdController.currentSong.value.artist is String
                                    ? mpdController.currentSong.value.artist
                                        as String
                                    : 'Loading...'),
                          ])
                    ])));
      }),
      //播放列表
      Obx(() {
        if (mpdController.currentPlayList.isEmpty) {
          return const AdwPreferencesGroup(
            borderRadius: 5,
            title: '播放列表',
            children: [
              AdwActionRow(
                title: '播放列表为空，请添加音乐',
              )
            ],
          );
        }
        return AdwPreferencesGroup(
            borderRadius: 5,
            title: '播放列表',
            children: generateMusicPlayList(mpdController.currentPlayList,
                mpdController.currentSongIndex.value));
      }),
    ]));
  }
}

List<MusicPlaylistItem> generateMusicPlayList(
    List<MpdSong> songs, int currentSongIndex) {
  List<MusicPlaylistItem> list = <MusicPlaylistItem>[];
  for (int i = 0; i < songs.length; i++) {
    final song = songs[i];
    list.add(MusicPlaylistItem(song: song, currentSongIndex: currentSongIndex));
  }
  return list;
}
