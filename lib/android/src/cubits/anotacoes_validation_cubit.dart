import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'anotacoes_validation_state.dart';

class AnotacoesValidationCubit extends Cubit<AnotacoesValidationState> {
  AnotacoesValidationCubit() : super(const AnotacoesValidating());

  
  void validaForm(String titulo, String descricao, String status) {
    String cubitTituloMessage = '';
    String cubitDescricaoMessage = '';
    String cubitStatusMessage = '';
    bool formInvalid;

    formInvalid = false;
    if (titulo == '') {
      formInvalid = true;
      cubitTituloMessage = 'Preencha o título';
    } else {
      cubitTituloMessage = '';
    }
    if (descricao == '') {
      formInvalid = true;
      cubitDescricaoMessage = 'Preencha a descrição';
    } else {
      cubitDescricaoMessage = '';
    }if(status == '') {
      formInvalid = true;
      cubitStatusMessage = 'Por favor definir o status da anotação';
    }

    if (formInvalid == true) {
      emit(AnotacoesValidating(
        tituloMessage: cubitTituloMessage,
        descricaoMessage: cubitDescricaoMessage,
        statusMessage: cubitStatusMessage,
      ));
    } else {
      emit(const AnotacoesValidated());
    }
  }
}