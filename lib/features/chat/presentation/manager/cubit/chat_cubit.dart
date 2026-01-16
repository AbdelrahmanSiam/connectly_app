import 'package:bloc/bloc.dart';
import 'package:connectly/features/chat/data/models/message_model.dart';
import 'package:connectly/features/chat/data/repo/chat_repo.dart';
import 'package:meta/meta.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit(this.chatRepo) : super(ChatInitialState());
  final ChatRepo chatRepo;
  Future<void> addMessage(MessageModel messageModel) async {
    emit(SendMessageLoadingState());
    await chatRepo.addMessage(messageModel);
  }

  void fetchChatMessages({required String chatId}) {
    emit(ChatLoadingState());
    chatRepo.fetchChatMessages(chatId: chatId).listen((messageList) {
      emit(ChatSuccessState(messageList: messageList));
    }, onError: (error) {
      emit(ChatFailureState(errMessage: error.toString()));
    });
  }
}
