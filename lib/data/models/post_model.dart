import 'package:task_project/domain/entities/post_entity.dart';

class PostReactionsModel extends PostReactions {
  const PostReactionsModel({
    required super.likes,
    required super.dislikes,
  });

  factory PostReactionsModel.fromJson(Map<String, dynamic> json) {
    return PostReactionsModel(
      likes: json['likes'] as int? ?? 0,
      dislikes: json['dislikes'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'likes': likes,
      'dislikes': dislikes,
    };
  }
}

class PostModel extends PostEntity {
  const PostModel({
    required super.id,
    required super.title,
    required super.body,
    required super.userId,
    required super.tags,
    required super.reactions,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      id: json['id'] as int,
      title: json['title'] as String? ?? '',
      body: json['body'] as String? ?? '',
      userId: json['userId'] as int? ?? 0,
      tags: (json['tags'] as List<dynamic>?)
              ?.map((tag) => tag as String)
              .toList() ??
          [],
      reactions: json['reactions'] is Map<String, dynamic>
          ? PostReactionsModel.fromJson(
              json['reactions'] as Map<String, dynamic>)
          : const PostReactionsModel(likes: 0, dislikes: 0),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'body': body,
      'userId': userId,
      'tags': tags,
      'reactions': {
        'likes': reactions.likes,
        'dislikes': reactions.dislikes,
      },
    };
  }
}
