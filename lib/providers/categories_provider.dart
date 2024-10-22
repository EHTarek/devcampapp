import 'package:devcampapp/models/category.dart';
import 'package:devcampapp/repositories/categories_repo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final categoriesProvider = FutureProvider<List<Category>>((ref) async {
  return await ref.watch(categoriesRepoProvider).getProductCategories();
});
