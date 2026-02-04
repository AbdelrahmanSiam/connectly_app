import 'package:bloc/bloc.dart';
import 'package:connectly_app/features/chat/data/model/message_model.dart';
import 'package:meta/meta.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitialState());
}
