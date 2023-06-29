
import 'package:rxdart/rxdart.dart';

import 'validation_bloc.dart';

class LoginBloc with Validator {
  LoginBloc();

  final _emailController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();
  final _voucherController = BehaviorSubject<String>();

  Stream<String> get emailStream =>
      _emailController.stream.transform(emailValidator);
  Stream<String> get passwordStream =>
      _passwordController.stream.transform(passwordValidator);
  Stream<String> get voucherStream =>
      _voucherController.stream.transform(voucherValidator);
  Stream<bool> get loginValidStream =>
      Rx.combineLatest2(emailStream, passwordStream, (a, b) => true);

  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;
  Function(String) get changeVoucher => _voucherController.sink.add;

  String get email => _emailController.value;
  String get password => _passwordController.value;
  String get voucher => _voucherController.value;

  dispose() {
    _emailController.close();
    _passwordController.close();
    _voucherController.close();
  }
}
