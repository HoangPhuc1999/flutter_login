part of 'notification_bloc.dart';

@immutable
abstract class NotificationEvent {}

class GetDataNotificationEvent extends NotificationEvent{}
class ClickClearButtonNotificationEvent extends NotificationEvent{}
class GetMoreDataNotificationEvent extends NotificationEvent{
  GetMoreDataNotificationEvent(this.page);
  final int page ;
}


