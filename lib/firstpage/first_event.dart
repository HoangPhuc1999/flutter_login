part of 'first_bloc.dart';

@immutable
abstract class FirstEvent {}

class ClickLogInButtonFirstEvent extends FirstEvent {
  ClickLogInButtonFirstEvent({ @required this.user, @required this.pass});
  final String user;
  final String pass;
}
