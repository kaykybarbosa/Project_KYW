import 'package:equatable/equatable.dart';
import 'package:kyw_management/domain/services/mixins/validations_mixin.dart';

import '../bloc_export.dart';

part 'my_form_event.dart';

class MyFormBloc extends Bloc<MyFormEvent, MyFormState> with ValidationsMixin {
  MyFormBloc() : super(const MyFormState()) {
    on<EmailChanged>(_onEmailChanged);
    on<PasswordChanged>(_onPasswordChanged);
  }

  void _onEmailChanged(EmailChanged event, Emitter<MyFormState> emit) {
    var email = combine([
      () => isNotEmpty(event.email),
      () => isEmailValid(event.email),
    ]);

    emit(MyFormState(
      email: email == null ? event.email : '',
      isValid: email == null ? true : false,
      status: FormStatus.initial,
    ));
  }

  void _onPasswordChanged(PasswordChanged event, Emitter<MyFormState> emit) {}
}
