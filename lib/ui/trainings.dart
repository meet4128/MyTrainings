import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/block/TrainingBloc.dart';
import 'package:flutter_app/constants/colorutils.dart';
import 'package:flutter_app/services/appLogic.dart';
import 'package:flutter_app/services/baseServices.dart';
import 'package:flutter_app/ui/traingList.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/sliderScreen.dart';

class TrainingsView extends StatefulWidget {
  @override
  _TrainingsViewState createState() => _TrainingsViewState();
}

class _TrainingsViewState extends State<TrainingsView> {
  @override
  void initState() {
    super.initState();
    Services().setConfig();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Trainings"),
        backgroundColor: ColorUtils.redBackground,
        elevation: 0,
        actions: [
          Icon(Icons.menu),
          Container(padding: EdgeInsets.all(10))
        ],
      ),
      body: SafeArea(child: _screenView()),
    );
  }

  Widget _screenView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Flexible(
          flex: 45,
          child: Stack(
            children: [
              Column(
                children: [
                  Flexible(
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      color: ColorUtils.redBackground,
                      child: Container(
                        margin: EdgeInsets.only(left: 20, top: 20),
                        child: Text(
                          "Highlights",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                    flex: 1,
                  ),
                  Flexible(
                    flex: 1,
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: Container(
                        margin: EdgeInsets.only(left: 25, bottom: 15),
                        color: Colors.white,
                        child: Container(
                          width: 70,
                          height: 30,
                          child: FlatButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0),
                                side: BorderSide(color: Colors.black38)),
                            color: Colors.white,
                            textColor: Colors.black38,
                            padding: EdgeInsets.all(8.0),
                            onPressed: () {},
                            child: Text(
                              "Filter",
                              style: TextStyle(
                                fontSize: 12.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Center(child: HeaderListings())
            ],
          ),
        ),
        Flexible(
          flex: 55,
          child: BlocProvider(
              create: (context) => TrainingBloc(repository: AppLogic()),
              child: TrainingList()),
        ),
      ],
    );
  }
}
