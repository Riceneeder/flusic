import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:libadwaita/libadwaita.dart';
import 'package:libadwaita_bitsdojo/libadwaita_bitsdojo.dart';

import '../controllers/homepage_controller.dart';
import '../controllers/config_controller.dart';

import '../widgets/homepage_popup_menu.dart';
import '../widgets/global_player.dart';

import 'allmusicpage.dart';
import 'searchpage.dart';
import 'settingpage.dart';
import 'mpdpage.dart';

//侧边栏
const adwSidebarChildrens = [
  AdwSidebarItem(
    leading: Icon(Icons.play_circle_rounded),
    label: 'MPD',
  ),
  AdwSidebarItem(
    leading: Icon(Icons.library_music_rounded),
    label: '乐库',
  ),
  AdwSidebarItem(
    leading: Icon(Icons.search_rounded),
    label: '搜索',
  ),
  AdwSidebarItem(
    leading: Icon(Icons.settings_rounded),
    label: '设置',
  )
];
//侧边栏路由数组
final adwViewStackChildrens = [
  const MpdPage(),
  AllMusicPage(),
  const SearchPage(),
  SettingPage()
];

const developers = {
  'Riceneeder': 'riceneeder',
};

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final homepagecontroller = Get.put(HomePageController());
  final configController = Get.put(ConfigController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => AdwScaffold(
          flapController: homepagecontroller.flapController.value,
          flapStyle: const FlapStyle(flapWidth: 200),
          actions: AdwActions().bitsdojo,
          start: [
            AdwHeaderButton(
              icon: const Icon(
                Icons.view_sidebar_outlined,
                size: 19,
              ),
              onPressed: homepagecontroller.toggleFlapController,
            )
          ],
          end: [
            AdwHeaderButton(
                onPressed: () {
                  configController.refreshAllMusicPage();
                  const GetSnackBar(
                    message: '刷新乐库和MPD状态',
                    duration: Duration(seconds: 2),
                  ).show();
                },
                icon: const Icon(Icons.refresh_rounded)),
            const HomePagePpopupMenu(developers: developers),
          ],
          flap: (isDrawer) => AdwSidebar(
            width: 200,
            currentIndex: homepagecontroller.currentIndex.value,
            isDrawer: isDrawer,
            children: adwSidebarChildrens,
            onSelected: homepagecontroller.changeCurrentIndex,
          ),
          body: AdwViewStack(
            animationDuration: const Duration(milliseconds: 600),
            index: homepagecontroller.currentIndex.value,
            children: adwViewStackChildrens,
          ),
          title: GlobalPlayer(),
        ));
  }
}
