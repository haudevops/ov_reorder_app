import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'import_good_event.dart';
part 'import_good_state.dart';

class ImportGoodBloc extends Bloc<ImportGoodEvent, ImportGoodState> {
  ImportGoodBloc() : super(ImportGoodInitial()) {
    on<ImportGoodEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
