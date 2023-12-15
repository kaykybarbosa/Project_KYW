import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kyw_management/domain/models/my_category.dart';

part 'filter_task_event.dart';
part 'filter_task_state.dart';

const List<MyCategory> categories = [
  MyCategory(
    id: '1',
    name: 'Tarefa',
    isCheck: false,
  ),
  MyCategory(
    id: '2',
    name: 'Estudo',
    isCheck: false,
  ),
  MyCategory(
    id: '3',
    name: 'Trabalho',
    isCheck: false,
  ),
  MyCategory(
    id: '4',
    name: 'Outros',
    isCheck: false,
  ),
];

const filterTaskInitial = FilterTaskState(
  pending: false,
  complete: false,
  incomplete: false,
  showMyCategories: false,
  categories: categories,
);

class FilterTaskBloc extends Bloc<FilterTaskEvent, FilterTaskState> {
  FilterTaskBloc() : super(filterTaskInitial) {
    on<PendingChanged>((event, emit) {
      emit(state.copyWith(pending: !state.pending));
    });
    on<CompleteChanged>((event, emit) {
      emit(state.copyWith(complete: !state.complete));
    });
    on<IncompleteChanged>((event, emit) {
      emit(state.copyWith(incomplete: !state.incomplete));
    });
    on<ShowMyCategoriesChanged>((event, emit) {
      emit(state.copyWith(showMyCategories: !state.showMyCategories));
    });
    on<ResetFilterTask>((event, emit) {
      emit(filterTaskInitial);
    });
    on<AddCategory>(_onAddCategory);
    on<UpdateCategory>(_onUpdateCategory);
  }

  void _onAddCategory(AddCategory event, Emitter<FilterTaskState> emit) {
    var categories = state.categories;

    categories = List.from(categories)..add(event.category);

    emit(state.copyWith(categories: categories));
  }

  void _onUpdateCategory(UpdateCategory event, Emitter<FilterTaskState> emit) {
    var categories = state.categories;
    var category = event.category;

    var indexTask = categories.indexOf(category);
    category = category.copyWith(isCheck: !category.isCheck);

    categories = List.from(categories)
      ..remove(event.category)
      ..insert(indexTask, category);

    emit(state.copyWith(categories: categories));
  }
}
