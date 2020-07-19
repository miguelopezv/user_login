import 'dart:async';

class Validators {
  final validEmail =
      StreamTransformer<String, String>.fromHandlers(handleData: (email, sink) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(pattern);

    regExp.hasMatch(email)
        ? sink.add(email)
        : sink.addError('email is not valid.');
  });

  final validPassword = StreamTransformer<String, String>.fromHandlers(
      handleData: (password, sink) => {
            password.length >= 6
                ? sink.add(password)
                : sink.addError('more than 6 characters')
          });
}
