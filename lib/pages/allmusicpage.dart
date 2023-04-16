import "package:flutter/material.dart";
import 'package:get/get.dart';
import "package:libadwaita/libadwaita.dart";

import '../widgets/base_music_list_item.dart';

import '../models/BaseMusicInfo.dart';

import '../controllers/config_controller.dart';

List<BaseMusicListItem> generateMusicListFromData(
    {required List<BaseMusicInfo> data}) {
  List<BaseMusicListItem> list = <BaseMusicListItem>[];
  for (int i = 0; i < data.length; i++) {
    final dataAtI = data[i];
    final String name = dataAtI.name;
    final String url = dataAtI.url;
    final String dur = dataAtI.dur;
    list.add(BaseMusicListItem(
      title: name,
      duration: dur,
      muiscUrl: url,
    ));
  }
  return list;
}

class AllMusicPage extends StatelessWidget {
  AllMusicPage({Key? key}) : super(key: key);

  final allMusicPageController = Get.put(ConfigController());

  @override
  Widget build(BuildContext context) {
    return AdwClamp.scrollable(
      child: Column(
        children: [
          Obx(() {
            List<BaseMusicListItem> musicList = generateMusicListFromData(
                data: allMusicPageController.musicInfoList);
            if (musicList.isEmpty) {
              return AdwPreferencesGroup(
                title: '本地音乐',
                borderRadius: 5,
                children: [
                  AdwActionRow(
                    title: '没有搜索到本地音乐，重新选择文件夹',
                    start: const Icon(Icons.wrong_location),
                    end: const Icon(Icons.chevron_right),
                    onActivated: () => allMusicPageController
                        .changeAndSaveLocalMusicFoldersPath(),
                  )
                ],
              );
            }
            return AdwPreferencesGroup(
              title: '本地音乐',
              borderRadius: 5,
              children: musicList,
            );
          })
        ],
      ),
    );
  }
}
