// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class EditarPerfilPage extends StatelessWidget {
  EditarPerfilPage({Key? key}) : super(key: key);
  final _form = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _senha = TextEditingController();
  final _nome = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [BackButton()],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                      child: ClipOval(
                    child: SizedBox.fromSize(
                        size: Size.fromRadius(80), // Image radius
                        child: Image.asset('images/taylor.jpg')),
                  )),
                ],
              ),
            ),
            Center(
              child: Text(
                'Lais Merotto',
                style: TextStyle(fontSize: 20),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                children: [
                  Form(
                    key: _form,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _nome,
                          style: TextStyle(fontSize: 16),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Nome',
                            prefixIcon: Icon(Icons.text_fields),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Informe o nome!';
                            } else {}
                            return null;
                          },
                        ),
                        SizedBox(
                          width: 20,
                          height: 40,
                        ),
                        TextFormField(
                          controller: _email,
                          style: TextStyle(fontSize: 16),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Email',
                            prefixIcon: Icon(Icons.email),
                          ),
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Informe o endereço de email!';
                            } else {}
                            return null;
                          },
                        ),
                        SizedBox(
                          width: 20,
                          height: 40,
                        ),
                        TextFormField(
                          obscureText: true,
                          controller: _senha,
                          style: TextStyle(fontSize: 16),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Senha',
                            prefixIcon: Icon(Icons.password),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Informe a senha!';
                            } else {}
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 40,
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        // Respond to button press
                      },
                      child: Text('Editar'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
