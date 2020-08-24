import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'calendar_bloc.dart';

class Calender extends StatefulWidget {
  const Calender({
    Key key,
    @required this.onDateTimeChange,
  }) : super(key: key);
  final ValueChanged<DateTime> onDateTimeChange;

  @override
  _CalenderState createState() => _CalenderState();
}

class _CalenderState extends State<Calender> {
  //DateTime date = DateTime.now();
   CalendarBloc bloc ;

   @override
  void initState() {
    bloc = BlocProvider.of<CalendarBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CalendarBloc, CalendarState>(
      cubit: bloc,
      buildWhen: (CalendarState prev, CalendarState state){
        if(prev is ShowChosenDateCalendarState && state is ShowChosenDateCalendarState){
          if(prev.date.millisecondsSinceEpoch != state.date.millisecondsSinceEpoch){
            print('HuError ${state.date}');
            widget.onDateTimeChange(state.date);
          }
        }
        return true;
      },
      builder: (BuildContext context, CalendarState state) {
        if (state is ShowChosenDateCalendarState) {
          return showCalender(context,state);
        }
        return Container();
      },
    );
  }



  Widget showCalender(BuildContext context, ShowChosenDateCalendarState state) {
    bool _condition = true;
    return Container(
      color: Colors.white,
      height: 48.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          GestureDetector(
            onTap: state.check ? () {
              //date = decrementTime(date);
              bloc.add(PreviousDayCalendarEvent(state.date));
            }:null,
            child: Icon(
              Icons.arrow_back_ios,
              size: 30.0,
            ),
          ),
          Container(
            child: GestureDetector(
                onTap: () {
                  _selectDate(context, state.date);
                },
                child: Text(formattedDate(state.date),style: Theme.of(context).textTheme.headline5,)),
          ),
          GestureDetector(

            onTap: state.check ? () {
              //date = incrementTime(date);
              bloc.add(NextDayCalendarEvent(state.date));
            } : null,
            child: Icon(
              Icons.arrow_forward_ios,
              size: 30.0,
            ),
          ),
        ],
      ),
    );
  }

  String formattedDate(DateTime date) {
    final DateTime dateParse = DateTime.parse(date.toString());
    final String formatDate =
        '${dateParse.day}/${dateParse.month}/${dateParse.year}';
    return formatDate;
  }

  Future<DateTime> _selectDate(BuildContext context, DateTime date) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: date,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));

    if (picked != null && picked != date) date = picked;
    final DateTime dateParse = DateTime.parse(date.toString());
    final String formatDate =
        '${dateParse.day}/${dateParse.month}/${dateParse.year}';
    bloc.add(ShowMonthCalendarEvent(date));
    return date;
  }
}
