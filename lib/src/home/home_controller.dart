import 'dart:async';
import 'dart:convert';
import 'dart:core';

import 'package:async/async.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:html/parser.dart';

import 'entities/anime.dart';
import '../debug/debug_controller.dart';

class HomeController extends GetxController {
  static final animeRef = 'https://raw.githubusercontent.com/dreamerminsk/kb-dart/master/data/2023.anime.json';
  final DebugController debug = Get.find(tag: 'debugger');
  final animeList = <Anime>[].obs;
  var selected = Anime().obs;
  var timers = 0.obs;
  var requests = 0.obs;

  @override
  void onInit() {
    debug.newInit();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    fetchAnime();
  }

  @override
  void onClose() {
    debug.newClose();
    super.onClose();
  }

  void select(int idx) {
    selected.update((value) {
      value?.title = animeList[idx].title;
      value?.wiki = animeList[idx].wiki;
    });
  }

  void copyToClipboard() {
    final encoder = JsonEncoder.withIndent('   ');
    Clipboard.setData(ClipboardData(text: encoder.convert(animeList)));
  }

  void refresh() {
    Timer.periodic(const Duration(seconds: 8), refreshWikiStats);
    timers += 1;
  }

  void refreshWikiStats(Timer timer) async {
    final zeroes = animeList.where((a) => a.wiki?.lastUpdate == null).
      where((a) => (a.wiki?.title?.length ?? 0) > 0).toList();
    if (zeroes.length > 0) {
      final piLink = 'https://en.wikipedia.org/w/index.php?title=${zeroes[0].wiki?.title}&action=info';
      final text = await fetchString(piLink);
      final document = parse(text);
      final rows = document.querySelectorAll('div.mw-pvi-month');
      if (rows.length > 0) {
        int val = int.tryParse(rows[0].text.replaceAll(RegExp(r','), '')) ?? 0;
        zeroes[0].wiki!.mviMonth = val;
        zeroes[0].wiki!.lastUpdate = DateTime.now();
      }
      final imgs = document.querySelectorAll('tr#mw-pageimages-info-label > td > a > img');
      if (imgs.length > 0) {
        String? imgLink = 'https:' + (imgs[0].attributes['src'] ?? '');
        zeroes[0].wiki!.image = imgLink;
      }
      animeList.sort((a, b) => (b.wiki?.mviMonth ?? 0).compareTo(a.wiki?.mviMonth ?? 0));
      animeList.refresh();
    } else {
      timer.cancel();
      timers -= 1;
    }
  }

  void fetchAnime() async {
    try {
      final text = await fetchString(animeRef);
      final jsonList = jsonDecode(text);
      final al = List<Anime>.from(jsonList.map((i) => Anime.fromJson(i)));
      animeList.assignAll(al);
    } catch(e) {
      Get.snackbar('fetchAnime', '$e', snackPosition: SnackPosition.BOTTOM);
    }
  }

  Future<Result<Map>> fetchMap(
  String link,
 {Map<String, String>? params}) async {
    try {
      debug.newReq();
      var bytes = 0;
      var ttl = 0;
      final dio.Response<Map> response = await dio.Dio().get(
          link, queryParameters: params,
          onReceiveProgress: (received, total) {
            bytes = received;
            ttl = (total > 0) ? total : received;
          }
      );
      debug.newBytes(bytes);
      debug.newRes({'time': DateTime.now(), 'total': ttl});
      return Result.value(response.data ?? {});
    } catch (e, s) {
      Get.snackbar('HomeController.fetchMap', '$e', snackPosition: SnackPosition.BOTTOM);
      return Result.error(e, s);
    }
  }

  Future<String> fetchString(String link) async {
    try {
      requests += 1;
      var response = await dio.Dio().get(link);
      return response.data.toString();
    } catch (e) {
      Get.snackbar('fetchString', '$e', snackPosition: SnackPosition.BOTTOM);
    }
    return '';
  }

}
