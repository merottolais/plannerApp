import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:planner_app/models/task_model.dart';
import 'package:planner_app/pages/page_control.dart';
import 'package:planner_app/pages/task_page.dart';

class TarefaWidget extends StatelessWidget {
  TarefaWidget({Key? key, required this.task}) : super(key: key);

  Task task;

  @override
  Widget build(BuildContext context) {
    DateFormat format = DateFormat.yMMMMd();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: InkWell(
        splashColor: Color.fromARGB(255, 255, 169, 197),
        onTap: () {
          TaskPage.task = task;
          PageControl.controller.jumpToPage(1);
        },
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: ListTile(
            title: Text(
              task.titulo,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            subtitle: Text(format.format(task.data)),
            trailing: Text('${task.hora} : ${task.minutos}'),
            isThreeLine: false,
          ),
        ),
      ),
    );
  }
}
