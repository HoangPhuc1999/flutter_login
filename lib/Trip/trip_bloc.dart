import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutterlogin/api_handler.dart';
import 'package:flutterlogin/entity.dart';
import 'package:flutterlogin/trip_repository.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';

part 'trip_event.dart';

part 'trip_state.dart';

class TripBloc extends Bloc<TripEvent, TripState> {
  TripBloc() : super(TripInitial());
  TripRepository tripRepository = TripRepository();

  @override
  Stream<TripState> mapEventToState(
    TripEvent event,
  ) async* {
    if (event is GetDataTripEvent) {
//    = <TripObject>[];
      String formattedDate = DateFormat('yyyyMMdd ').format(event.myDate);
      print('vaicalon' + formattedDate);

      try {
        yield LoadingTripListTripState();
        List<TripObject> triplist = await tripRepository.getTripInfo(formattedDate);
        if (triplist.isEmpty) {
          yield FailToGetDataTripState('Không có dữ liệu');
        } else {
          yield GetTripListTripState(triplist);
        }
      } on APIException catch (e) {
        yield FailToGetDataTripState(e.message());
      }
    }
  }
}
