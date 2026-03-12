import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_project/domain/entities/post_entity.dart';
import 'package:task_project/domain/usecases/posts/get_posts_usecase.dart';

class PostController extends GetxController {
  final GetPostsUseCase _getPostsUseCase;

  PostController(this._getPostsUseCase);

  static const int _pageSize = 10;

  final posts = <PostEntity>[].obs;
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
    fetchPosts();
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

  Future<void> fetchPosts() async {
    isLoading.value = true;
    hasError.value = false;
    errorMessage.value = '';
    _skip = 0;
    hasReachedMax.value = false;

    final result = await _getPostsUseCase(_pageSize, _skip);
    result.fold(
      (failure) {
        hasError.value = true;
        errorMessage.value = failure.message;
      },
      (data) {
        posts.assignAll(data);
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

    final result = await _getPostsUseCase(_pageSize, _skip);
    result.fold(
      (failure) {
        hasError.value = true;
        errorMessage.value = failure.message;
      },
      (data) {
        posts.addAll(data);
        _skip += data.length;
        if (data.length < _pageSize) {
          hasReachedMax.value = true;
        }
      },
    );

    isPaginating.value = false;
  }
}
