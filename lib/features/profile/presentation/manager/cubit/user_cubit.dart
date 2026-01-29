import 'package:bloc/bloc.dart';
import 'package:connectly_app/core/models/user_model.dart';
import 'package:meta/meta.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitialState());
}
