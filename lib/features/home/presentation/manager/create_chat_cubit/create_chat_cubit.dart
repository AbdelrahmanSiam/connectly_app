import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'create_chat_state.dart';

class CreateChatCubit extends Cubit<CreateChatState> {
  CreateChatCubit() : super(CreateChatInitial());
}
