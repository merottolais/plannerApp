import 'package:flutter/cupertino.dart';
import 'package:planner_app/databases/task_database.dart';
import 'package:planner_app/helper/autenticacao_helper.dart';
import 'package:planner_app/models/task_model.dart';
import 'package:planner_app/pages/page_control.dart';
import 'package:planner_app/pages/task_page.dart';
import 'package:planner_app/widgets/perfil/snackbar_widget.dart';

cadastrarTask(
  BuildContext context,
  Task? edit,
  String titulo,
  String descricao,
  DateTime data,
  int hora,
  int minutos,
  String repetir,
) {
  if (AutenticacaoUsuario.sessao() != null) {
    int usuarioId = AutenticacaoUsuario.sessao()!.id;
    Task task = Task(
      titulo: titulo,
      descricao: descricao,
      data: data,
      hora: hora,
      minutos: minutos,
      repetir: repetir,
      usuarioId: usuarioId,
    );

    if (edit != null) {
      task.id = edit.id;
    }

    TaskDatabase.gravar(task);
    PlannerSnackbar.snackBar(context, "Atividade cadastrada com sucesso!");
    PageControl.controller.jumpToPage(0);
    PageControl.controller.animateToPage(0,
        duration: Duration(milliseconds: 200),
        curve: Curves.easeInOutCubicEmphasized);
    TaskPage.task = null;
  } else {
    PlannerSnackbar.snackBar(context, "Problema ao cadastrar nova atividade!");
  }
}

removerTask(BuildContext context) {
  PlannerSnackbar.snackBar(context, "Atividade excluida com sucesso!");
  PageControl.controller.jumpToPage(0);
  TaskPage.task = null;
}

List<Task>? carregarTasks(int diaSelecionado) {
  if (AutenticacaoUsuario.sessao() != null) {
    int usuarioId = AutenticacaoUsuario.sessao()!.id;
    List<Task>? tasks = TaskDatabase.lerTasks(usuarioId);

    if (tasks != null) {
      tasks.sort(
        (a, b) => (a.hora + (a.minutos / 60)).compareTo(
          b.hora + (b.minutos / 60),
        ),
      );

      return tasks.where((task) => task.data.day == diaSelecionado).toList();
    }
  }
  return [];
}

List<Task>? carregarTodasTasks() {
  if (AutenticacaoUsuario.sessao() != null) {
    int usuarioId = AutenticacaoUsuario.sessao()!.id;
    List<Task>? tasks = TaskDatabase.lerTasks(usuarioId);

    if (tasks != null) {
      tasks.sort(
        (a, b) => (a.hora + (a.minutos / 60)).compareTo(
          b.hora + (b.minutos / 60),
        ),
      );

      return tasks;
    }
  }
  return [];
}


//fruits.where((f) => f.startsWith('a')).toList();

 

/*


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


*/



/*
cadastrarTask(String titulo, String descricao, String data, String hora,
    String repetir) async {
  Task novaTask = Task(
    descricao: descricao,
    hora: hora,
    data: data,
    repetir: repetir,
    titulo: titulo,
    link: null,
    chaveUsuario: Database.usuarioLogado!.chave!,
  );

  Database.taskUsuario ??= [];

  Database.taskUsuario!.add(novaTask);

  List<String> tasks = [];

  for (var i = 0; i < Database.taskUsuario!.length; i++) {
    tasks.add(json.encode(Database.taskUsuario![i].toJson()));
  }

  Database.gravarLista(tasks, Database.usuarioLogado!.chave!);

  // if (Database.usuarioLogado!.tarefas == null) {
  //   Database.usuarioLogado!.tarefas = [];
  // }

  // Database.usuarioLogado!.tarefas?.add(
  //   json.encode(
  //     novaTask.toJson(),
  //   ),
  // );

  // await Database.gravar(
  //   Database.usuarioLogado!.chave,
  //   jsonEncode(
  //     Database.usuarioLogado!.toJson(),
  //   ),
  // );

  return 'Tarefa criada';
}
*/
