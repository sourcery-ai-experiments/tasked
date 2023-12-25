part of 'app_pages.dart';

abstract class Routes {
 Routes._();

  static const HOME = _Paths.HOME;
  static const DETAILS = _Paths.DETAILS;
  static const WATCHLIST = _Paths.WATCHLIST;
  static const CATEGORY = _Paths.CATEGORY;
  static const DEBUG = _Paths.DEBUG;
  static const POLITICS = _Paths.POLITICS;
}

abstract class _Paths {
  static const HOME = '/home';
  static const DETAILS = '/details';
  static const WATCHLIST = '/watchlist';
  static const CATEGORY = '/category';
  static const DEBUG = '/debug';
  static const POLITICS = '/politics';
}