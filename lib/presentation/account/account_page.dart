import 'package:fashiondome/bloc/list_order/list_order_bloc.dart';
import 'package:fashiondome/common/global_variables.dart';
import 'package:fashiondome/data/datasource/auth_local_datasource.dart';
import 'package:fashiondome/data/models/response/auth_response_model.dart';
import 'package:fashiondome/presentation/auth/login_page.dart';
import 'package:fashiondome/presentation/history_order/history_order.dart';
import 'package:fashiondome/presentation/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => AccountPageState();
}

class AccountPageState extends State<AccountPage> {
  User? user;

  @override
  void initState() {
    getUser();
    context.read<ListOrderBloc>().add(const ListOrderEvent.get());
    super.initState();
  }

  Future<void> getUser() async {
    user = await AuthLocalDatasource().getUser();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          automaticallyImplyLeading: false,
          flexibleSpace: Container(
            decoration:
                const BoxDecoration(color: GlobalVariables.primaryColor),
          ),
          title: const Text(
            'Profile',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CircleAvatar(
                radius: 60,
                child: Icon(
                  Icons.person_3_outlined,
                  size: 80,
                )),
            const SizedBox(height: 20),
            Text(
              user != null ? user!.username : '-',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              user != null ? user!.email : '-',
              style: const TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {},
              child: const Text('Edit Profile'),
            ),
            const SizedBox(height: 20),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('My Account'),
              onTap: () {
                // Tambahkan logika untuk pergi ke halaman akun
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {
                // Tambahkan logika untuk pergi ke halaman pengaturan
              },
            ),
            ListTile(
              leading: const Icon(Icons.exit_to_app),
              title: const Text('Logout'),
              onTap: () async {
                await AuthLocalDatasource().removeAuthData();
                if (context.mounted) {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const LoginPage();
                  }));
                }
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 2,
        selectedItemColor: GlobalVariables.selectedNavBarColor,
        unselectedItemColor: GlobalVariables.unselectedNavBarColor,
        backgroundColor: GlobalVariables.backgroundColor,
        iconSize: 28,
        onTap: (index) {},
        items: [
          // HOME
          BottomNavigationBarItem(
            icon: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const HomePage();
                    },
                  ),
                );
              },
              child: const Icon(
                Icons.home_outlined,
              ),
            ),
            activeIcon: const Icon(
              Icons.home,
            ),
            label: 'Home',
          ),

          BottomNavigationBarItem(
            icon: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const HistoryOrderPage();
                    },
                  ),
                );
              },
              child: const Icon(
                Icons.history_sharp,
              ),
            ),
            activeIcon: const Icon(
              Icons.history_sharp,
            ),
            label: 'Riwayat',
          ),
          // ACCOUNT
          BottomNavigationBarItem(
            icon: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const AccountPage();
                    },
                  ),
                );
              },
              child: const Icon(
                Icons.person_outline_outlined,
              ),
            ),
            activeIcon: const Icon(
              Icons.person_outline,
            ),
            label: 'Profil',
          ),
          // CART
        ],
      ),
    );
  }
}
