import 'package:dio/dio.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  static final anime_ref = 'https://raw.githubusercontent.com/dreamerminsk/kb-dart/first-version/data/wiki.anime.txt';
  final animeList = [].obs;
  var count = 0.obs;
  increment() => count++;

  @override
  void onInit() {
    fetchAnime();
    super.onInit();
  }

  void fetchAnime() async {
    var anime = await getAnime();
    if (anime != null) {
      animeList.assignAll(anime);
    }
  }

  String getAnime() async {
    try {
      var response = await Dio().get(anime_ref);
      return response.data.ToString();
    } catch (e) {
      print(e);
    }
    return '';
  }
}
