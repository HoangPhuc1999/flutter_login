import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutterlogin/entity.dart';
import 'package:flutterlogin/trip_repository.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';

part 'trip_event.dart';

part 'trip_state.dart';

class TripBloc extends Bloc<TripEvent, TripState> {
  TripBloc() : super(TripInitial());
  TripRepository tripRepository = TripRepository();
   DateTime dateTime = DateTime.now();


  @override
  Stream<TripState> mapEventToState(
    TripEvent event,
  ) async* {
    if (event is GetDataTripEvent) {
      List<TripObject> triplist = <TripObject>[];
      String formattedDate = DateFormat('yyyyMMdd ').format(dateTime);
      print('vaicalon'+formattedDate);
      triplist = await tripRepository.getTripInfo(formattedDate);
      yield GetTripListTripState(triplist);
    }
  }
}
