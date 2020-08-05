part of 'calendar_bloc.dart';

@immutable
abstract class CalendarState {}

class ShowChosenDateCalendarState extends CalendarState{
  ShowChosenDateCalendarState(this.date);
  final DateTime date;
}

class ChooseDateCalendarState extends CalendarState{
  ChooseDateCalendarState(this.date);
  final DateTime date;
}