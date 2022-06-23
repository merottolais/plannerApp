// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:planner_app/controller/cadastro_controller.dart';
import 'package:validators/validators.dart';

class CadastroPage extends StatelessWidget {
  CadastroPage({Key? key}) : super(key: key);
  final _form = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _senha = TextEditingController();
  final _nome = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        centerTitle: true,
        title: Text('PLANNER'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 60),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Center(
                child: Text(
                  "CADASTRAR",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
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
                                  if (!isEmail(value!)) {
                                    return 'Informe um endereço de email!';
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
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: ElevatedButton(
                      onPressed: () {
                        if (_form.currentState!.validate()) {
                          cadastrarConta(
                            context,
                            _nome.text,
                            _email.text,
                            _senha.text,
                          );
                        }
                      },
                      child: Text('Cadastrar'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
