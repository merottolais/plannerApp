import 'package:objectbox/objectbox.dart';

@Entity()
class Usuario {
  Usuario({
    required this.nome,
    required this.email,
    required this.senha,
  });

  int id = 0;
  String nome;
  String email;
  String senha;

  @override
  String toString() {
    return nome;
  }
}
