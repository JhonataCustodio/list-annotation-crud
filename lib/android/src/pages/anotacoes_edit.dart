import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubits/anotacoes_cubit.dart';
import '../cubits/anotacoes_validation_cubit.dart';
import '../models/activity_notes.dart';

import 'anotacoes_edit_view.dart';

class AnotacoesEdit extends StatelessWidget {
  const AnotacoesEdit({ Key? key, this.activityNotes }) : super(key: key);
  final ActivityNotes? activityNotes;
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(
          value: BlocProvider.of<AnotacoesCubit>(context),
        ),
        BlocProvider(
          create: (context) => AnotacoesValidationCubit(),
        ),
      ],
      child: AnotacoesEditView(activityNotes: activityNotes),
    );
  }
}