
import 'package:intl/intl.dart';
import 'package:meuapp/model/feriados_model.dart';
import 'package:meuapp/model/feriados_repository.dart';

class FeriadosController {
  FeriadosRepository repository = FeriadosRepository();

  Future<List<FeriadosEntity>> getFeriadosList() async {
    List<FeriadosEntity> feriadosList = [];
    feriadosList = await repository.getAll();
    return feriadosList;
  }

  dateTimeToDateBR(date) {
    //da api para tela
    var inputDate = DateTime.parse(date);
    var outputFormat = DateFormat('dd/MM/yyyy');
    return outputFormat.format(inputDate);
  }

  dateBRToDateApi(ptBrDate) {
    //da tela para api
    final ptBrDateFormat = DateFormat('dd/MM/yyyy', 'pt_BR');
    final parsedDate = ptBrDateFormat.parse(ptBrDate);

    final utcDateTime = DateTime.utc(
      parsedDate.year,
      parsedDate.month,
      parsedDate.day,
    );

    final formattedDateTime =
        DateFormat("yyyy-MM-dd'T'HH:mm:ss'Z'").format(utcDateTime);
    return formattedDateTime;
  }
}
