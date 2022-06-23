import 'package:objectbox/objectbox.dart';

@Entity()
class Task {
  Task({
    required this.titulo,
    required this.usuarioId,
    required this.descricao,
    required this.data,
    required this.hora,
    required this.minutos,
    required this.repetir,
  });

  int id = 0;
  int usuarioId;
  String titulo;
  String descricao;
  @Property(type: PropertyType.date)
  DateTime data;
  int hora;
  int minutos;
  String repetir;

  @override
  String toString() {
    return titulo;
  }
}

/*import 'dart:convert';

String chaveUsuario;
  String? link;
  String titulo;
  String descricao;
  String data;
  String hora;
  String repetir;

import 'package:crypto/crypto.dart';

class Task {
  Task({
    required this.descricao,
    required this.hora,
    required this.data,
    required this.repetir,
    required this.titulo,
    required link,
    required this.chaveUsuario,
  }) {
    link ??= md5.convert(utf8.encode(DateTime.now().toString())).toString();
  }

  String chaveUsuario;
  String? link;
  String titulo;
  String descricao;
  String data;
  String hora;
  String repetir;

  Task.fromJson(Map<String, dynamic> json)
      : titulo = json['titulo'],
        descricao = json['descricao'],
        data = json['data'],
        repetir = json['repetir'],
        chaveUsuario = json['chaveUsuario'],
        hora = json['hora'];

  Map<String, dynamic> toJson() => {
        'titulo': titulo,
        'descricao': descricao,
        'data': data,
        'repetir': repetir,
        'hora': hora,
        'chaveUsuario': chaveUsuario,
      };
}
*/

