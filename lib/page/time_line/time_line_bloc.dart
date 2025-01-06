import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'time_line_event.dart';
part 'time_line_state.dart';

class TimeLineBloc extends Bloc<TimeLineEvent, TimeLineState> {
  TimeLineBloc() : super(TimeLineInitial()) {
    on<TimeLineEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
