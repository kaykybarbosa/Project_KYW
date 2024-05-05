import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:kyw_management/app/controllers/app_controller.dart';
import 'package:kyw_management/data/repositories/auth/auth_repository.dart';
import 'package:kyw_management/data/requests_models/user_login_request.dart';
import 'package:kyw_management/data/services/configure_login_service.dart';
import 'package:kyw_management/domain/models/auth_user_model.dart';
import 'package:kyw_management/ui/state_management/models_input/password_input.dart';

part 'authenticate_user_state.dart';

class AuthenticateUserCubit extends Cubit<AuthenticateUserState> {
  AuthenticateUserCubit({
    required IAuthRepository authRepository,
    required this.appController,
    required this.authSettings,
  })  : _repository = authRepository,
        super(const AuthenticateUserState());

  final IAuthRepository _repository;
  final AppController appController;
  final IAuthSettingsService authSettings;
  void changedStatus(AuthenticateUserStatus status) => emit(state.copyWith(status: status));

  void changedPassword(String value) {
    var password = PasswordInput.dirty(value);

    emit(
      state.copyWith(
        password: password,
        isValid: Formz.validate([password]),
      ),
    );
  }

  void changedObscureText() => emit(state.copyWith(obscureText: !state.obscureText));

  void authenticate([bool? authWithPassword]) async {
    if (authWithPassword ?? false & !state.isValid) return;

    emit(state.copyWith(status: AuthenticateUserStatus.inProgress));

    AuthUserModel authUser = await appController.authUser;

    bool authWithPassword_0 = authWithPassword ?? false;
    String password = authWithPassword_0 ? state.password.value : authUser.password;

    var request = UserLoginRequest(email: authUser.email, password: password);
    var result = await _repository.login(request);

    result.fold(
      (success) async {
        await authSettings.signIn(
          authUser: AuthUserModel(email: request.email, password: request.password),
          currentUser: success,
        );

        emit(state.copyWith(status: AuthenticateUserStatus.success));
      },
      (failure) => emit(state.copyWith(
        status: AuthenticateUserStatus.failure,
        errorMessage: failure.message,
      )),
    );
  }
}
