import 'package:bloc/bloc.dart';
import '../data/db_activity_notes.dart';
import '../models/activity_notes.dart';
import 'anotacoes_state.dart';

class AnotacoesCubit extends Cubit<AnotacoesState> {
  AnotacoesCubit({required DbActivityNotes dbActivityNotes})
      : _dbActivityNotes = dbActivityNotes,
        super(const AnotacoesInitial());

  //instancia do banco de dados sqlite
  final DbActivityNotes _dbActivityNotes;

  //buscar todas as anotacoes
  Future<void> buscarAnotacoes() async {
    emit(const AnotacoesLoading());
    try {
      final activityNotes = await _dbActivityNotes.listAnotacoes();
      print(activityNotes.length);
      emit(AnotacoesLoaded(
        activityNotes: activityNotes,
      ));
    } on Exception {
      emit(const AnotacoesFailure());
    }
  }

  //excluir nota atraves um id
  Future<void> excluirAnotacoes(id) async {
    emit(const AnotacoesLoading());

    await Future.delayed(const Duration(seconds: 2));
    try {
      await _dbActivityNotes.deleteAnotacoes(id);
      print(id);
      buscarAnotacoes();
    } on Exception {
      emit(const AnotacoesFailure());
    }
  }

  //salvar anotacoes
  Future<void> salvarAnotacoes(int? id, String titulo, String descricao, String status) async {
    ActivityNotes editAnotacoes = ActivityNotes(id: id, titulo: titulo, descricao: descricao, status: status);
    emit(const AnotacoesLoading());
    await Future.delayed(const Duration(seconds: 2));
    try {
      if (id == null) {
        editAnotacoes = await _dbActivityNotes.insertAnotacoes(editAnotacoes);
        print(id);
        print('inserção realizado');
      } else {
        editAnotacoes = await _dbActivityNotes.update(editAnotacoes);    
        print(id);
        print('update realizado');
      }
      emit(const AnotacoesSuccess());
      // buscarAnotações();
    } on Exception {
      emit(const AnotacoesFailure());
    }
  }
}