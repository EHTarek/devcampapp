import 'package:devcampapp/models/products.dart';
import 'package:devcampapp/providers/products_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AllProductsScreen extends ConsumerWidget {
  const AllProductsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<List<Products>> products = ref.watch(productsProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Products'),
      ),
      body: products.when(data: (data) {
        return ListView.separated(
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(data[index].title.toString()),
                subtitle: Text(data[index].description.toString()),
              );
            },
            separatorBuilder: (context, index) => const Divider(),
            itemCount: data.length);
      }, error: (error, stk) {
        return Center(
          child: Text('Error: $error'),
        );
      }, loading: () {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }),
    );
  }
}
