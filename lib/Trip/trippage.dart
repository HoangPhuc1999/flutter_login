import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterlogin/Trip/trip_bloc.dart';
import 'package:flutterlogin/entity.dart';
import 'package:flutterlogin/trip_repository.dart';

class TripPage extends StatefulWidget {
  const TripPage({Key key, @required this.onFinishChange, @required this.onStartChange}) : super(key: key);
  final VoidCallback onFinishChange;
  final VoidCallback onStartChange;
  @override
  _TripPageState createState() => _TripPageState();
}

class _TripPageState extends State<TripPage> {
  TripRepository tripRepository = TripRepository();
  TripBloc bloc;

  @override
  void initState() {
    bloc = BlocProvider.of<TripBloc>(context);
    bloc.add(GetDataTripEvent(DateTime.now()));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TripBloc, TripState>(
        cubit: bloc,
        builder: (BuildContext context, TripState state) {
          if (state is GetTripListTripState) {
            widget.onFinishChange();
            return tripList(context, state);
          } else if (state is FailToGetDataTripState) {
            //_fail(state.errorMessage);
            widget.onFinishChange();
          } else if (state is LoadingTripListTripState) {
            widget.onStartChange();
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
        separatorBuilder: (BuildContext context, int index) => const Divider(),
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

//  void _fail(String error) {
//    showDialog<dynamic>(
//      context: context,
//      barrierDismissible: false,
//      builder: (BuildContext context) {
//        return AlertDialog(
//          actions: const <Widget>[
//            CloseButton(),
//          ],
//          title: Text(error),
//        );
//      },
//    );
//  }
}
