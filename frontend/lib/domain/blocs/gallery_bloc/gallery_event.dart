import 'package:bbbb_cv_app/domain/models/category.dart';
import 'package:flutter/widgets.dart';
import 'package:equatable/equatable.dart';

abstract class AbstractEvent extends Equatable {
  const AbstractEvent();

  @override
  List<Object> get props => [];
}

class ImageEvent extends AbstractEvent {
  const ImageEvent({required this.image});

  final Image image;

  @override
  List<Object> get props => [image];
}

class GalleryEvent extends AbstractEvent {
  const GalleryEvent({required this.directoryUrl});

  final String directoryUrl;

  @override
  List<Object> get props => [directoryUrl];
}

class PrefferedCategoryEvent extends AbstractEvent {
  const PrefferedCategoryEvent({required this.category});

  final Category category;

  @override
  List<Object> get props => [category];
}
