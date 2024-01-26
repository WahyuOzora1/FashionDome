import 'package:fashiondome/bloc/list_order/list_order_bloc.dart';
import 'package:fashiondome/common/int_ext.dart';
import 'package:fashiondome/data/datasource/auth_local_datasource.dart';
import 'package:fashiondome/data/models/response/auth_response_model.dart';
import 'package:fashiondome/data/models/response/list_order_response_model.dart';
import 'package:fashiondome/presentation/account/account_page.dart';
import 'package:fashiondome/presentation/history_order/detail_history_order.dart';
import 'package:fashiondome/presentation/history_order/widget/build_info_widget.dart';
import 'package:fashiondome/presentation/history_order/widget/build_status_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../common/global_variables.dart';
import '../home/home_page.dart';

class HistoryOrderPage extends StatefulWidget {
  const HistoryOrderPage({super.key});

  @override
  State<HistoryOrderPage> createState() => HistoryOrderPageState();
}

class HistoryOrderPageState extends State<HistoryOrderPage> {
  double bottomBarWidth = 42;
  double bottomBarBorderWidth = 5;
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
            'Riwayat Transaksi',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
      ),
      body: Column(
        children: [
          Expanded(child: BlocBuilder<ListOrderBloc, ListOrderState>(
            builder: (context, state) {
              // print("statenya adalah $state");
              return state.maybeWhen(
                orElse: () {
                  return const Center(
                    child: Text('Error Server'),
                  );
                },
                loading: () => const Center(
                  child: CircularProgressIndicator(
                    color: GlobalVariables.primaryColor,
                  ),
                ),
                loaded: (data) {
                  if (data.data!.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              decoration: const BoxDecoration(),
                              height: 150,
                              width: 150,
                              child:
                                  Image.asset('assets/images/emptyWidget.png')),
                          const Text(
                            "Tidak ada riwayat pemesanan",
                            style: TextStyle(fontSize: 15),
                          )
                        ],
                      ),
                    );
                  }
                  return ListView.builder(
                    itemBuilder: (context, index) {
                      final Order order = data.data![index];

                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return OrderDetailPage(
                                  order: order,
                                );
                              },
                            ),
                          );
                        },
                        child: Card(
                          elevation: 8,
                          margin: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Stack(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Order #${order.id}',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 7),
                                          child: Text(
                                            _formatDate(order
                                                    .attributes!.createdAt!)
                                                .toString(),
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                              color:
                                                  GlobalVariables.primaryColor,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 4),
                                      child: Text(
                                        order.attributes!.deliveryAddress!,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                          color: Colors.grey[600],
                                        ),
                                      ),
                                    ),
                                    buildOrderInfo(
                                        'Total Harga',
                                        order.attributes!.totalPrice!
                                            .currencyFormatRp),
                                    buildOrderInfo('Status',
                                        order.attributes?.statusOrder),
                                  ],
                                ),
                              ),
                              Positioned(
                                top: 0,
                                right: 0,
                                child: buildStatusIcon(
                                    order.attributes?.statusOrder),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    itemCount: data.data!.length,
                  );
                },
              );
            },
          ))
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,
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

  String _formatDate(DateTime date) {
    // Menambahkan 7 jam pada waktu
    final adjustedDate = date.add(const Duration(hours: 7));

    final formatter = DateFormat('dd MMMM y, HH:mm z', 'id_ID');
    return formatter.format(adjustedDate);
  }
}
