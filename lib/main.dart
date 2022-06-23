import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:planner_app/databases/clima_database.dart';
import 'package:planner_app/databases/task_database.dart';
import 'package:planner_app/databases/usuario_database.dart';
import 'package:planner_app/helper/clima_helper.dart';
import 'package:planner_app/pages/login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Intl.defaultLocale = 'pt_BR';
  initializeDateFormatting();
  await UsuarioDatabase.start();
  await TaskDatabase.start();
  await ClimaDatabase.start();
  await ClimaHelper.obterInformacoesClima();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Planner',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.amber,
      ),
      home: LoginPage(),
    );
  }
}
