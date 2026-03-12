import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_project/domain/entities/product_entity.dart';
import 'package:task_project/domain/usecases/products/get_products_usecase.dart';

class ProductController extends GetxController {
  final GetProductsUseCase _getProductsUseCase;

  ProductController(this._getProductsUseCase);

  static const int _pageSize = 10;

  final products = <ProductEntity>[].obs;
  final isLoading = false.obs;
  final isPaginating = false.obs;
  final hasError = false.obs;
  final errorMessage = ''.obs;
  final hasReachedMax = false.obs;

  int _skip = 0;

  final ScrollController scrollController = ScrollController();

  @override
  void onInit() {
    super.onInit();
    scrollController.addListener(_onScroll);
    fetchProducts();
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }

  void _onScroll() {
    if (scrollController.position.pixels >=
        scrollController.position.maxScrollExtent - 200) {
      loadMore();
    }
  }

  Future<void> fetchProducts() async {
    isLoading.value = true;
    hasError.value = false;
    errorMessage.value = '';
    _skip = 0;
    hasReachedMax.value = false;

    final result = await _getProductsUseCase(_pageSize, _skip);
    result.fold(
      (failure) {
        hasError.value = true;
        errorMessage.value = failure.message;
      },
      (data) {
        products.assignAll(data);
        _skip = data.length;
        if (data.length < _pageSize) {
          hasReachedMax.value = true;
        }
      },
    );

    isLoading.value = false;
  }

  Future<void> loadMore() async {
    if (isPaginating.value || hasReachedMax.value) return;

    isPaginating.value = true;

    final result = await _getProductsUseCase(_pageSize, _skip);
    result.fold(
      (failure) {
        hasError.value = true;
        errorMessage.value = failure.message;
      },
      (data) {
        products.addAll(data);
        _skip += data.length;
        if (data.length < _pageSize) {
          hasReachedMax.value = true;
        }
      },
    );

    isPaginating.value = false;
  }
}
