// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'filter_project_cubit.dart';

class FilterProjectState extends Equatable {
  const FilterProjectState({
    required this.initDate,
    required this.finalDate,
    required this.createdByMe,
    required this.marked,
    required this.isInitDate,
    required this.isValid,
    required this.status,
  });

  final DateModel initDate;
  final DateModel finalDate;
  final bool createdByMe;
  final bool marked;
  final bool isInitDate;
  final bool isValid;
  final FormzSubmissionStatus status;

  @override
  List<Object> get props => [
        initDate,
        finalDate,
        createdByMe,
        marked,
        isInitDate,
        isValid,
        status,
      ];

  FilterProjectState copyWith({
    DateModel? initDate,
    DateModel? finalDate,
    bool? createdByMe,
    bool? marked,
    bool? isInitDate,
    bool? isValid,
    FormzSubmissionStatus? status,
  }) {
    return FilterProjectState(
      initDate: initDate ?? this.initDate,
      finalDate: finalDate ?? this.finalDate,
      createdByMe: createdByMe ?? this.createdByMe,
      marked: marked ?? this.marked,
      isInitDate: isInitDate ?? this.isInitDate,
      isValid: isValid ?? this.isValid,
      status: status ?? this.status,
    );
  }
}

final class FilterProjectInitial extends FilterProjectState {
  const FilterProjectInitial({
    required super.initDate,
    required super.finalDate,
    required super.createdByMe,
    required super.marked,
    required super.isInitDate,
    required super.isValid,
    required super.status,
  });
}
