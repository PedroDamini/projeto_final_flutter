// lib/screens/feriado_screen.dart

import 'package:flutter/material.dart';
import 'package:meuapp/controller/feriados_controller.dart';
import 'package:meuapp/model/feriados_model.dart';
import 'package:meuapp/view/drawer.dart';

class FeriadosPage extends StatefulWidget {
  const FeriadosPage({super.key});

  @override
  State<FeriadosPage> createState() => _FeriadosPageState();
}

class _FeriadosPageState extends State<FeriadosPage> {
  late Future<List<FeriadosEntity>> feriadosFuture;
  FeriadosController controller = FeriadosController();

  @override
  void initState() {
    super.initState();
    feriadosFuture = controller.getFeriadosList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Feriados"),
      ),
      drawer: const NavDrawer(),
      body: FutureBuilder<List<FeriadosEntity>>(
        future: feriadosFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Erro ao carregar os dados'));
          } else if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                var feriado = snapshot.data![index];
                return ListTile(
                  title: Text(feriado.name ?? 'Sem nome'),
                  subtitle: Text('${controller.dateTimeToDateBR(feriado.date)} - ${feriado.type}'),
                );
              },
            );
          } else {
            return const Center(child: Text('Sem Dados Disponiveis'));
          }
        },
      ),
    );
  }
}