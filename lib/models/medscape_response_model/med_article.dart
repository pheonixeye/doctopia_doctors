import 'package:equatable/equatable.dart';

class MedArticle extends Equatable {
  final String id;
  final String title;
  final String teaser;
  final String url;
  final String from;

  const MedArticle({
    required this.id,
    required this.title,
    required this.teaser,
    required this.url,
    required this.from,
  });

  MedArticle copyWith({
    String? id,
    String? title,
    String? teaser,
    String? url,
    String? from,
  }) {
    return MedArticle(
      id: id ?? this.id,
      title: title ?? this.title,
      teaser: teaser ?? this.teaser,
      url: url ?? this.url,
      from: from ?? this.from,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      // 'id': id,
      'title': title,
      'teaser': teaser,
      'url': url,
      'from': from,
    };
  }

  factory MedArticle.fromJson(Map<String, dynamic> map) {
    return MedArticle(
      id: map['id'] as String,
      title: map['title'] as String,
      teaser: map['teaser'] as String,
      url: map['url'] as String,
      from: map['from'] as String,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      id,
      title,
      teaser,
      url,
      from,
    ];
  }
}
