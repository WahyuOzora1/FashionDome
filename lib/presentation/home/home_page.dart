import 'package:fashiondome/bloc/checkout/checkout_bloc.dart';
import 'package:fashiondome/common/global_variables.dart';
import 'package:fashiondome/presentation/account/account_page.dart';
import 'package:fashiondome/presentation/cart/cart_page.dart';
import 'package:fashiondome/presentation/history_order/history_order.dart';
import 'package:fashiondome/presentation/home/search_page.dart';
import 'package:fashiondome/presentation/home/widgets/banner_widget.dart';
import 'package:fashiondome/presentation/home/widgets/list_category_widget.dart';
import 'package:fashiondome/presentation/home/widgets/list_product_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double bottomBarWidth = 42;
  double bottomBarBorderWidth = 5;

  final TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: GlobalVariables.primaryColor,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              child: Container(
                height: 42,
                margin: const EdgeInsets.symmetric(horizontal: 5),
                child: Material(
                  borderRadius: BorderRadius.circular(10),
                  elevation: 3,
                  child: TextFormField(
                    controller: searchController,
                    onFieldSubmitted: (_) {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return SearchPage(search: searchController.text);
                      }));
                    },
                    decoration: InputDecoration(
                      prefixIcon: InkWell(
                        onTap: () {},
                        child: const Padding(
                          padding: EdgeInsets.only(
                            left: 6,
                          ),
                          child: Icon(
                            Icons.search,
                            color: Colors.black,
                            size: 23,
                          ),
                        ),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.only(top: 10),
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(7),
                        ),
                        borderSide: BorderSide.none,
                      ),
                      enabledBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(7),
                        ),
                        borderSide: BorderSide(
                          color: Colors.black38,
                          width: 1,
                        ),
                      ),
                      hintText: 'Search ',
                      hintStyle: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 17,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            // Tambahkan IconButton untuk ikon keranjang di sini
            Stack(
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.shopping_cart,
                    color: Colors.white,
                    size: 28,
                  ),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => const CartPage()));
                  },
                ),
                // Widget untuk menampilkan badge
                Positioned(
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: Colors.red, // Warna latar belakang badge
                      borderRadius: BorderRadius.circular(10),
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 18,
                      minHeight: 18,
                    ),
                    child: BlocBuilder<CheckoutBloc, CheckoutState>(
                      builder: (context, state) {
                        if (state is CheckoutLoaded) {
                          return Text(
                            state.items.length
                                .toString(), // Jumlah item di keranjang, bisa disesuaikan
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                            textAlign: TextAlign.center,
                          );
                        }
                        return const Text(
                          '0',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                          textAlign: TextAlign.center,
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      body: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 16,
          ),
          ListCategoryWidget(),
          SizedBox(
            height: 8,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: BannerWidget(),
          ),
          Padding(
            padding: EdgeInsets.only(left: 16),
            child: Text(
              'Daftar Produk',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Expanded(child: ListProductWidget()),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        selectedItemColor: GlobalVariables.selectedNavBarColor,
        unselectedItemColor: GlobalVariables.unselectedNavBarColor,
        backgroundColor: GlobalVariables.backgroundColor,
        iconSize: 28,
        onTap: (index) {},
        items: [
          // HOME
          const BottomNavigationBarItem(
            icon: Icon(
              Icons.home_outlined,
            ),
            activeIcon: Icon(Icons.home),
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
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const AccountPage()));
              },
              child: const Icon(
                Icons.person_2_outlined,
              ),
            ),
            activeIcon: const Icon(
              Icons.person_2,
            ),
            label: 'Profil',
          ),
        ],
      ),
    );
  }
}
