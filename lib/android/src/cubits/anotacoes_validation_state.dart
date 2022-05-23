part of 'anotacoes_validation_cubit.dart';


abstract class AnotacoesValidationState extends Equatable {
  const AnotacoesValidationState();
}

// campos do formulario aguardando validacao com sucesso
class AnotacoesValidating extends AnotacoesValidationState {
  const AnotacoesValidating({
    this.tituloMessage,
    this.descricaoMessage,
    this.statusMessage,
  });

  final String? tituloMessage;
  final String? descricaoMessage;
  final String? statusMessage;

  AnotacoesValidating copyWith({
    String? tituloMessage,
    String? descricaoMessage,
    String? statusMessage, 
  }) {
    return AnotacoesValidating(
      tituloMessage: tituloMessage ?? this.tituloMessage,
      descricaoMessage: descricaoMessage ?? this.descricaoMessage,
      statusMessage: statusMessage ?? this.statusMessage,
    );
  }

  @override
  List<Object?> get props => [tituloMessage, descricaoMessage, statusMessage];
}

// campos do formulario validados com sucesso
class AnotacoesValidated extends AnotacoesValidationState {
  const AnotacoesValidated();

  @override
  List<Object> get props => [];
}