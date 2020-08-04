import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutterlogin/api_handler.dart';
import 'package:flutterlogin/entity.dart';
import 'package:flutterlogin/notification_repository.dart';
import 'package:meta/meta.dart';

part 'notification_event.dart';

part 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  NotificationBloc() : super(NotificationInitial());
  NotificationRepository notificationRepository = NotificationRepository();

  @override
  Stream<NotificationState> mapEventToState(
    NotificationEvent event,
  ) async* {
    if (event is GetDataNotificationEvent) {
      yield* _mapGetDataNotificationEventToState(event);
    } else if (event is GetMoreDataNotificationEvent) {
      final List<NotiObject> myNotilist = event.myNotilist;
      myNotilist.addAll(await notificationRepository.getNotification(event.page + 1, 5));
      yield ReceivedDataNotificationState(event.page + 1, myNotilist);
    } else if (event is ReadNotiNotificationEvent) {
      try {
        await notificationRepository.readNotification(event.notificationId);
        final List<NotiObject> list = <NotiObject>[];
        for (final NotiObject notiObject in event.listNoti) {
          if (notiObject.notificationId == event.notificationId) {
            list.add(notiObject.copyWith(isRead: true));
          } else {
            list.add(notiObject);
          }
        }

        yield ReceivedDataNotificationState(event.page, list);
      } on APIException catch (e) {}
    }
  }

  Stream<NotificationState> _mapGetDataNotificationEventToState(
      GetDataNotificationEvent event) async* {
    List<NotiObject> myNotilist = <NotiObject>[];
    myNotilist = await notificationRepository.getNotification(0, 5);
    yield ReceivedDataNotificationState(0, myNotilist);
  }
}
