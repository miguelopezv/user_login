import 'dart:async';
import 'package:rxdart/rxdart.dart';

import './validators.dart';

class LoginBloc with Validators {
  final _emailController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();

  Stream<String> get emailStream =>
      _emailController.stream.transform(validEmail);
  Stream<String> get passwordStream =>
      _passwordController.stream.transform(validPassword);

  Stream<bool> get loginFormStream =>
      Rx.combineLatest2(emailStream, passwordStream, (e, p) => true);

  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;

  get email => _emailController.value;
  get password => _passwordController.value;

  dispose() {
    _emailController?.close();
    _passwordController?.close();
  }
}
