import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterlogin/firstpage/first_bloc.dart';
import 'package:flutterlogin/route.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FirstScreen extends StatefulWidget {
  @override
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  final FirstBloc bloc = FirstBloc();
  final TextEditingController myController = TextEditingController();
  final TextEditingController myController1 = TextEditingController();
  bool _obscureText = true;

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    myController1.dispose();
    bloc.close();
    super.dispose();
  }

  void openNextPage(BuildContext context) {
    Navigator.pushNamed(
      context,
      RoutesName.secondpage,
      arguments: <String, dynamic>{
        'text': myController.text,
        'text1': myController1.text,
      },
    ).then((value) {
      myController.clear();
      myController1.clear();
    });
  }

  Future<void> addStringToSF(String text, String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, text);
    return prefs;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FirstBloc, FirstState>(
        cubit: bloc,
        buildWhen: (FirstState prev, FirstState state) {
          if (state is MoveToNextScreenFirstState) {
            addStringToSF('1', myController.text);
            addStringToSF('2', myController1.text);
            print('hello');
           // openNextPage(context);
            return false;
          } else if (state is LoginFailFirstState) {
            _fail(state.errorMessage);
            return false;
          }
          return true;
        },
        builder: (BuildContext context, FirstState state) {
          if (state is FirstInitial) {
            return _buildBody(context);
          }
          return Container();
        });
  }

  Widget _buildBody(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF084388),
      // backgroundImage: AssetImage('images/angela.jpg'),
      body: SafeArea(
        child: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Container(
                  height: 50.0,
                  width: 300.0,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('images/Anvui.png'),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 100.0,
                ),
                Center(
                  child: Container(
                    width: 370.0,
                    child: TextField(
                      decoration: const InputDecoration(
                          hintStyle: TextStyle(color: Colors.white),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          hintText: 'Tên Đăng Nhập'),
                      controller: myController,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Center(
                  child: Container(
                    width: 370.0,
                    child: TextField(
                      decoration: InputDecoration(
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _obscureText = !_obscureText;
                              });
                            },
                            icon: Icon(_obscureText
                                ? Icons.visibility
                                : Icons.visibility_off),
                          ),
                          hintStyle: const TextStyle(color: Colors.white),
                          enabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          hintText: 'Mật khẩu'),
                      obscureText: _obscureText,
                      controller: myController1,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 40.0,
                ),
                RaisedButton(
                  color: Colors.white,
                  child: Container(
                      height: 40.0,
                      width: 340.0,
                      child: const Center(
                          child: Text('Đăng Nhập',
                              style: TextStyle(color: Color(0xFF084388))))),
                  onPressed: () async {
                    print(myController.text);
                    print(myController1.text);
                    bloc.add(ClickLogInButtonFirstEvent(
                        user: myController.text, pass: myController1.text));
                    // openNextPage(context);
                  },
                ),
              ]),
        ),
      ),
    );
  }

  void _fail(String error) {
    showDialog<dynamic>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          actions: const <Widget>[
            CloseButton(),
          ],
          title: Text(error),
        );
      },
    );
  }
}
