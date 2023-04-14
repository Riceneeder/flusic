import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:libadwaita/libadwaita.dart';
import 'package:libadwaita_bitsdojo/libadwaita_bitsdojo.dart';

import '../controllers/homepage_controller.dart';

import '../widgets/homepage_popup_menu.dart';

import 'welcome.dart';
import 'test.dart';

const adwSidebarChildrens = [
  AdwSidebarItem(
    label: 'Welcome',
  ),
  AdwSidebarItem(
    label: 'Test',
  )
];
const developers = {
  'Riceneeder': 'riceneeder',
};
const adwViewStackChildrens = [Welcome(), Test()];

class MyHomePage extends StatelessWidget {
  MyHomePage({Key? key}) : super(key: key);

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
