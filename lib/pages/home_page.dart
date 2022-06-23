import 'package:flutter/material.dart';
import 'package:flutter_calendar_week/flutter_calendar_week.dart';
import 'package:planner_app/controller/home_controller.dart';
import 'package:planner_app/controller/task_controller.dart';
import 'package:planner_app/databases/clima_database.dart';
import 'package:planner_app/models/task_model.dart';
import 'package:planner_app/pages/perfil_page.dart';
import 'package:planner_app/widgets/perfil/tarefa_widget.dart';

import '../models/clima_model.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int diaSelecionado = DateTime.now().day;
  List<Task> tasks = [];
  final CalendarWeekController _controller = CalendarWeekController();
  List<Clima>? climas = ClimaDatabase.lerClimas();

  @override
  void initState() {
    super.initState();
    tasks = carregarTasks(diaSelecionado)!;
  }

  obterClima() {
    List<Clima>? filter = climas?.where(
      (element) {
        return element.data.day == diaSelecionado;
      },
    ).toList();

    if (filter != null && filter.isNotEmpty) {
      Clima clima = filter.first;

      return Expanded(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                clima.descricao,
                style: TextStyle(fontSize: 20),
              ),
              Text(
                  'Max: ${clima.temperaturaMaxima}  Min: ${clima.temperaturaMinima}'),
            ],
          ),
        ),
      );
    } else {
      return Text('Sem informações climaticas...');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              obterClima(),
              GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => PerfilPage(),
                  ),
                ),
                child: SizedBox(
                  child: ClipOval(
                    child: SizedBox.fromSize(
                        size: Size.fromRadius(50), // Image radius
                        child: Image.asset('images/taylor.jpg')),
                  ),
                ),
              ),
            ],
          ),
          CalendarWeek(
            controller: _controller,
            height: 80,
            showMonth: true,
            onDatePressed: (data) => {
              setState(() => {
                    diaSelecionado = data.day,
                    tasks = carregarTasks(diaSelecionado)!
                  }),
            },
            dayOfWeek: const [
              'S',
              'T',
              'Q',
              'Q',
              'S',
              'S',
              'D',
            ],
            pressedDateBackgroundColor: Colors.black26,
            pressedDateStyle: TextStyle(
              color: Colors.white,
              fontSize: 25,
              fontWeight: FontWeight.w400,
            ),
            backgroundColor: Colors.transparent,
            marginDayOfWeek: EdgeInsets.zero,
            marginMonth: EdgeInsets.zero,
            todayDateStyle: TextStyle(
              color: Colors.black,
              fontSize: 25,
              fontWeight: FontWeight.w300,
            ),
            dateStyle: TextStyle(
              color: Colors.black,
              fontSize: 25,
              fontWeight: FontWeight.w300,
            ),
            weekendsStyle: TextStyle(
              color: Colors.black38,
              fontSize: 25,
              fontWeight: FontWeight.w300,
            ),
            dayOfWeekStyle: TextStyle(
              color: Colors.black38,
              fontSize: 25,
              fontWeight: FontWeight.w300,
            ),
            minDate: DateTime.now().add(
              Duration(days: -365),
            ),
            maxDate: DateTime.now().add(
              Duration(days: 365),
            ),
            monthViewBuilder: (DateTime time) => Align(
              alignment: FractionalOffset.center,
              child: null,
            ),
          ),
          /*Container(
            height: 110,
            child: Card(
              child: ListTile(
                title: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Text('Chuva'),
                ),
                trailing: Icon(Icons.account_tree),
                subtitle: Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    children: [
                      Text('Temperatura maxima: 22'),
                      Text('Temperatura minima: 12'),
                    ],
                  ),
                ),
              ),
            ),
          ),
          */
          Expanded(
            child: Container(
              child: tasks.isEmpty
                  ? Center(
                      child: Text('Não há tarefas para o dia de hoje!'),
                    )
                  : SingleChildScrollView(
                      child: Column(
                        children: [
                          for (var i = 0; i < tasks.length; i++) ...[
                            TarefaWidget(
                              task: tasks[i],
                            ),
                          ],
                        ],
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
