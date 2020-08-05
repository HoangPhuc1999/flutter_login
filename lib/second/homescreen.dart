import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterlogin/Trip/Trippage.dart';
import 'package:flutterlogin/Trip/trip_bloc.dart';
import 'package:flutterlogin/entity.dart';
import 'package:flutterlogin/second/second_bloc.dart';
import '../route.dart';
import 'package:flutterlogin/calendar/calendar_item.dart';

import '../trip_repository.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen(
      {Key key, @required this.firstpagetext, @required this.firstpagetext1})
      : super(key: key);
  final String firstpagetext;
  final String firstpagetext1;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final SecondBloc bloc = SecondBloc();
  final TripBloc tripBloc = TripBloc();

  TripRepository tripRepository = TripRepository();

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
            print('goodbye');
            Navigator.popUntil(
                context, ModalRoute.withName(RoutesName.firstpage));
            return false;
          }
          return true;
        },
        builder: (BuildContext context, SecondState state) {
          if (state is SecondInitial) {
            return _buildBody(context, state);
          }

          return Container();
        });
  }

  Widget _buildBody(BuildContext context, SecondState state) {
    return Scaffold(
      backgroundColor: const Color(0xFFECF0F1),
      drawer: Container(
        child: _myDrawer(context),
      ),
      appBar: AppBar(
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(
              Icons.account_circle,
              size: 30.0,
            ),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        title: const Center(child: Text('Danh Sách Chuyến Đi')),
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFF084388),
        actions: <Widget>[
          Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, RoutesName.notificationpage);
                },
                child: Icon(
                  Icons.notifications,
                  size: 30.0,
                ),
              )),
        ],
      ),
      body: Column(children: <Widget>[
        Calender(
          onDateTimeChange: (DateTime myDate) {
            tripBloc.add(GetDataTripEvent());
          },
        ),
        BlocProvider<TripBloc>(
          create: (BuildContext context) => tripBloc,
          child: TripPage(),
        ),
      ]),
    );
  }

  Widget _myDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            child: Text(
              'Side menu',
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
            decoration: BoxDecoration(
              color: Color(0xFF084388),
            ),
          ),
          ListTile(
            leading: Icon(Icons.account_circle),
            title: const Text('Thông tin cá nhân'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: Icon(Icons.library_books),
            title: const Text('Hướng dẫn'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: const Text('Đăng xuất'),
            onTap: () => {bloc.add(ClickLogOutEventSecondEvent())},
          ),
        ],
      ),
    );
  }
}
