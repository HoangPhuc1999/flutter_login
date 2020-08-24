part of 'trip_bloc.dart';

@immutable
abstract class TripState {}

class TripInitial extends TripState {}

class GetTripListTripState extends TripState {
  GetTripListTripState(this.triplist);

  final List<TripObject> triplist;
}

class LoadingTripListTripState extends TripState {}

class FailToGetDataTripState extends TripState {
  FailToGetDataTripState(this.errorMessage);

  final String errorMessage;
}
