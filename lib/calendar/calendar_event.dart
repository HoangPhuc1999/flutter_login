part of 'calendar_bloc.dart';

@immutable
abstract class CalendarEvent {}
class NextDayCalendarEvent extends CalendarEvent{

  NextDayCalendarEvent(this.date);
  final DateTime date;

}
class PreviousDayCalendarEvent extends CalendarEvent{
  PreviousDayCalendarEvent(this.date);
  final DateTime date;
}

class ShowMonthCalendarEvent extends CalendarEvent{
  ShowMonthCalendarEvent(this.date);
  final DateTime date;
}

class DisableMoveIconCalendarEvent extends CalendarEvent{
  DisableMoveIconCalendarEvent(this.buttonReady);
  final bool buttonReady;
}
