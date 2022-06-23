// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:day_night_time_picker/day_night_time_picker.dart';
import 'package:planner_app/controller/task_controller.dart';
import 'package:planner_app/databases/task_database.dart';
import 'package:planner_app/models/task_model.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({Key? key}) : super(key: key);

  static Task? task;

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  final _form = GlobalKey<FormState>();
  final _titulo = TextEditingController();
  final _descricao = TextEditingController();
  DateTime? _data;
  TimeOfDay? _hora;
  String _repetir = '';

  final dropValue = ValueNotifier('');

  final dropdownOpcoes = [
    'Não',
    'Diariamente',
    'Semanalmente',
    'Mensalmente',
    'Anualmente'
  ];

  final TimeOfDay _time = TimeOfDay.now();

  bool novaTask() {
    return TaskPage.task == null;
  }

  preencherCamposAtualizacao() {
    _titulo.text = TaskPage.task!.titulo;
    _descricao.text = TaskPage.task!.descricao;
    _data = TaskPage.task!.data;
    _hora =
        TimeOfDay(hour: TaskPage.task!.hora, minute: TaskPage.task!.minutos);
    _repetir = TaskPage.task!.repetir;
    dropValue.value = TaskPage.task!.repetir;
  }

  limparCamposAtualizacao() {
    _titulo.text = "";
    _descricao.text = "";
    _data = null;
    _hora = null;
    _repetir = "";
    dropValue.value = "";
  }

  @override
  Widget build(BuildContext context) {
    if (!novaTask()) {
      preencherCamposAtualizacao();
    }
    return Form(
      key: _form,
      child: Padding(
        padding: EdgeInsets.all(20),
        child: CustomScrollView(
          scrollDirection: Axis.vertical,
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(height: 20),
                  Center(
                    child: Text(
                      "Cadastrar nova task",
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.w400),
                    ),
                  ),
                  TextFormField(
                    controller: _titulo,
                    style: TextStyle(fontSize: 16),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Título',
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Informe um título!';
                      } else {}
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 130,
                    child: TextFormField(
                      controller: _descricao,
                      maxLines: 5,
                      decoration: InputDecoration(
                        hintText: "Descrição",
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: const [
                          Padding(
                            padding: EdgeInsets.only(right: 10),
                            child: Icon(
                              Icons.calendar_today_outlined,
                            ),
                          ),
                          Text('Data', style: TextStyle(fontSize: 20)),
                        ],
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          fixedSize: const Size(140, 40),
                        ),
                        onPressed: () {
                          FocusManager.instance.primaryFocus?.unfocus();
                          showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2022, 1),
                            lastDate: DateTime(2024, 12),
                          ).then((pickedDate) {
                            setState(() {
                              _data = pickedDate;
                            });
                          });
                        },
                        child: Text(
                          _data == null
                              ? 'Data'
                              : _data!.day.toString() +
                                  '/' +
                                  _data!.month.toString() +
                                  '/' +
                                  _data!.year.toString(),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: const [
                          Padding(
                            padding: EdgeInsets.only(right: 10),
                            child: Icon(
                              Icons.alarm_outlined,
                            ),
                          ),
                          Text('Hora', style: TextStyle(fontSize: 20)),
                        ],
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          fixedSize: const Size(140, 40),
                        ),
                        onPressed: () {
                          FocusManager.instance.primaryFocus?.unfocus();
                          Navigator.of(context).push(
                            showPicker(
                              context: context,
                              value: _time,
                              onChange: (value) => {
                                setState(() {
                                  _hora = value;
                                }),
                              },
                            ),
                          );
                        },
                        child: Text(_hora == null
                            ? 'Hora'
                            : _hora!.hour.toString() +
                                ':' +
                                _hora!.minute.toString()),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: const [
                          Padding(
                            padding: EdgeInsets.only(right: 10),
                            child: Icon(
                              Icons.event_repeat_outlined,
                            ),
                          ),
                          Text(
                            'Repetir',
                            style: TextStyle(fontSize: 20),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(7.0),
                        child: ValueListenableBuilder(
                          valueListenable: dropValue,
                          builder: (BuildContext context, String value, _) {
                            return DropdownButton<String>(
                              hint: const Text('Repetir'),
                              value: (value.isEmpty) ? null : value,
                              onChanged: (escolha) => {
                                dropValue.value = escolha.toString(),
                                _repetir = escolha.toString()
                              },
                              items: dropdownOpcoes
                                  .map(
                                    (op) => DropdownMenuItem(
                                      value: op,
                                      child: Text(op),
                                    ),
                                  )
                                  .toList(),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      if (_form.currentState!.validate()) {
                        cadastrarTask(
                          context,
                          TaskPage.task,
                          _titulo.text,
                          _descricao.text,
                          _data!,
                          _hora!.hour,
                          _hora!.minute,
                          _repetir,
                        );
                        limparCamposAtualizacao();
                      }
                    },
                    child: Text(
                      novaTask() ? 'Cadastrar' : 'Atualizar',
                    ),
                  ),
                  if (!novaTask()) ...[
                    ElevatedButton(
                      onPressed: () async {
                        TaskDatabase.remover(TaskPage.task!);
                        removerTask(context);
                        limparCamposAtualizacao();
                      },
                      child: Text('Excluir'),
                    ),
                  ]
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
