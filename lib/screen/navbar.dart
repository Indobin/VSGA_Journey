import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vsga_app/view_models/auth_v_model.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthVModels>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'VSGA App',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        backgroundColor: Colors.blueAccent,
        elevation: 2,
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle),
            tooltip: 'Profil',
            onPressed: () {
              // Arahkan ke halaman profil (buat dulu route-nya)
              Navigator.pushNamed(context, '/profile');
            },
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Keluar',
            onPressed: () async {
              await auth.logout();
              Navigator.pushReplacementNamed(context, '/');
            },
          ),
        ],
      ),
      body: Center(
        child: Text(
          'Selamat datang, ${auth.currentUser?.username ?? 'User'}!',
          style: const TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
