part of 'project_bloc.dart';

class ProjectState extends Equatable {
  ProjectState({
    AllProjectsResponse? allProjects,
    this.status = FormzSubmissionStatus.initial,
  }) : allProjects = allProjects ?? AllProjectsResponse.empty;

  final AllProjectsResponse allProjects;
  final FormzSubmissionStatus status;

  @override
  List<Object?> get props => [allProjects, status];

  ProjectState copyWith({
    AllProjectsResponse? allProjects,
    FormzSubmissionStatus? status,
  }) =>
      ProjectState(
        allProjects: allProjects ?? this.allProjects,
        status: status ?? FormzSubmissionStatus.initial,
      );
}
