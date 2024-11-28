import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/product_repository.dart';
import '../models/product.dart';

final productProvider = StateNotifierProvider<ProductController, AsyncValue<List<Product>>>((ref) {
  return ProductController(ProductRepository());
});

class ProductController extends StateNotifier<AsyncValue<List<Product>>> {
  final ProductRepository _repository;

  ProductController(this._repository) : super(const AsyncValue.loading()) {
    loadProducts();
  }

  Future<void> loadProducts() async {
    try {
      state = const AsyncValue.loading();
      final products = await _repository.getProducts();
      state = AsyncValue.data(products);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }
}
