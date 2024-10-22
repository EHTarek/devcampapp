import 'package:devcampapp/models/products.dart';
import 'package:devcampapp/repositories/products_repo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final productsProvider = FutureProvider<List<Products>>((ref) async {
  return await ref.watch(productsRepoProvider).getProducts();
});
