import 'package:flutter/material.dart';

import '../models/epi.dart';
import '../services/api_config.dart';
import '../services/epi_service.dart';

class EpiScreen extends StatelessWidget {
  const EpiScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de EPIs'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.close),
            tooltip: 'Fechar',
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: FutureBuilder<List<Epi>>(
        future: EpiService().buscarEpis(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Erro: ${snapshot.error}'));
          }

          final epis = snapshot.data ?? [];

          return ListView.builder(
            itemCount: epis.length,
            itemBuilder: (context, index) {
              final epi = epis[index];
              final urlImagem = '${ApiConfig.baseUrl}${epi.imagemUrl}';

              return Card(
                elevation: 3,
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: ListTile(
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      urlImagem,
                      width: 55,
                      height: 55,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          width: 55,
                          height: 55,
                          color: Colors.blue.shade50,
                          child: const Icon(
                            Icons.health_and_safety,
                            color: Colors.blue,
                            size: 30,
                          ),
                        );
                      },
                    ),
                  ),
                  title: Text(epi.nome),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${epi.categoria}\nCA: ${epi.ca} | Disp: ${epi.quantidadeDisponivel}',
                      ),
                      if (epi.isCaVencido)
                        const Text(
                          '⚠️ CA VENCIDO',
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
