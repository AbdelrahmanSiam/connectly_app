part of 'chat_cubit.dart';

@immutable
sealed class ChatState {}

final class ChatInitialState extends ChatState {}
final class ChatLoadingState extends ChatState {}
final class ChatSuccesState extends ChatState {
  final List<MessageModel> messageList;

  ChatSuccesState({required this.messageList});
}
final class ChatFailureState extends ChatState {
  final String errMessage;

  ChatFailureState({required this.errMessage});
}
