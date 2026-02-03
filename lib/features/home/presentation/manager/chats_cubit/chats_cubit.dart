import 'package:bloc/bloc.dart';
import 'package:connectly_app/features/home/data/model/chat_list_tile.dart';
import 'package:meta/meta.dart';

part 'chats_state.dart';

class ChatsCubit extends Cubit<ChatsState> {
  ChatsCubit() : super(ChatsInitialState());
}
