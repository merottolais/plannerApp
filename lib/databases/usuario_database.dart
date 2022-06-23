import 'package:path_provider/path_provider.dart';
import 'package:planner_app/models/usuario_model.dart';
import 'package:planner_app/objectbox.g.dart';

class UsuarioDatabase {
  static late Store _storeInstance;

  static start() async {
    final directory = await getApplicationDocumentsDirectory();

    _storeInstance = Store(
      getObjectBoxModel(),
      directory: directory.path + "/usuarioDB",
    );
  }

  static Usuario? ler(String email) {
    final box = _storeInstance.box<Usuario>();
    final query = box.query(Usuario_.email.equals(email)).build();
    return query.findFirst();
  }

  static void gravar(Usuario usuario) {
    final box = _storeInstance.box<Usuario>();
    box.put(usuario);
  }

  static void atualizar(Usuario usuario) {
    gravar(usuario);
  }

  static void remover(Usuario usuario) {
    final box = _storeInstance.box<Usuario>();
    box.remove(usuario.id);
  }
}
