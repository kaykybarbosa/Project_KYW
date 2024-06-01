import 'package:get/get.dart';
import 'package:kyw_management/data/db/database.dart';

class DatabaseBindings implements Bindings {
  @override
  void dependencies() {
    Get.put<IDatabase>(Database(Get.find()));
  }
}
