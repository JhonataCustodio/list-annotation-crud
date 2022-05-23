

import 'package:equatable/equatable.dart';

import '../models/activity_notes.dart';

abstract class AnotacoesState extends Equatable {
  const AnotacoesState();
}

// estado de tela inicial
class AnotacoesInitial extends AnotacoesState {
  const AnotacoesInitial();

  @override
  List<Object?> get props => [];
}

// aguardando operacao ser realizada
class AnotacoesLoading extends AnotacoesState {
  const AnotacoesLoading();

  @override
  List<Object?> get props => [];
}

// lista de anotações carregadas
class AnotacoesLoaded extends AnotacoesState {
  const AnotacoesLoaded({
    this.activityNotes,
  });

  final List<ActivityNotes>? activityNotes;

  AnotacoesLoaded copyWith({
    List<ActivityNotes>? activityNotes,
  }) {
    return AnotacoesLoaded(
      activityNotes: activityNotes ?? this.activityNotes,
    );
  }

  @override
  List<Object?> get props => [activityNotes];
}

// falha ao realizar operacao com anotações
class AnotacoesFailure extends AnotacoesState {
  const AnotacoesFailure();

  @override
  List<Object?> get props => [];
}

// operacao realizada com sucesso
class AnotacoesSuccess extends AnotacoesState {
  const AnotacoesSuccess();

  @override
  List<Object?> get props => [];
}