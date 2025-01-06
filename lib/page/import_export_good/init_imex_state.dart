part of 'init_imex_bloc.dart';

sealed class InitImexState extends Equatable {
  const InitImexState();
}

final class InitImexInitial extends InitImexState {
  @override
  List<Object> get props => [];
}
