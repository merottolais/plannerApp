import 'dart:convert';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:planner_app/databases/clima_database.dart';
import 'package:planner_app/models/clima_model.dart';

class ClimaHelper {
  static String chaveAPI = "c5d4ec61";
  static String climaAPI = "https://api.hgbrasil.com/weather";

  static bool _necessarioAtualizar() {
    List<Clima>? climas = ClimaDatabase.lerClimas();

    // nao existem dados
    if (climas == null || climas.isEmpty) {
      return true;
    }

    // o dia de hoje é maior que o ultimo dia salvo
    if (DateTime.now().compareTo(climas.last.data) > 0) {
      return true;
    }

    return false;
  }

  static DateTime _pegarData(String data) {
    return DateFormat('DD/MM/yyyy').parse('$data/2022');
  }

  static obterInformacoesClima() async {
    if (_necessarioAtualizar()) {
      Response res = await get(
        Uri.parse('$climaAPI?woeid=455900&key=$chaveAPI'),
      );

      if (res.statusCode == 200) {
        Map<String, dynamic> body = jsonDecode(res.body);
        List<dynamic> forecasts = body['results']['forecast'];
        Clima clima;

        for (var element in forecasts) {
          clima = Clima(
            data: _pegarData(element['date']),
            temperaturaMaxima: element['max'],
            temperaturaMinima: element['min'],
            descricao: element['description'],
            condicao: element['condition'],
          );

          ClimaDatabase.gravar(clima);
        }
      } else {
        throw "Não foi possivel obter a provisão climatica";
      }
    }
  }
}
