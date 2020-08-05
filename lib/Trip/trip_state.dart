part of 'trip_bloc.dart';



@immutable
abstract class TripState {}

class TripInitial extends TripState {}

class GetTripListTripState extends TripState{
  GetTripListTripState(this.triplist);
  final List<TripObject> triplist;
}

