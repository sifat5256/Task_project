import 'package:get/get.dart';
import 'package:task_project/domain/usecases/products/get_products_usecase.dart';
import 'package:task_project/presentation/controllers/product_controller.dart';

class ProductBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProductController>(
      () => ProductController(Get.find<GetProductsUseCase>()),
    );
  }
}
