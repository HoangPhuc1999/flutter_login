import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterlogin/second/second_bloc.dart';
import '../route.dart';

class SecondScreen extends StatefulWidget {
  const SecondScreen(
      {Key key, @required this.firstpagetext, @required this.firstpagetext1})
      : super(key: key);
  final String firstpagetext;
  final String firstpagetext1;

  @override
  _SecondScreenState createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  final SecondBloc bloc = SecondBloc();
  final GlobalKey _mydrawer = new GlobalKey();

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

  Widget _buildBody(BuildContext context, SecondInitial state) {
    return Scaffold(
      drawer: Container(
        child: _myDrawer(context),
      ),
      appBar: AppBar(
        leading: Builder(
          builder: (context) => IconButton(
            icon: new Icon(Icons.account_circle,size: 30.0,),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        title: Center(child: Text('Danh Sách Chuyến Đi')),
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFF084388),
        actions: <Widget>[
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {},
                child: Icon(
                  Icons.notifications,
                  size: 30.0,
                ),
              )),
        ],
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
                    onPressed: () {
                      bloc.add(ClickLogOutEventSecondEvent());
                    },
                  ),
                ),
              ]),
        ),
      ),
    );
  }

  Widget _myDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text(
              'Side menu',
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
            decoration: BoxDecoration(
                color: Colors.green,
                image: DecorationImage(
                    fit: BoxFit.fill, image: AssetImage('images/Anvui.png'))),
          ),
          ListTile(
            leading: Icon(Icons.input),
            title: Text('Welcome'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: Icon(Icons.verified_user),
            title: Text('Profile'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: Icon(Icons.border_color),
            title: Text('Feedback'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: () => {Navigator.of(context).pop()},
          ),
        ],
      ),
    );
  }
}
