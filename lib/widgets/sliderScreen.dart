import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/services/baseServices.dart';

class HeaderListings extends StatefulWidget {
  @override
  _HeaderListingsState createState() => _HeaderListingsState();
}

class _HeaderListingsState extends State<HeaderListings> {
  final CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          child: InkWell(
            onTap: () {
              Services().nextPrevPage(_controller, false);
            },
            child: Container(
                height: 80,
                child: Icon(
                  Icons.chevron_left_sharp,
                  color: Colors.white,
                ),
                alignment: Alignment.centerLeft,
                color: Colors.black.withOpacity(0.3)),
          ),
          flex: 7,
        ),
        Flexible(
          child: Container(
            height: 250,
            margin: EdgeInsets.only(left: 10, right: 10),
            child: CarouselSlider(
              items: Services().imageSliders(),
              options: CarouselOptions(
                  enlargeCenterPage: true,
                  viewportFraction: 1,
                  height: MediaQuery.of(context).size.height),
              carouselController: _controller,
            ),
          ),
          flex: 85,
        ),
        Flexible(
          child: InkWell(
            onTap: () {
              Services().nextPrevPage(_controller, true);
            },
            child: Container(
                height: 80,
                child: Icon(
                  Icons.chevron_right_sharp,
                  color: Colors.white,
                ),
                alignment: Alignment.centerRight,
                color: Colors.black.withOpacity(0.3)),
          ),
          flex: 7,
        ),
      ],
    );
  }
}
