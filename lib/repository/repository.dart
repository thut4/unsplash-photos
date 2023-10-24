import 'package:get/get.dart';

import '../model/model.dart';

class ApiRepo extends GetConnect {
  final String baseUrl = 'https://api.unsplash.com';
  final String clientId = 'ngm7FyqehFs3HR6DWaZDuP2ZqavEu1ACNbIQhzjFghc';
  @override
  void onInit() {
    super.onInit();
    httpClient.baseUrl = baseUrl;
  }

  Future<List<PhotosModel>> getPhosts(String orderBy) async {
    final response = await get('/photos?client_id=$clientId&per_page=30&order_by=$orderBy');
    if (response.statusCode == 200) {
      List<PhotosModel> photos = List<PhotosModel>.from(
          response.body.map((photos) => PhotosModel.fromJson(photos)));
      print("fetching success");
      return photos;
    } else {
      return Future.error(
          '${response.statusText} and error enable to fetching data');
    }
  }
}
