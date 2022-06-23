import 'package:objectbox/objectbox.dart';

@Entity()
class Clima {
  Clima({
    required this.data,
    required this.temperaturaMaxima,
    required this.temperaturaMinima,
    required this.descricao,
    required this.condicao,
  });

  int id = 0;
  @Property(type: PropertyType.date)
  DateTime data;
  int temperaturaMaxima;
  int temperaturaMinima;
  String descricao;
  String condicao;

  @override
  String toString() {
    return descricao;
  }
}
