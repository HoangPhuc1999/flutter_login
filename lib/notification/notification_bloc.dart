import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutterlogin/entity.dart';
import 'package:flutterlogin/notification_repository.dart';
import 'package:meta/meta.dart';

part 'notification_event.dart';

part 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  NotificationBloc() : super(NotificationInitial());
  NotificationRepository notificationRepository = NotificationRepository();
  List<NotiObject> myNotilist =  <NotiObject>[];

  @override
  Stream<NotificationState> mapEventToState(
    NotificationEvent event,
  ) async* {
    if (event is GetDataNotificationEvent) {
      myNotilist = await notificationRepository.getNotification(0,5);
      yield ReceivedDataNotificationState(0,myNotilist);
    }
    else if (event is ClickClearButtonNotificationEvent) {
    }
    else if (event is GetMoreDataNotificationEvent) {
      await notificationRepository.getNotification(event.page+1,5);
      yield ReceivedDataNotificationState(event.page,myNotilist);
    }
  }
}
