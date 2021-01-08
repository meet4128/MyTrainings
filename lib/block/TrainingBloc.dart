import 'package:flutter/widgets.dart';
import 'package:flutter_app/block/TrainingEvent.dart';
import 'package:flutter_app/block/TrainingState.dart';
import 'package:flutter_app/model/articlesInfo.dart';
import 'package:flutter_app/services/appLogic.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TrainingBloc extends Bloc<TrainingEvent, TrainingState> {
  AppLogic repository;

  TrainingBloc({@required this.repository}) : super(null);

  TrainingState get initialState => TrainingInitialState();

  @override
  Stream<TrainingState> mapEventToState(TrainingEvent event) async* {
    if (event is FetchArticlesEvent) {
      yield TrainingLoadingState();
      try {
        List<Articles> articles =
            await repository.parseJsonFromAssets("assets/api_data.json");
        yield TrainingLoadedState(articles: articles);
      } catch (e) {
        yield TrainingErrorState(message: e.toString());
      }
    }
  }
}
