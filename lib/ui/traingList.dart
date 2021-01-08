import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/block/TrainingBloc.dart';
import 'package:flutter_app/block/TrainingEvent.dart';
import 'package:flutter_app/block/TrainingState.dart';
import 'package:flutter_app/constants/colorutils.dart';
import 'package:flutter_app/services/baseServices.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dash/flutter_dash.dart';

class TrainingList extends StatefulWidget {
  @override
  _TrainingListState createState() => _TrainingListState();
}

class _TrainingListState extends State<TrainingList> {
  TrainingBloc trainingBloc;
  @override
  void initState() {
    super.initState();
    trainingBloc = BlocProvider.of<TrainingBloc>(context);
    trainingBloc.add(FetchArticlesEvent());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: BlocListener<TrainingBloc,TrainingState>(
      listener: (context,state){
        if (state is TrainingErrorState) {
          Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
            ),
          );
        }
      },
      child: BlocBuilder<TrainingBloc,TrainingState>(
        builder: (context,state){
          if (state is TrainingInitialState) {
            return _showDialog();
          } else if (state is TrainingLoadingState) {
            return _showDialog();
          } else if (state is TrainingLoadedState) {
            return _listData(state.articles);
          } else {
            return Container();
          }
        },
      ),
    ));
  }

  Widget _showDialog() {
    return Container(
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget _listData(_articlesList){
    return Container(
      color: ColorUtils.greyBackground,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      padding: EdgeInsets.all(7),
      child: ListView.separated(
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return Card(
              elevation: 3,
              shadowColor: Colors.black12,
              child: Row(
                children: [
                  Flexible(child: _column1(_articlesList[index]), flex: 25),
                  Flexible(
                    flex: 1,
                    child: Dash(
                        direction: Axis.vertical,
                        length: 150,
                        dashLength: 3,
                        dashColor: Colors.black12),
                  ),
                  Flexible(child: _column2(_articlesList[index]), flex: 75)
                ],
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return SizedBox(
              height: 5,
            );
          },
          itemCount: _articlesList.length),
    );
  }

  Widget _column1(article) {
    return Container(
      padding: EdgeInsets.only(left: 10,bottom: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Text(Services()
                .convertDate(article.publishedAt, 'MMM dd, yyyy'),style: TextStyle(
              fontSize: 20,fontWeight: FontWeight.w600
            ),),
          ),
          SizedBox(
            height: 5,
          ),
          Container(
            child: Text(Services()
                .convertDate(article.publishedAt, 'hh:mm a')),
          ),
          SizedBox(
            height: 45,
          ),
          Container(
            child: Text(article.author),
          ),
        ],
      ),
    );
  }

  Widget _column2(article){
    return Container(
      padding: EdgeInsets.only(left: 10,bottom: 10,top: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Text(article.author,style: TextStyle(
                fontSize: 12,fontWeight: FontWeight.w600,color: ColorUtils.redBackground
            ),),
          ),
          SizedBox(height: 5),
          Container(
            child: Text(article.title,style: TextStyle(
                fontSize: 16,fontWeight: FontWeight.w400),),
          ),
          SizedBox(height: 10),
          Row(
            children: [
              Container(
                  width: 50.0,
                  height: 50.0,
                  alignment: Alignment.centerLeft,
                  decoration: new BoxDecoration(
                      shape: BoxShape.circle,
                      image: new DecorationImage(
                          fit: BoxFit.fill,
                          image: new NetworkImage(
                              article.urlToImage)
                      )
                  )),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 5),
                    child: Text(article.source.name,style: TextStyle(
                        fontSize: 12,fontWeight: FontWeight.w800
                    ),),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 5),
                    child: Text(article.author,style: TextStyle(
                        fontSize: 12
                    ),),
                  ),
                ],
              ),
            ],),
          Align(
            alignment: Alignment.bottomRight,
            child: Container(
              margin: EdgeInsets.only(right: 10),
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    side: BorderSide(color: Colors.red)),
                onPressed: () {},
                color: Colors.red,
                textColor: Colors.white,
                child: Text("Enrol Now",
                    style: TextStyle(fontSize: 14)),
              ),
            ),
          )
        ],
      ),
    );
  }
}
