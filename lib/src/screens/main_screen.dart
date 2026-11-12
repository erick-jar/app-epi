import 'package:app_epi/src/models/usuario.dart';
import 'package:flutter/material.dart';

import 'cadastrar_treinamento_screen.dart';
import 'dashboard_view.dart';
import 'emprestimos_screen.dart';
import 'epi_screen.dart';
import 'funcionario_screen.dart';
import 'login_screen.dart';
import 'treinamento_screen.dart';

class MainScreen extends StatelessWidget {
  final Usuario usuario;

  const MainScreen({
    super.key,
    required this.usuario,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Empréstimos de EPIs'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(usuario.nome),
              accountEmail: Text(usuario.perfil),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Text(
                  usuario.nome.isNotEmpty ? usuario.nome[0].toUpperCase() : 'U',
                  style: const TextStyle(fontSize: 40.0, color: Colors.blue),
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Início'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.health_and_safety),
              title: const Text('EPIs'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EpiScreen(usuario: usuario),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.assignment),
              title: const Text('Meus Empréstimos'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        MeusEmprestimosScreen(usuario: usuario),
                  ),
                );
              },
            ),
            if (usuario.perfil.toUpperCase() == 'ADMIN')
              ListTile(
                leading: const Icon(Icons.add_task),
                title: const Text('Cadastrar Treinamento'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          CadastrarTreinamentoScreen(usuario: usuario),
                    ),
                  );
                },
              ),
            ListTile(
              leading: const Icon(Icons.school),
              title: const Text('Treinamentos'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TreinamentosScreen(usuario: usuario),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.people),
              title: const Text('Funcionários'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const FuncionarioScreen(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: const Text('Sair'),
              onTap: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                  (route) => false,
                );
              },
            ),
          ],
        ),
      ),
      body: DashboardView(usuario: usuario),
    );
  }
}
