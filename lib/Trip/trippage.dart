import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterlogin/Trip/trip_bloc.dart';
import 'package:flutterlogin/entity.dart';
import 'package:flutterlogin/trip_repository.dart';

class TripPage extends StatefulWidget {
  @override
  _TripPageState createState() => _TripPageState();
}

class _TripPageState extends State<TripPage> {

  TripRepository tripRepository = TripRepository();
   TripBloc bloc;

  @override
  void initState() {
    bloc = BlocProvider.of<TripBloc>(context);
    bloc.add(GetDataTripEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TripBloc, TripState>(
        cubit: bloc,

        builder: (BuildContext context, TripState state) {
          if (state is GetTripListTripState) {
            return tripList(context, state);
          }

          return Container();
        });
  }


  Widget tripList(BuildContext context, GetTripListTripState state) {
    return Expanded(
      child: ListView.separated(
        itemCount: state.triplist.length,
        itemBuilder: (BuildContext context, int index) {
          final TripObject tripObject = state.triplist[index];
          return myListofTrip(tripObject, state);
        },
        separatorBuilder: (BuildContext context, int index) =>
        const Divider(),
      ),
    );
  }

  Widget myListofTrip(TripObject tripObject, GetTripListTripState state) {
    return GestureDetector(
      child: Material(
        child: ListTile(
          title: Container(
              child: Text(tripObject.routeInfo.name +
                  '   ' +
                  tripObject.vehicle.numberPlate)),
        ),
      ),
    );
  }
}