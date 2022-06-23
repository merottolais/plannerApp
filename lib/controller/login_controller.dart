import 'package:flutter/material.dart';
import 'package:planner_app/databases/usuario_database.dart';
import 'package:planner_app/helper/autenticacao_helper.dart';
import 'package:planner_app/models/usuario_model.dart';
import 'package:planner_app/pages/page_control.dart';
import 'package:planner_app/widgets/perfil/snackbar_widget.dart';

login(BuildContext context, String email, String senha) {
  Usuario? usuario = UsuarioDatabase.ler(email);

  if (usuario != null) {
    if (AutenticacaoUsuario.login(email, senha)) {
      PlannerSnackbar.snackBar(context, "Sucesso");
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PageControl(),
        ),
      );
    } else {
      PlannerSnackbar.snackBar(context, "Senha incorreta!");
    }
  } else {
    PlannerSnackbar.snackBar(context, "Não há um usuario com esse email!");
  }
}
