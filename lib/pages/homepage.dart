import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:libadwaita/libadwaita.dart';
import 'package:libadwaita_bitsdojo/libadwaita_bitsdojo.dart';

import '../controllers/homepage_controller.dart';

import '../widgets/homepage_popup_menu.dart';

import 'allmusicpage.dart';
import 'searchpage.dart';
import 'settingpage.dart';

//侧边栏
const adwSidebarChildrens = [
  AdwSidebarItem(
    leading: Icon(Icons.library_books),
    label: '乐库',
  ),
  AdwSidebarItem(
    leading: Icon(Icons.search),
    label: '搜索',
  ),
  AdwSidebarItem(
    leading: Icon(Icons.settings),
    label: '设置',
  )
];
//侧边栏路由数组
final adwViewStackChildrens = [
  AllMusicPage(),
  const SearchPage(),
  const SettingPage()
];

const developers = {
  'Riceneeder': 'riceneeder',
};

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final homepagecontroller = Get.put(HomePageController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => AdwScaffold(
          flapController: homepagecontroller.flapController.value,
          actions: AdwActions().bitsdojo,
          start: [
            AdwHeaderButton(
              icon: const Icon(
                Icons.view_sidebar_outlined,
                size: 19,
              ),
              isActive: homepagecontroller.flapController.value.isOpen,
              onPressed: homepagecontroller.toggleFlapController,
            )
          ],
          end: const [
            HomePagePpopupMenu(developers: developers),
          ],
          flap: (isDrawer) => AdwSidebar(
            currentIndex: homepagecontroller.currentIndex.value,
            isDrawer: isDrawer,
            children: adwSidebarChildrens,
            onSelected: homepagecontroller.changeCurrentIndex,
          ),
          title: const Text('初始模板'),
          body: AdwViewStack(
            animationDuration: const Duration(milliseconds: 600),
            index: homepagecontroller.currentIndex.value,
            children: adwViewStackChildrens,
          ),
        ));
  }
}
