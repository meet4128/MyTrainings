import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/model/articlesInfo.dart';

abstract class TrainingState extends Equatable{}

class TrainingInitialState extends TrainingState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class TrainingLoadingState extends TrainingState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}
class TrainingLoadedState extends TrainingState{
  List<Articles> articles;
  TrainingLoadedState({@required this.articles});
  @override
  // TODO: implement props
  List<Object> get props => [articles];

}

class TrainingErrorState extends TrainingState {

  String message;

  TrainingErrorState({@required this.message});

  @override
  // TODO: implement props
  List<Object> get props => [message];
}