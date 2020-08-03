import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../api_handler.dart';
import '../user_repository.dart';

part 'first_event.dart';

part 'first_state.dart';

class FirstBloc extends Bloc<FirstEvent, FirstState> {
  FirstBloc() : super(FirstInitial());
  UserRepository userRepository = UserRepository();

  @override
  Stream<FirstState> mapEventToState(
    FirstEvent event,
  ) async* {
    if (event is ClickLogInButtonFirstEvent) {
      try {
        await userRepository.login(event.user, event.pass);
        yield MoveToNextScreenFirstState();
      } on APIException catch (e) {
        yield LoginFailFirstState(e.message());
      }
    }
  }
}
