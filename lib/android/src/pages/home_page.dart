import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import '../cubits/anotacoes_cubit.dart';
import '../cubits/anotacoes_state.dart';
import 'anotacoes_edit.dart';
import 'anotacoes_list.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: BlocProvider.of<AnotacoesCubit>(context)..buscarAnotacoes(),
      child: const HomeList(),
    );
  }
}

class HomeList extends StatelessWidget {
  const HomeList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Anotações de Atividades'),
        backgroundColor: Colors.lightBlue[400],
      ),
      body: const Conteudo(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.lightBlue[400],
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const AnotacoesEdit(activityNotes: null)),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class Conteudo extends StatelessWidget {
  const Conteudo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AnotacoesCubit>().state;

    if (state is AnotacoesInitial) {
      return const SizedBox();
    } else if (state is AnotacoesLoading) {
      return const Center(
        child: CircularProgressIndicator.adaptive(),
      );
    } else if (state is AnotacoesLoaded) {
      //a mensagem abaixo aparece se a lista de notas estiver vazia
      if (state.activityNotes!.isEmpty) {
        return Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.network(
              'https://assets5.lottiefiles.com/packages/lf20_iikbn1ww.json',
              height: 200,
              width: 200,
            ),
            const Text(
              'Não há anotações. Clique no botão abaixo para cadastrar.',
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ));
      } else {
        return AnotacoesList(state.activityNotes);
      }
    } else {
      return const Center(
        child: Text('Erro ao recuperar notas.'),
      );
    }
  }
}
