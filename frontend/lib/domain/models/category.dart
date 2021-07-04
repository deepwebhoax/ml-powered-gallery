import 'package:equatable/equatable.dart';

class Category extends Equatable {
  const Category(this.title);

  final String title;

  static Category get empty => Category('');

  @override
  List<Object> get props => [title];
}
