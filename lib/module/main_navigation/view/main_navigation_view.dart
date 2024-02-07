import 'package:flutter/material.dart';
import 'package:hyper_ui/core.dart';

class MainNavigationView extends StatefulWidget {
  MainNavigationView({Key? key}) : super(key: key);

  Widget build(context, MainNavigationController controller) {
    controller.view = this;

    return DefaultTabController(
      length: 4,
      initialIndex: controller.selectedIndex,
      child: Scaffold(
        body: IndexedStack(
          index: controller.selectedIndex,
          children: [DashboardView()],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: controller.selectedIndex,
          onTap: (newIndex) {
            if (newIndex == 1) {
              // Jika yang diklik adalah item "LOGOUT", tampilkan konfirmasi logout
              _showLogoutConfirmationDialog(context);
            } else {
              controller.updateIndex(newIndex);
            }
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                MdiIcons.viewDashboard,
              ),
              label: "Dashboard",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.exit_to_app), // Icon Logout
              label: "LOGOUT",
            ),
            // ... (kode lainnya)
          ],
        ),
      ),
    );
  }

  // Method untuk menampilkan alert konfirmasi logout
  void _showLogoutConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Konfirmasi Logout"),
          content: Text("Apakah Anda yakin ingin keluar?"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                // Jika tombol "Batal" ditekan, tutup dialog
                Navigator.of(context).pop();
              },
              child: Text("Batal"),
            ),
            TextButton(
              onPressed: () {
                // Jika tombol "Ya" ditekan, lakukan proses logout
                // Anda dapat menambahkan logika logout di sini
                // Contoh: hapus token autentikasi, bersihkan data sesi, dll.
                // Kemudian tutup dialog dan navigasi ke layar login
                Navigator.of(context).pop();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginView()),
                );
              },
              child: Text("Ya"),
            ),
          ],
        );
      },
    );
  }

  @override
  State<MainNavigationView> createState() => MainNavigationController();
}
