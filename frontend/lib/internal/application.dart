import 'package:bbbb_cv_app/domain/blocs/gallery_bloc/bloc.dart';
import 'package:bbbb_cv_app/presentation/gallery_page.dart';
import 'package:bbbb_cv_app/internal/const.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Application extends StatefulWidget {
  const Application({Key? key, this.title});

  final String? title;

  @override
  _ApplicationState createState() => _ApplicationState();
}

class _ApplicationState extends State<Application> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: widget.title ?? Const.defaultTitle,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: _getPage(),
    );
  }

  Widget _getPage() {
    return Provider<GalleryBloc>(
      create: (_) => GalleryBloc(),
      child: GalleryPage(title: widget.title),
      dispose: (_, state) => state.dispose(),
    );
  }
}
