import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterlogin/entity.dart';
import 'package:flutterlogin/notification/notification_bloc.dart';

class NotificationPage extends StatefulWidget {
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  final NotificationBloc bloc = NotificationBloc();

  @override
  void initState() {
    bloc.add(GetDataNotificationEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotificationBloc, NotificationState>(
        cubit: bloc,
        builder: (BuildContext context, NotificationState state) {
          if (state is ReceivedDataNotificationState) {
            return _buildBody(context, state);
          } else if (state is FailToReceiveDate) {
          }

          return Container();
        });
  }

  Widget _buildBody(BuildContext context, ReceivedDataNotificationState state) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Thông báo')),
        backgroundColor: const Color(0xFF084388),
        actions: <Widget>[
          Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {
                  // bloc.add(GetMoreDataNotificationEvent(state.page));
                },
                child: Icon(
                  Icons.markunread,
                  size: 30.0,
                ),
              )),
        ],
      ),
      body: Column(children: <Widget>[
        Container(
          height: 540.0,
          padding: const EdgeInsets.only(right: 20.0),
          child: Expanded(
            child: ListView.separated(
              itemCount: state.myNotilist.length,
              itemBuilder: (BuildContext context, int index) {
                final NotiObject notiObject = state.myNotilist[index];
                return myListofNoti(notiObject);
              },
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(),
            ),
          ),
        ),
        RichText(
          text: TextSpan(
              style: TextStyle(fontWeight: FontWeight.bold,color:const Color(0xFF084388)),
              text: "Xem thêm",
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  bloc.add(GetMoreDataNotificationEvent(state.page));
                  print('Privacy Policy"');
                }),
        ),
      ]),
    );
  }

  Widget myListofNoti(NotiObject notiObject) {
    return ListTile(
      title: Text(notiObject.notificationContent),
    );
  }
}
