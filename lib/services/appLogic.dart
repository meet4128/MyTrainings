import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/constants/constants.dart';
import 'package:flutter_app/model/articlesInfo.dart';
import 'package:flutter_app/services/baseServices.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:intl/intl.dart';

class AppLogic implements BaseServices {
  Future<List<Articles>> parseJsonFromAssets(String assetsPath) {
    return rootBundle.loadString(assetsPath).then((jsonStr) {
      var data = json.decode(jsonStr);
      List<Articles> _articles = ArticlesInfo.fromJson(data).articles;
      return _articles;
    });
  }

  void nextPrevPage(controller, isNext) {
    isNext
        ? controller.nextPage(
        duration: Duration(milliseconds: 300), curve: Curves.linear)
        : controller.previousPage(
        duration: Duration(milliseconds: 300), curve: Curves.linear);
  }

  @override
  List<Widget> imageSliders() {
    return Constants.imgList
        .map((item) => Container(
              child: Center(
                child: Container(
                  child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      child: Stack(
                        children: <Widget>[
                          CachedNetworkImage(
                            imageUrl: item,
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                          ),
                        ],
                      )),
                ),
              ),
            ))
        .toList();
  }

  @override
  String convertDate(serverDate,format) {
    var inputFormat = DateFormat("yyyy-MM-ddTHH:mm:SSS");
    var inputDate = inputFormat.parse(serverDate);
    var outputFormat = DateFormat(format);
    return  outputFormat.format(inputDate);
  }

}