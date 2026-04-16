import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'active_learning_state.dart';

class ActiveLearningCubit extends Cubit<ActiveLearningState> {
  ActiveLearningCubit() : super(ActiveLearningInitial());

  
}
