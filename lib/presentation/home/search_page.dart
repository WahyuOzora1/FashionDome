import 'package:fashiondome/bloc/search/search_bloc.dart';
import 'package:fashiondome/common/global_variables.dart';
import 'package:fashiondome/common/int_ext.dart';
import 'package:fashiondome/presentation/home/detail_product_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({
    Key? key,
    required this.search,
  }) : super(key: key);
  final String search;

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    searchController.text = widget.search;
    context.read<SearchBloc>().add(
          SearchEvent.search(widget.search),
        );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          automaticallyImplyLeading: false,
          flexibleSpace: Container(
            decoration:
                const BoxDecoration(color: GlobalVariables.primaryColor),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                  height: 42,
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  child: Material(
                    borderRadius: BorderRadius.circular(10),
                    elevation: 3,
                    child: TextFormField(
                      controller: searchController,
                      onFieldSubmitted: (_) {
                        context.read<SearchBloc>().add(
                              SearchEvent.search(searchController.text),
                            );
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
            ],
          ),
        ),
      ),
      body: BlocBuilder<SearchBloc, SearchState>(
        builder: (context, state) {
          return state.maybeWhen(
            orElse: () {
              return const Center(child: Text('Data not found'));
            },
            loading: () {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.indigo,
                ),
              );
            },
            error: () {
              return const Center(child: Text('Data not found'));
            },
            loaded: (data) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final product = data.data![index];
                  if (data.data!.isEmpty) {
                    return const Center(child: Text('Data not found'));
                  } else {
                    return InkWell(
                      onTap: () {
                        if (product.attributes!.inStock ?? false) {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return DetailProductPage(product: product);
                          }));
                        } else {
                          // If not in stock, show a SnackBar
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Product is not in stock'),
                              duration: Duration(seconds: 2),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 4, horizontal: 8),
                        child: Card(
                          elevation: 5,
                          shadowColor: GlobalVariables.primaryColor,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CircleAvatar(
                                  backgroundImage:
                                      NetworkImage(product.attributes!.image!),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        product.attributes!.name!,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        'Stok: ${product.attributes!.quantity ?? 0}',
                                        style: const TextStyle(fontSize: 14),
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        'Harga: ${product.attributes!.price!.currencyFormatRp}',
                                        style: const TextStyle(fontSize: 14),
                                      ),
                                      const SizedBox(height: 5),

                                      // Add more details as needed
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }
                },
                itemCount: data.data!.length,
              );
            },
          );
        },
      ),
    );
  }
}
