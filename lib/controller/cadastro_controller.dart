import 'package:flutter/cupertino.dart';
import 'package:planner_app/databases/usuario_database.dart';
import 'package:planner_app/helper/autenticacao_helper.dart';
import 'package:planner_app/models/usuario_model.dart';
import 'package:planner_app/widgets/perfil/snackbar_widget.dart';

cadastrarConta(BuildContext context, String nome, String email, String senha) {
  if (UsuarioDatabase.ler(email) == null) {
    senha = AutenticacaoUsuario.encodePassword(senha);
    Usuario usuario = Usuario(nome: nome, email: email, senha: senha);
    UsuarioDatabase.gravar(usuario);
    PlannerSnackbar.snackBar(context, "Cadastrado com sucesso!");
    Navigator.pop(context);
  } else {
    PlannerSnackbar.snackBar(context, "Um usuario com esse email já existe!");
  }
}
