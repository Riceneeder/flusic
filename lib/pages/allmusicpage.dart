import "package:flutter/material.dart";
import "package:libadwaita/libadwaita.dart";

import '../widgets/base_music_list_item.dart';

import '../models/BaseMusicInfo.dart';

List<BaseMusicInfo> fakeMusicInfoDatas = <BaseMusicInfo>[
  BaseMusicInfo.fromJson(
      {"name": "Pascal", "url": "https://codegeex.cn", "dur": "2h 10m"}),
  BaseMusicInfo.fromJson(
      {"name": "The Sign", "url": "https://codegeex.cn", "dur": "2h 42s"}),
  BaseMusicInfo.fromJson(
      {"name": "The Sign", "url": "https://codegeex.cn", "dur": "2h 42m"})
];

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
  debugPrint('generateMusicListFromData');
  debugPrint(list.toString());
  return list;
}

class AllMusicPage extends StatelessWidget {
  AllMusicPage({Key? key}) : super(key: key);

  final List<BaseMusicListItem> musicList =
      generateMusicListFromData(data: fakeMusicInfoDatas);

  @override
  Widget build(BuildContext context) {
    return AdwClamp.scrollable(
      child: Column(
        children: [
          AdwPreferencesGroup(
            title: '本地音乐',
            borderRadius: 5,
            children: musicList,
          )
        ],
      ),
    );
  }
}
