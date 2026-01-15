import 'package:bloc/bloc.dart';
import 'package:connectly/features/home/data/models/user_model.dart';
import 'package:connectly/features/home/data/repo/home_repo.dart';
import 'package:meta/meta.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeRepo homeRepo;
  HomeCubit(this.homeRepo) : super(HomeInitialState());

  void getAllUsers() {
    emit(HomeLoadingState());

    homeRepo.getAllUsers().listen(
      (userModelList) {
        emit(HomeSuccessState(userModelList: userModelList));
      },
      onError: (error) {
        emit(HomeFailureState(errMessage: error.toString()));
      },
    );
  }
}
// we use listen not for loop because stream data is backing
