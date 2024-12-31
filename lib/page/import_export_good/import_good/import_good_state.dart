part of 'import_good_bloc.dart';

sealed class ImportGoodState extends Equatable {
  const ImportGoodState();
}

final class ImportGoodInitial extends ImportGoodState {
  @override
  List<Object> get props => [];
}
