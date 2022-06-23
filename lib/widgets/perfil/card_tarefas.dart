import 'package:flutter/material.dart';

class CardTarefas extends StatelessWidget {
  CardTarefas({Key? key, required this.numero, required this.titulo})
      : super(key: key);
  String numero;
  String titulo;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: SizedBox(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Text(
                numero,
                style: TextStyle(fontSize: 30),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                titulo,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
        height: 100,
      ),
      color: Colors.grey,
    );
  }
}
