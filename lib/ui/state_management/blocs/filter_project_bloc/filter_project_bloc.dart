import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

part 'filter_project_event.dart';
part 'filter_project_state.dart';

const filterProjectInitial = FilterProjectInitial(
  initDate: '',
  finalDate: '',
  createdByMe: false,
  marked: false,
  isInitDate: true,
  isValid: false,
  status: FormzSubmissionStatus.initial,
);

class FilterProjectBloc extends Bloc<FilterProjectEvent, FilterProjectState> {
  FilterProjectBloc() : super(filterProjectInitial) {
    on<InitDateChanged>(_onInitDateChanged);
    on<FinalDateChanged>(_onFinalDateChanged);
    on<CreatedByMeChanged>(_onCreatedByMeChanged);
    on<MarkedChanged>(_onMarkedChanged);
    on<IsInitDateChanged>(_onIsInitDateChanged);
    on<ResetFilterProject>(_onResetBloc);
  }

  void _onInitDateChanged(
    InitDateChanged event,
    Emitter<FilterProjectState> emit,
  ) {
    emit(
      state.copyWith(
        initDate: event.initDate,
        status: FormzSubmissionStatus.initial,
      ),
    );
  }

  void _onFinalDateChanged(
    FinalDateChanged event,
    Emitter<FilterProjectState> emit,
  ) {
    emit(
      state.copyWith(
        finalDate: event.finalDate,
        status: FormzSubmissionStatus.initial,
      ),
    );
  }

  void _onCreatedByMeChanged(
    CreatedByMeChanged event,
    Emitter<FilterProjectState> emit,
  ) {
    emit(state.copyWith(createdByMe: !state.createdByMe));
  }

  void _onMarkedChanged(
    MarkedChanged event,
    Emitter<FilterProjectState> emit,
  ) {
    emit(state.copyWith(marked: !state.marked));
  }

  void _onIsInitDateChanged(
    IsInitDateChanged event,
    Emitter<FilterProjectState> emit,
  ) {
    emit(state.copyWith(isInitDate: !state.isInitDate));
  }

  void _onResetBloc(
    ResetFilterProject event,
    Emitter<FilterProjectState> emit,
  ) {
    emit(filterProjectInitial);
  }
}
