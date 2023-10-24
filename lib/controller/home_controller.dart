import 'package:flutter_application_photos/model/model.dart';
import 'package:flutter_application_photos/repository/repository.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  RxBool isLoading = false.obs;
  RxList<PhotosModel> photoList = List<PhotosModel>.empty().obs;
  var selectedIndex = 0.obs;
  RxString orderedBy = 'latest'.obs;
  ApiRepo apiRepo = ApiRepo();
  List<String> orderList = [
    "latest",
    "popular",
    "oldest",
    "views",
  ];

  @override
  void onInit() {
    super.onInit();
    fetchAllPhoto();
  }

  void fetchAllPhoto() async {
    await apiRepo
        .getPhosts(orderedBy.value)
        .then((value) => photoList.assignAll(value));
  }

  void orderPhots(String newValue) {
    orderedBy.value = newValue;
    fetchAllPhoto();
  }
}
