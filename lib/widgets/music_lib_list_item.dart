import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:libadwaita/libadwaita.dart';

import '../controllers/mpd_controller.dart';

class MusicLibListItem extends StatelessWidget {
  MusicLibListItem(
      {Key? key,
      required this.title,
      required this.musicUrl,
      this.isLocalMusic = true})
      : super(key: key);
  final String title;
  final String musicUrl;
  final bool isLocalMusic;

  final mpdController = Get.put(MpdController());

  @override
  Widget build(BuildContext context) {
    return AdwActionRow(
      title: title,
      end:
          baseMusicListItemPopupMenu(url: musicUrl, isLocalMusic: isLocalMusic),
    );
  }

  Widget baseMusicListItemPopupMenu(
      {required String url, required bool isLocalMusic}) {
    if (!isLocalMusic) {
      return ToggleButtons(
        renderBorder: false,
        borderRadius: const BorderRadius.all(Radius.circular(5)),
        isSelected: const [false, false],
        children: [
          IconButton(
            // TODO 添加网络歌曲
            onPressed: () => mpdController.addRemoteSongToList(url),
            icon: const Icon(
              Icons.playlist_add,
            ),
            tooltip: '添加到播放列表',
          ),
          IconButton(
            onPressed: () => debugPrint('下载：$url'),
            icon: const Icon(
              Icons.download,
            ),
            tooltip: '下载到库',
          ),
        ],
      );
    }
    return ToggleButtons(
      renderBorder: false,
      borderRadius: const BorderRadius.all(Radius.circular(5)),
      isSelected: const [false],
      children: [
        IconButton(
          onPressed: () => mpdController.addLoacalSongToList(url),
          icon: const Icon(
            Icons.playlist_add,
          ),
          tooltip: '添加到播放列表',
        ),
      ],
    );
  }
}
