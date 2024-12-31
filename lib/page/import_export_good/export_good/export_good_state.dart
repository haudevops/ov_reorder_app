part of 'export_good_bloc.dart';

sealed class ExportGoodState extends Equatable {
  const ExportGoodState();
}

final class ExportGoodInitial extends ExportGoodState {
  @override
  List<Object> get props => [];
}
