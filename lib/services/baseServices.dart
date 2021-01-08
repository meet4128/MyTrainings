import 'package:flutter/widgets.dart';
import 'package:flutter_app/model/articlesInfo.dart';
import 'package:flutter_app/services/appLogic.dart';

abstract class BaseServices {
  Future<List<Articles>> parseJsonFromAssets(String assetsPath);

  List<Widget> imageSliders();

  void nextPrevPage(controller, isNext);

  String convertDate(serverDate,format);
}

class Services implements BaseServices {
  BaseServices services;

  static final Services _instance = Services._internal();

  factory Services() => _instance;

  Services._internal();

  void setConfig() {
    services = AppLogic();
  }

  @override
  Future<List<Articles>> parseJsonFromAssets(String assetsPath) {
    return services.parseJsonFromAssets(assetsPath);
  }

  @override
  void nextPrevPage(controller, isNext) {
    return services.nextPrevPage(controller, isNext);
  }

  @override
  List<Widget> imageSliders() {
    return services.imageSliders();
  }

  @override
  String convertDate(serverDate,format) {
    return services.convertDate(serverDate,format);
  }
}
