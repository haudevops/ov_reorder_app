import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'export_good_event.dart';
part 'export_good_state.dart';

class ExportGoodBloc extends Bloc<ExportGoodEvent, ExportGoodState> {
  ExportGoodBloc() : super(ExportGoodInitial()) {
    on<ExportGoodEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
