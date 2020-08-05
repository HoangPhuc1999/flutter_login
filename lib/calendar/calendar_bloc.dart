import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutterlogin/trip_repository.dart';
import 'package:meta/meta.dart';

part 'calendar_event.dart';

part 'calendar_state.dart';

class CalendarBloc extends Bloc<CalendarEvent, CalendarState> {
  CalendarBloc() : super(ShowChosenDateCalendarState(DateTime.now()));
  DateTime thisdate;
  TripRepository tripRepository = TripRepository();
  @override
  Stream<CalendarState> mapEventToState(
    CalendarEvent event,
  ) async* {

    if (event is NextDayCalendarEvent) {
      thisdate = event.date.add(const Duration(days: 1));
      yield ShowChosenDateCalendarState(thisdate);
    } else if (event is PreviousDayCalendarEvent) {
      thisdate = event.date.add(const Duration(days: -1));
      yield ShowChosenDateCalendarState(thisdate);
    } else if( event is ShowMonthCalendarEvent){
      thisdate = event.date;
      yield ShowChosenDateCalendarState(thisdate);
    }
  }

}
