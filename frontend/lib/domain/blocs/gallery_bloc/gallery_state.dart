import 'package:bbbb_cv_app/domain/models/category.dart';
import 'package:flutter/widgets.dart';
import 'package:equatable/equatable.dart';

abstract class GlobalImagesState extends Equatable {
  const GlobalImagesState();

  @override
  List<Object> get props => [];
}

class LoadingState extends GlobalImagesState {
  const LoadingState({required this.image});

  final Image image;

  @override
  List<Object> get props => [image];
}

class ReadyState extends GlobalImagesState {
  const ReadyState({required this.image});

  final Image image;

  @override
  List<Object> get props => [image];
}

class NoDataState extends GlobalImagesState {
  const NoDataState();

  @override
  List<Object> get props => [];
}

class GalleryState extends Equatable {
  const GalleryState({required this.gallery, this.categories});

  final List<Image> gallery;
  final List<Category>? categories;

  @override
  List<Object> get props => [gallery, categories ?? List<Category>.generate(gallery.length, (_) => Category.empty)];
}

class PrefferedItemsState extends Equatable {
  const PrefferedItemsState();

  @override
  List<Object> get props => [];
}

class PrefferedImagesState extends PrefferedItemsState {
  const PrefferedImagesState({required this.prefferedImages});

  final List<Image> prefferedImages;

  @override
  List<Object> get props => [prefferedImages];
}

class PrefferedCategoryState extends PrefferedItemsState {
  const PrefferedCategoryState({required this.category});

  final Category category;

  @override
  List<Object> get props => [category];
}
