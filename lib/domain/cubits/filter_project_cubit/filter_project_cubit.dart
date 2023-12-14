import 'package:equatable/equatable.dart';
import 'package:kyw_management/domain/blocs/blocs_export.dart';
import 'package:kyw_management/domain/models/date_model.dart';

part 'filter_project_state.dart';

class FilterProjectCubit extends Cubit<FilterProjectState> {
  FilterProjectCubit()
      : super(
          const FilterProjectInitial(
            initDate: DateModel.pure(),
            finalDate: DateModel.pure(),
            createdByMe: false,
            marked: false,
            isInitDate: true,
            isValid: false,
            status: FormzSubmissionStatus.initial,
          ),
        );

  void initDateChanged(String value) {
    final initDate = DateModel.dirty(value);

    emit(
      state.copyWith(
        initDate: initDate,
        isValid: Formz.validate([initDate, state.finalDate]),
        status: FormzSubmissionStatus.initial,
      ),
    );
  }

  void finalDateChanged(String value) {
    final finalDate = DateModel.dirty(value);

    emit(
      state.copyWith(
        finalDate: finalDate,
        isValid: Formz.validate([state.initDate, finalDate]),
        status: FormzSubmissionStatus.initial,
      ),
    );
  }

  void createdByMeChanged() {
    final createdByMe = state.createdByMe;

    emit(state.copyWith(createdByMe: !createdByMe));
  }

  void markedChanged() {
    final marked = state.marked;

    emit(state.copyWith(marked: !marked));
  }

  void isInitDateChanged() {
    final isInitDate = state.isInitDate;

    emit(state.copyWith(isInitDate: !isInitDate));
  }
}
