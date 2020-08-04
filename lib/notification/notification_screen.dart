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
          print(state);
          if (state is ReceivedDataNotificationState) {
            return _buildBody(context, state);
          } else if (state is FailToReceiveDate) {}

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
        Expanded(
          child: ListView.separated(
            itemCount: state.myNotilist.length,
            itemBuilder: (BuildContext context, int index) {
              //print( convertTime('MM-dd-yyyy', state.myNotilist[index].createdDate, false));
              final NotiObject notiObject = state.myNotilist[index];
              return myListofNoti(notiObject, state);
              //return myListofNoti(notiObject);
            },
            separatorBuilder: (BuildContext context, int index) =>
                const Divider(),
          ),
        ),
        GestureDetector(
          onTap: () {
            bloc.add(
                GetMoreDataNotificationEvent(state.page, state.myNotilist));
          },
          child: Text(
            'Xem them',
            style: TextStyle(
                fontWeight: FontWeight.bold, color: const Color(0xFF084388)),
          ),
        ),
      ]),
    );
  }

  Widget myListofNoti(
      NotiObject notiObject, ReceivedDataNotificationState state) {
    return GestureDetector(
      onTap: () {
        bloc.add(ReadNotiNotificationEvent(
            notiObject.notificationId, state.myNotilist, state.page));
      },
      child: Material(
        color: notiObject.isRead ? Colors.blue : Colors.white,
        child: ListTile(
          title: Container(child: Text(notiObject.notificationContent)),
        ),
      ),
    );
  }
}
