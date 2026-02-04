part of 'create_chat_cubit.dart';

@immutable
sealed class CreateChatState {}

final class CreateChatInitialState extends CreateChatState {}
final class CreateChatLoadingState extends CreateChatState {}
final class CreateChatSucessState extends CreateChatState {
  final List<UserModel> userList ;

  CreateChatSucessState({required this.userList});
}
class CreateChatCreated extends CreateChatState {
  final String chatId;
  CreateChatCreated(this.chatId);
}
final class CreateChatFailureState extends CreateChatState {
  final String errMessage;

  CreateChatFailureState({required this.errMessage});
}
