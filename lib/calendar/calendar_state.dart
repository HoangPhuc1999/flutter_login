part of 'calendar_bloc.dart';

@immutable
abstract class CalendarState {}

class ShowChosenDateCalendarState extends CalendarState{
  ShowChosenDateCalendarState(this.date, this.check);
  final DateTime date;
  final bool check;
}



