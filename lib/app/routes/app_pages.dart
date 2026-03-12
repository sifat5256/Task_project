import 'package:get/get.dart';
import 'package:task_project/app/routes/app_routes.dart';
import 'package:task_project/presentation/bindings/auth_binding.dart';
import 'package:task_project/presentation/bindings/home_binding.dart';
import 'package:task_project/presentation/bindings/post_binding.dart';
import 'package:task_project/presentation/bindings/product_binding.dart';
import 'package:task_project/presentation/pages/auth/login_page.dart';
import 'package:task_project/presentation/pages/home/home_page.dart';
import 'package:task_project/presentation/pages/posts/post_detail_page.dart';
import 'package:task_project/presentation/pages/posts/posts_page.dart';
import 'package:task_project/presentation/pages/products/product_detail_page.dart';
import 'package:task_project/presentation/pages/products/products_page.dart';
import 'package:task_project/presentation/pages/splash/splash_page.dart';

class AppPages {
  AppPages._();

  static const _duration = Duration(milliseconds: 300);
  static const _transition = Transition.downToUp;

  static final List<GetPage> pages = [
    GetPage(
      name: AppRoutes.splash,
      page: () => const SplashPage(),
      transition: Transition.fade,
      transitionDuration: _duration,
    ),
    GetPage(
      name: AppRoutes.login,
      page: () => const LoginPage(),
      binding: AuthBinding(),
      transition: Transition.fade,
      transitionDuration: _duration,
    ),
    GetPage(
      name: AppRoutes.home,
      page: () => const HomePage(),
      binding: HomeBinding(),
      transition: Transition.fade,
      transitionDuration: _duration,
    ),
    GetPage(
      name: AppRoutes.products,
      page: () => const ProductsPage(),
      binding: ProductBinding(),
      transition: _transition,
      transitionDuration: _duration,
    ),
    GetPage(
      name: AppRoutes.posts,
      page: () => const PostsPage(),
      binding: PostBinding(),
      transition: _transition,
      transitionDuration: _duration,
    ),
    GetPage(
      name: AppRoutes.productDetail,
      page: () => const ProductDetailPage(),
      transition: _transition,
      transitionDuration: _duration,
    ),
    GetPage(
      name: AppRoutes.postDetail,
      page: () => const PostDetailPage(),
      transition: _transition,
      transitionDuration: _duration,
    ),
  ];
}
