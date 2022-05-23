import 'dart:convert';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../models/activity_notes.dart';

class DbActivityNotes {
  static final DbActivityNotes instance = DbActivityNotes._init();
  static Database? database;

  DbActivityNotes._init();

  // retorna a instancia do database
  Future<Database> get db async {
    if(database != null) return database!;
    database = await _useDB('anotacoes.db');
    return database!;
  }

  // cria a tabela anotações no database
  Future<Database> _useDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    return await openDatabase(
      join(dbPath, 'anotacoes.db'),
      onCreate: (db, version){
        return db.execute(
          'CREATE TABLE anotacoes (id INTEGER PRIMARY KEY, titulo TEXT, descricao TEXT, status TEXT)'
        );
      },
      version: 1,
    );
  }

  // insere uma nova anotação na tabela anotacoes
  Future<ActivityNotes> insertAnotacoes(ActivityNotes activityNotes) async {
    final db = await instance.db;
    final id = await db.rawInsert(
      'INSERT INTO anotacoes (titulo, descricao, status) VALUES(?,?,?)',
      [activityNotes.titulo, activityNotes.descricao, activityNotes.status]
    );
    return activityNotes.copy(id: id);
  }

  //retorno da lista de anotacoes da tabela anotacoes
  Future <List<ActivityNotes>> listAnotacoes() async {
    final db = await instance.db;
    final result = await db.rawQuery('SELECT * FROM  anotacoes ORDER BY id');

    return result.map((json) => ActivityNotes.fromJson(json)).toList();
  }

  // deleta uma anotação da tabela de anotacoes
  Future<int> deleteAnotacoes(int activityNotesId) async{
    final db = await instance.db;
    final result = await db.rawDelete('DELETE FROM anotacoes WHERE id = ?', [activityNotesId]);
    
    return result;
  }

  // realiza o update na tabela anotacoes 
  Future<ActivityNotes> update(ActivityNotes activityNotes) async {
    final db = await instance.db;
    await db.rawUpdate('UPDATE anotacoes SET titulo = ?, descricao = ?, status = ? WHERE id = ?', [activityNotes.titulo, activityNotes.descricao, activityNotes.status,activityNotes.id]);

    return activityNotes;
  }

  Future close() async {
    final db = await instance.db;
    db.close();
  }
}