import 'package:bloc/bloc.dart';
import 'package:connectly_app/features/profile/data/model/user_model.dart';
import 'package:meta/meta.dart';

part 'create_chat_state.dart';

class CreateChatCubit extends Cubit<CreateChatState> {
  CreateChatCubit() : super(CreateChatInitialState());
}
