import 'dart:convert';


List<ActivityNotes> anotacoesFromJson(String str) =>
    List<ActivityNotes>.from(json.decode(str).map((x) => ActivityNotes.fromJson(x)));

String anotacoesToJson(List<ActivityNotes> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson()))); 

class ActivityNotes {
  ActivityNotes({
    this.id,
    required this.titulo,
    required this.descricao,
    required this.status,
  });
  int? id;
  String titulo;
  String descricao;
  String status;

  factory ActivityNotes.fromJson(Map<String, dynamic> json) => ActivityNotes(
        id: json["id"],
        titulo: json["titulo"],
        descricao: json["descricao"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "titulo": titulo,
        "descricao": descricao,
        "status": status
      };
  ActivityNotes copy({
    int? id,
    String? titulo,
    String? descricao,
    String? status,
  }) =>
      ActivityNotes(
        id: id ?? this.id,
        titulo: titulo ?? this.titulo,
        descricao: descricao ?? this.descricao,
        status: status ?? this.status,
      );
}
