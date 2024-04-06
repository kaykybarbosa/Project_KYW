part of 'project_bloc.dart';

class ProjectState extends Equatable {
  const ProjectState({required this.allProject});

  final List<Project> allProject;

  @override
  List<Object?> get props => [allProject];

  ProjectState copyWith({
    List<Project>? allProject,
  }) {
    return ProjectState(
      allProject: allProject ?? this.allProject,
    );
  }
}
