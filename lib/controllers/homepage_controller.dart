import 'package:get/get.dart';
import 'package:libadwaita/libadwaita.dart';

class HomePageController extends GetxController {
  Rx<FlapController> flapController = FlapController().obs;
  Rx<int> currentIndex = 0.obs;

  toggleFlapController() => flapController.value.toggle();
  changeCurrentIndex(v) => currentIndex.value = v;
}
