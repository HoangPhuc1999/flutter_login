import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterlogin/second/second_bloc.dart';
import '../route.dart';

class SecondScreen extends StatefulWidget {
  const SecondScreen({Key key,@required this.firstpagetext,@required this.firstpagetext1}) : super(key: key);
  final String firstpagetext;
  final String firstpagetext1;

  @override
  _SecondScreenState createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {

  final SecondBloc bloc = SecondBloc();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    bloc.close();
    super.dispose();
  }
@override
  void initState() {
  bloc.add(GetDataSecondEvent());
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SecondBloc, SecondState>(
        cubit: bloc,
        buildWhen: (SecondState prev, SecondState state) {
          if (state is MoveBackToFirstScreenSecondState) {
            Navigator.popUntil(context, ModalRoute.withName(RoutesName.firstpage));
            return false;
          }
          return true;
        },
        builder: (BuildContext context, SecondState state) {
          if (state is SecondInitial) {
            return _buildBody(context,state);
          }

          return Container();
        });
  }

  Widget _buildBody(BuildContext context,SecondInitial state){
    return Scaffold(
      appBar: AppBar(
        title: const Text('Second Screen'),
        automaticallyImplyLeading: false,

      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Center(
          child: Column(

              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Center(
                  child:
                      //Text(widget.firstpagetext),
                      Text(widget.firstpagetext),
                ),
                Center(
                  child:
                      //Text(widget.firstpagetext),
                      Text(widget.firstpagetext1),
                ),
                Center(
                  child: RaisedButton(
                    child: const Text('Log out'),
                    onPressed: ()  {
                    bloc.add(ClickLogOutEventSecondEvent());
                    },
                  ),
                ),
              ]),
        ),
      ),
    );
  }
}
