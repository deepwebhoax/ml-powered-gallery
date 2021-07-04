import 'package:bbbb_cv_app/domain/mixins/bloc_mixin.dart';
import 'package:bbbb_cv_app/data/repository/repository.dart';
import 'package:bbbb_cv_app/domain/models/category.dart';
import 'gallery_event.dart';
import 'gallery_state.dart';
import 'package:flutter/widgets.dart';
import 'package:rxdart/rxdart.dart';

class GalleryBloc with BlocMixin {
  GalleryBloc() {
    _eventController.listen(_handleEvent);
    _repository = Repository.instance;
  }

  late Repository _repository;

  final _eventController = BehaviorSubject<AbstractEvent>();
  void Function(AbstractEvent) get addEvent => _eventController.sink.add;

  final _globalImagesStateController = BehaviorSubject<GlobalImagesState>();
  Stream<GlobalImagesState> get globalImagesStateStream => _globalImagesStateController.stream;
  // HOW TO LISTEN BACKEND ??
  void Function(GlobalImagesState) get _changeGlobalImagesState => _globalImagesStateController.sink.add;

  final _galleryStateController = BehaviorSubject<GalleryState>();
  Stream<GalleryState> get galleryStateStream => _galleryStateController.stream;
  void Function(GalleryState) get _changeGalleryState => _galleryStateController.sink.add;

  final _prefferedCategoryStateController = BehaviorSubject<PrefferedCategoryState>();
  Stream<PrefferedCategoryState> get prefferedCategoryStateStream => _prefferedCategoryStateController.stream;
  void Function(PrefferedCategoryState) get _changePrefferedCategoryState => _prefferedCategoryStateController.sink.add;

  final _prefferedImagesStateController = BehaviorSubject<PrefferedImagesState>();
  Stream<PrefferedImagesState> get prefferedImagesStateStream => _prefferedImagesStateController.stream;
  void Function(PrefferedImagesState) get _changePrefferedImagesState => _prefferedImagesStateController.sink.add;

  void _handleEvent(AbstractEvent event) {
    if (event is ImageEvent) {
      _pushImageToServer(event.image);
    } else if (event is GalleryEvent) {
      final List<Image> _imageList = _getAllImagesInFolderURL(event.directoryUrl);
      _changeGalleryState(GalleryState(gallery: _imageList));
    } else if (event is PrefferedCategoryEvent) {
      if (!_galleryStateController.isClosed && _galleryStateController.hasValue) {
        if (!_prefferedCategoryStateController.isClosed &&
            _prefferedCategoryStateController.hasValue &&
            _prefferedCategoryStateController.value.category == event.category) {
          _changePrefferedCategoryState(PrefferedCategoryState(category: Category.empty));
          _changePrefferedImagesState(PrefferedImagesState(prefferedImages: _galleryStateController.value.gallery));
          return;
        }
        final List<Image> _prefferedImages = _getPrefferedImages(event.category, _galleryStateController.value);
        _changePrefferedCategoryState(PrefferedCategoryState(category: event.category));
        _changePrefferedImagesState(PrefferedImagesState(prefferedImages: _prefferedImages));
      }
    }
  }

  /// HOW TO LISTEN BACKEND ??
  void _determineGlobalImagesState(ImageEvent imageEvent) {}

  List<Image> _getPrefferedImages(Category category, GalleryState galleryState) {
    if (galleryState.categories?.isEmpty ?? true) {
      return [];
      // return galleryState.gallery;
    }
    final prefferedImages = <Image>[];
    for (int i = 0; i < galleryState.gallery.length; i++) {
      if (galleryState.categories?.elementAt(i) == category) {
        prefferedImages.add(galleryState.gallery.elementAt(i));
      }
    }
    return prefferedImages;
  }

  List<Image> _getAllImagesInFolderURL(String url) {
    return _repository.getAllImagesInFolderURL(url);
  }

  Future<bool> _pushImageToServer(Image image) async {
    return await _repository.pushImageToServer(image);
  }

  @override
  void dispose() {
    if (!_eventController.isClosed) _eventController.close();
    if (!_globalImagesStateController.isClosed) _globalImagesStateController.close();
    if (!_galleryStateController.isClosed) _galleryStateController.close();
    if (!_prefferedCategoryStateController.isClosed) _prefferedCategoryStateController.close();
    if (!_prefferedImagesStateController.isClosed) _prefferedImagesStateController.close();
  }
}
