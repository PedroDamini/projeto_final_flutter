import 'dart:convert';

import 'package:meuapp/core/constantes.dart';
import 'package:http/http.dart' as http;
import 'package:meuapp/model/feriados_model.dart';

class FeriadosRepository {
  final Uri url = Uri.parse(urlBrasilAPI);

  Future<List<FeriadosEntity>> getAll() async {
    List<FeriadosEntity> feriadosList = [];
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body) as List;
      for (var feriados in json) {
        feriadosList.add(FeriadosEntity.fromJson(feriados));
      }
    }
    return feriadosList;
  }
}
