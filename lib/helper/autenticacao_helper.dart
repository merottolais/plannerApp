import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:planner_app/databases/usuario_database.dart';
import 'package:planner_app/models/usuario_model.dart';

class AutenticacaoUsuario {
  static Usuario? _sessao;

  static String encodePassword(String senha) {
    return sha256.convert(utf8.encode(senha)).toString();
  }

  static bool login(String email, String senha) {
    Usuario? usuario = UsuarioDatabase.ler(email);
    if (usuario != null && usuario.senha == encodePassword(senha)) {
      _sessao = usuario;
      return true;
    } else {
      return false;
    }
  }

  static logout() {
    _sessao = null;
  }

  static Usuario? sessao() {
    return _sessao;
  }
}
