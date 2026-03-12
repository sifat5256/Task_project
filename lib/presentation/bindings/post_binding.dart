import 'package:get/get.dart';
import 'package:task_project/domain/usecases/posts/get_posts_usecase.dart';
import 'package:task_project/presentation/controllers/post_controller.dart';

class PostBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PostController>(
      () => PostController(Get.find<GetPostsUseCase>()),
    );
  }
}
