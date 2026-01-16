part of 'chat_cubit.dart';

@immutable
sealed class ChatState {}

final class ChatInitialState extends ChatState {}

final class ChatLoadingState extends ChatState {}

final class SendMessageLoadingState extends ChatState {}

final class ChatSuccessState extends ChatState {
  final List<MessageModel> messageList;

  ChatSuccessState({required this.messageList});
}

final class ChatFailureState extends ChatState {
  final String errMessage;

  ChatFailureState({required this.errMessage});
}
