part of 'notification_bloc.dart';

@immutable
abstract class NotificationEvent {}

class GetDataNotificationEvent extends NotificationEvent{}
class ClickClearButtonNotificationEvent extends NotificationEvent{}
class GetMoreDataNotificationEvent extends NotificationEvent{
  GetMoreDataNotificationEvent(this.page,this.myNotilist);
  final int page ;
  final List<NotiObject> myNotilist;

  //final int count;
}

class ReadNotiNotificationEvent extends NotificationEvent {
  ReadNotiNotificationEvent(this.notificationId, this.listNoti, this.page);
  final String notificationId;
  final List<NotiObject> listNoti;
  final int page;

}


