part of 'category_bloc.dart';

abstract class CategoryEvent extends Equatable {
  const CategoryEvent();

  @override
  List<Object> get props => [];
}

class AddCategory extends CategoryEvent {
  final Category category;
  final Box box;
  AddCategory({required this.category, required this.box});
}

class testevent extends CategoryEvent {}
