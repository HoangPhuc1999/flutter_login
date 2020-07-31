part of 'first_bloc.dart';

@immutable
abstract class FirstState {}

class FirstInitial extends FirstState {}

class MoveToNextScreenFirstState  extends FirstState{}
class LoginFailFirstState extends FirstState{
  LoginFailFirstState(this.errorMessage);
  final String errorMessage;
}




