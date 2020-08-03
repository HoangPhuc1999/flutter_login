part of 'notification_bloc.dart';

@immutable
abstract class NotificationState {}

class NotificationInitial extends NotificationState {}
class ReceivedDataNotificationState extends NotificationState{

  ReceivedDataNotificationState(this.page,this.myNotilist);
  final int page;
  final List<NotiObject> myNotilist;

}
class FailToReceiveDate extends NotificationState{}


