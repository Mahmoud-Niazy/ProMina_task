import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:promina_task/features/auth/data/models/user_model.dart';

import '../../../data/repos/auth_repo.dart';
import 'auth_states.dart';

class AuthCubit extends Cubit<AuthStates> {
  final AuthRepo authRepo;

  AuthCubit(this.authRepo) : super(AuthInitialState());

  static AuthCubit get(context) => BlocProvider.of<AuthCubit>(context);

  UserModel? user;
  userLogin({
    required String email,
    required String password,
  }) async {
    emit(UserLoginLoadingState());
    var data = await authRepo.signIn(email: email, password: password,);
    data.fold(
      (failure) => emit(UserLoginErrorState(failure.errorMessage)),
      (userData) {
        user = userData;
        emit(UserLoginSuccessfullyState(userData));
      },
    );
  }
}
