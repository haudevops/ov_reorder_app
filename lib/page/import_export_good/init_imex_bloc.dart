import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'init_imex_event.dart';
part 'init_imex_state.dart';

class InitImexBloc extends Bloc<InitImexEvent, InitImexState> {
  InitImexBloc() : super(InitImexInitial()) {
    on<InitImexEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
