import 'package:equatable/equatable.dart';
import 'package:kyw_management/app/models/project.dart';

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
