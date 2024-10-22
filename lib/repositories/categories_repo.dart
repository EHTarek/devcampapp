import 'package:devcampapp/models/category.dart';
import 'package:devcampapp/networking/api_endpoints.dart';
import 'package:devcampapp/networking/dio_client.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CategoriesRepo {
  final Ref ref;

  CategoriesRepo(this.ref);

  Future<List<Category>> getProductCategories() async {
    final response = await ref.read(dioProvider).get(ApiEndpoints.kGetAllCategoriesEndPoint);
    if (response.statusCode == 200) {

      List<Category> categories = response.data.map<Category>((category) {
        return Category.fromJson(category);
      }).toList();
      return categories;
    } else {
      return Future.error('Failed to load the product categories');
    }
  }
}

final categoriesRepoProvider = Provider((ref) => CategoriesRepo(ref));
