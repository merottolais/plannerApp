import 'package:path_provider/path_provider.dart';
import 'package:planner_app/models/task_model.dart';
import 'package:planner_app/objectbox.g.dart';

class TaskDatabase {
  static late Store _storeInstance;

  static start() async {
    final directory = await getApplicationDocumentsDirectory();
    _storeInstance = Store(
      getObjectBoxModel(),
      directory: directory.path + "/taskDB",
    );
  }

  static List<Task>? lerTasks(int usuarioId) {
    final box = _storeInstance.box<Task>();
    final query = box.query(Task_.usuarioId.equals(usuarioId)).build();
    return query.find();
  }

  static void gravar(Task task) {
    final box = _storeInstance.box<Task>();
    box.put(task);
  }

  static void atualizar(Task task) {
    gravar(task);
  }

  static void remover(Task task) {
    final box = _storeInstance.box<Task>();
    box.remove(task.id);
  }
}
