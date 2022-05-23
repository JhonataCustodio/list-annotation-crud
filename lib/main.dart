import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/android/src/cubits/anotacoes_cubit.dart';
import 'package:todo_app/android/src/pages/home_page.dart';

import 'android/src/data/db_activity_notes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
    @override
    Widget build(BuildContext context) {
      return  RepositoryProvider(
      create: (context) => DbActivityNotes.instance,
      child: BlocProvider(
        create: (context) =>
            AnotacoesCubit(dbActivityNotes: DbActivityNotes.instance),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Anotações de Atividades',
          color: Colors.blue[400],
          home: const HomePage(),
        ),
      ),
    );
    }
}