import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubits/anotacoes_cubit.dart';
import '../models/activity_notes.dart';

import 'anotacoes_edit.dart';

class AnotacoesList extends StatelessWidget {
  const AnotacoesList(this.activityNotes, {Key? key}) : super(key: key);
  final List<ActivityNotes>? activityNotes;
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        for (final activityNote in activityNotes!) ...[
          Padding(
            padding: const EdgeInsets.all(2.5),
            child: ListTile(
              tileColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              title: Row(
                children: [
                  Text(activityNote.titulo),
                  const SizedBox(
                    width: 20,
                  ),
                  Text(
                    activityNote.status,
                    style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueGrey[400]),
                  )
                ],
              ),
              subtitle: Text(
                activityNote.descricao,
              ),
              trailing: Wrap(children: <Widget>[
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              AnotacoesEdit(activityNotes: activityNote)),
                    );
                  },
                ),
                IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      // excluir anotações atraves do id
                      showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          title: const Text('Excluir Anotação'),
                          content: const Text('Confirmar operação?'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text('Cancelar'),
                            ),
                            TextButton(
                              onPressed: () {
                                context
                                    .read<AnotacoesCubit>()
                                    .excluirAnotacoes(activityNote.id);
                                print(activityNote.id);
                                Navigator.pop(context);
                                ScaffoldMessenger.of(context)
                                  ..hideCurrentSnackBar()
                                  ..showSnackBar(const SnackBar(
                                    content: Text('Nota excluída com sucesso'),
                                  ));
                              },
                              child: const Text('OK'),
                            ),
                          ],
                        ),
                      );
                    }),
              ]),
            ),
          ),
        ],
      ],
    );
  }
}
