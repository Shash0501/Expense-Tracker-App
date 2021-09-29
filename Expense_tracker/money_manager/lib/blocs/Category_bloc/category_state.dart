part of 'category_bloc.dart';

abstract class CategoryState extends Equatable {
  const CategoryState();

  @override
  List<Object> get props => [];
}

class CategoryInitial extends CategoryState {}

class CategoryTabLoaded extends CategoryState implements Equatable {
  final List<TransactionModel> transactions;
  CategoryTabLoaded({required this.transactions});
  @override
  List<Object> get props => [transactions];
}
