import 'package:path_provider/path_provider.dart';
import 'package:planner_app/models/clima_model.dart';
import 'package:planner_app/objectbox.g.dart';

class ClimaDatabase {
  static late Store _storeInstance;

  static start() async {
    final directory = await getApplicationDocumentsDirectory();
    _storeInstance = Store(
      getObjectBoxModel(),
      directory: directory.path + "/ClimaDB",
    );
  }

  static List<Clima>? lerClimas() {
    final box = _storeInstance.box<Clima>();
    return box.getAll();
  }

  static void gravar(Clima clima) {
    final box = _storeInstance.box<Clima>();
    box.put(clima);
  }

  static void atualizar(Clima clima) {
    gravar(clima);
  }

  static void remover(Clima clima) {
    final box = _storeInstance.box<Clima>();
    box.remove(clima.id);
  }
}
