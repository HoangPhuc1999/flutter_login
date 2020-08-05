import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../trip_repository.dart';

part 'second_event.dart';

part 'second_state.dart';

class SecondBloc extends Bloc<SecondEvent, SecondState> {
  SecondBloc() : super(SecondInitial());
  TripRepository tripRepository = TripRepository();

  @override
  Stream<SecondState> mapEventToState(
    SecondEvent event,
  ) async* {
    if (event is ClickLogOutEventSecondEvent) {
      yield MoveBackToFirstScreenSecondState();
    }
    else if (event is GetDataSecondEvent){

    }
  }
}
