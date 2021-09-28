import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:money_manager/models/category_model.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  // var box = Hive.box<Category>('category');
  CategoryBloc() : super(CategoryInitial()) {
    on<CategoryEvent>((event, emit) {
      // TODO: implement event handler
      if (event is AddCategory) {
        event.box.add(event.category);
        emit(state);
      } else if (event is testevent) {
        print("hello world");
      }
    });
  }
}
