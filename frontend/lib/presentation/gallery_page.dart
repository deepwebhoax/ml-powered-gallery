import 'package:bbbb_cv_app/domain/blocs/gallery_bloc/bloc.dart';
import 'package:bbbb_cv_app/domain/models/category.dart';
import 'package:bbbb_cv_app/internal/const.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GalleryPage extends StatefulWidget {
  const GalleryPage({Key? key, this.title});

  final String? title;

  @override
  _GalleryPageState createState() => _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage> {
  Size? _size;
  double? _width;
  GalleryBloc? _bloc;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _size = MediaQuery.of(context).size;
    _width = _size?.width;
    _bloc = Provider.of<GalleryBloc>(context);
    _bloc?.addEvent(GalleryEvent(directoryUrl: Const.windowsValidDirectoryUrl));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(widget.title ?? Const.defaultTitle),
      //   backgroundColor: Color(0xFF0CBBEC),
      // ),
      body: Row(
        children: [
          Expanded(
            flex: 25,
            child: Container(
              color: Colors.brown,
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              child: StreamBuilder<GalleryState>(
                stream: _bloc?.galleryStateStream,
                builder: (context, galleryStateSnap) {
                  if (!galleryStateSnap.hasData) {
                    // || galleryStateSnap.data?.categories == null) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return StreamBuilder<PrefferedCategoryState>(
                    stream: _bloc?.prefferedCategoryStateStream,
                    builder: (context, prefferedCategoryStateSnap) {
                      // if (!prefferedStateSnap.hasData) {
                      //   // || galleryStateSnap.data?.categories == null) {
                      //   return Center(
                      //     child: CircularProgressIndicator(),
                      //   );
                      // }
                      late Category _prefferedCategory;
                      if (prefferedCategoryStateSnap.hasData) {
                        _prefferedCategory =
                            prefferedCategoryStateSnap.data?.category ??
                                Category.empty;
                      } else {
                        _prefferedCategory = Category.empty;
                      }
                      final List<Category> _categories =
                          galleryStateSnap.data?.categories ??
                              Const.testCategories;
                      return ListView.builder(
                        padding: EdgeInsets.only(top: 20.0, left: 30.0),
                        itemCount: _categories.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.only(top: 10.0),
                            child: InkWell(
                              onTap: () => _bloc?.addEvent(
                                  PrefferedCategoryEvent(
                                      category: _categories.elementAt(index))),
                              child: Text(
                                _categories.elementAt(index).title,
                                style: TextStyle(
                                    fontSize: 23.0,
                                    color: _categories.elementAt(index) ==
                                                _prefferedCategory &&
                                            _prefferedCategory != Category.empty
                                        ? Colors.yellow
                                        : Colors.white),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ),
          Expanded(
            flex: 75,
            child: NotificationListener(
              onNotification: (SizeChangedLayoutNotification notification) {
                Future.delayed(Duration(milliseconds: 30), () {
                  setState(() {
                    _width = WidgetsBinding.instance?.window.physicalSize.width;
                    debugPrint('$_width');
                  });
                });
                return true;
              },
              child: StreamBuilder<GalleryState>(
                  stream: _bloc?.galleryStateStream,
                  builder: (context, galleryStateSnap) {
                    if (!galleryStateSnap.hasData) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return StreamBuilder<PrefferedImagesState>(
                        stream: _bloc?.prefferedImagesStateStream,
                        builder: (context, prefferedImagesStateSnap) {
                          late List<Image> _prefferedImages;
                          if (prefferedImagesStateSnap.hasData) {
                            _prefferedImages = prefferedImagesStateSnap
                                    .data?.prefferedImages ??
                                [];
                          } else {
                            _prefferedImages =
                                galleryStateSnap.data?.gallery ?? [];
                          }
                          return SizeChangedLayoutNotifier(
                            child: GridView.count(
                              crossAxisCount:
                                  (_width ?? 0) > Const.switchGridPageSize
                                      ? 3
                                      : 2,
                              crossAxisSpacing: 4.0,
                              mainAxisSpacing: 8.0,
                              children: _prefferedImages,
                            ),
                          );
                        });
                  }),
            ),
          ),
        ],
      ),
    );
  }
}
