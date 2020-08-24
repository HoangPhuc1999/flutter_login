part of 'trip_bloc.dart';

@immutable
abstract class TripEvent {}

class GetDataTripEvent extends TripEvent {
  GetDataTripEvent(this.myDate);
  final DateTime myDate;

}
