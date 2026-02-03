part of 'chats_cubit.dart';

@immutable
sealed class ChatsState {}

final class ChatsInitialState extends ChatsState {}
final class ChatsLoadingState extends ChatsState {}
final class ChatsSuccessState extends ChatsState {
  final List<ChatListTileModel> chats;
  ChatsSuccessState({required this.chats});
}
final class ChatsFailureState extends ChatsState {
  final String errMessage;

  ChatsFailureState({required this.errMessage});
}
