import 'package:devcampapp/models/category.dart';
import 'package:devcampapp/models/products.dart';
import 'package:devcampapp/providers/categories_provider.dart';
import 'package:devcampapp/providers/products_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AllProductsScreen extends ConsumerWidget {
  const AllProductsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<List<Products>> products = ref.watch(productsProvider);
    final AsyncValue<List<Category>> categories = ref.watch(categoriesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('All Products'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [

            categories.when(data: (data) {
              return SizedBox(
                height: 50,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('Category: ${data[index].name}'),
                        ));
                      },
                      child: Chip(
                        padding: const EdgeInsets.all(10),
                        labelPadding: EdgeInsets.zero,
                        label: Text(data[index].name),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => const SizedBox(width: 10),
                  itemCount: data.length,
                ),
              );
            }, error: (error, stk) {
              return Center(
                child: Text('Error: $error'),
              );
            }, loading: () {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }),


            products.when(data: (data) {
              return ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Image.network(
                      data[index].images != null && data[index].images!.isNotEmpty ? data[index].images!.first : 'https://via.placeholder.com/150',
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                    title: Text(data[index].title.toString()),
                    subtitle: Text(data[index].description.toString()),
                  );
                },
                separatorBuilder: (context, index) => const Divider(),
                itemCount: data.length,
              );
            }, error: (error, stk) {
              return Center(
                child: Text('Error: $error'),
              );
            }, loading: () {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }),
          ],
        ),
      ),
    );
  }
}
