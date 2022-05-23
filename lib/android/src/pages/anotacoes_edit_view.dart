import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubits/anotacoes_cubit.dart';
import '../cubits/anotacoes_state.dart';
import '../cubits/anotacoes_validation_cubit.dart';
import '../models/activity_notes.dart';

class AnotacoesEditView extends StatelessWidget {
  AnotacoesEditView({
    Key? key,
    this.activityNotes,
  }) : super(key: key);
  final ActivityNotes? activityNotes;

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _tituloController = TextEditingController();
  final TextEditingController _descricaoController = TextEditingController();
  final TextEditingController _statusController = TextEditingController();

  final FocusNode _tituloFocusNode = FocusNode();
  final FocusNode _descricaoFocusNode = FocusNode();
  final FocusNode _statusFocusNode = FocusNode();



  @override
  Widget build(BuildContext context) {
    if (activityNotes == null) {
      _tituloController.text = '';
      _descricaoController.text = '';
    } else {
      _tituloController.text = activityNotes!.titulo;
      _descricaoController.text = activityNotes!.descricao;
    }
    var campoTitulo =
        BlocBuilder<AnotacoesValidationCubit, AnotacoesValidationState>(
      builder: (context, state) {
        return TextFormField(
          decoration: const InputDecoration(
            labelText: 'Título',
          ),
          controller: _tituloController,
          focusNode: _tituloFocusNode,
          textInputAction: TextInputAction.next,
          onEditingComplete: _descricaoFocusNode.requestFocus,
          onChanged: (text) {
            context.read<AnotacoesValidationCubit>().validaForm(
                _tituloController.text,
                _descricaoController.text,
                _statusController.text);
          },
          onFieldSubmitted: (String value) {},
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: (value) {
            if (state is AnotacoesValidating) {
              if (state.tituloMessage == '') {
                return null;
              } else {
                return state.tituloMessage;
              }
            }
          },
        );
      },
    );
    var campoStatus =
        BlocBuilder<AnotacoesValidationCubit, AnotacoesValidationState>(
      builder: (context, state) {
        return TextFormField(
          decoration: const InputDecoration(
            labelText: 'Status da Anotação',
          ),
          controller: _statusController,
          focusNode: _statusFocusNode,
          textInputAction: TextInputAction.next,
          onEditingComplete: _descricaoFocusNode.requestFocus,
          onChanged: (text) {
            context.read<AnotacoesValidationCubit>().validaForm(
                _tituloController.text,
                _descricaoController.text,
                _statusController.text);
          },
          onFieldSubmitted: (String value) {},
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: (value) {
            if (state is AnotacoesValidating) {
              if (state.statusMessage == '') {
                return null;
              } else {
                return state.statusMessage;
              }
            }
          },
        );
      },
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text('Anotações de Atividades - Editar Anotações'),
        backgroundColor: Colors.blue[400],
      ),
      body: BlocListener<AnotacoesCubit, AnotacoesState>(
        listener: (context, state) {
          if (state is AnotacoesInitial) {
            const SizedBox();
          } else if (state is AnotacoesLoading) {
            showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) {
                  return const Center(
                    child: CircularProgressIndicator.adaptive(),
                  );
                });
          } else if (state is AnotacoesSuccess) {
            Navigator.pop(context);
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(const SnackBar(
                content: Text('Operação realizada com sucesso'),
              ));

            Navigator.pop(context);
            context.read<AnotacoesCubit>().buscarAnotacoes();
          } else if (state is AnotacoesLoaded) {
            Navigator.pop(context);
          } else if (state is AnotacoesFailure) {
            Navigator.pop(context);
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(const SnackBar(
                content: Text('Erro ao atualizar nota'),
              ));
          }
        },
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                campoTitulo,
                BlocBuilder<AnotacoesValidationCubit, AnotacoesValidationState>(
                  builder: (context, state) {
                    return TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Descrição',
                      ),
                      controller: _descricaoController,
                      focusNode: _descricaoFocusNode,
                      textInputAction: TextInputAction.done,
                      onChanged: (text) {
                        context.read<AnotacoesValidationCubit>().validaForm(
                            _tituloController.text,
                            _descricaoController.text,
                            _statusController.text);
                      },
                      onFieldSubmitted: (String value) {
                        if (_formKey.currentState!.validate()) {
                          //fechar teclado
                          FocusScope.of(context).unfocus();
                          context.read<AnotacoesCubit>().salvarAnotacoes(
                              activityNotes?.id,
                              _tituloController.text,
                              _descricaoController.text,
                              _statusController.text);
                        }
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (state is AnotacoesValidating) {
                          if (state.descricaoMessage == '') {
                            return null;
                          } else {
                            return state.descricaoMessage;
                          }
                        }
                      },
                    );
                  },
                ),
                campoStatus,
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: BlocBuilder<AnotacoesValidationCubit,
                        AnotacoesValidationState>(
                      builder: (context, state) {
                        return ElevatedButton(
                          onPressed: state is AnotacoesValidated
                              ? () {
                                  if (_formKey.currentState!.validate()) {
                                    //fechar teclado
                                    FocusScope.of(context).unfocus();
                                    context
                                        .read<AnotacoesCubit>()
                                        .salvarAnotacoes(
                                          activityNotes?.id,
                                          _tituloController.text,
                                          _descricaoController.text,
                                          _statusController.text,
                                        );
                                  }
                                }
                              : null,
                          child: const Text('Salvar'),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
