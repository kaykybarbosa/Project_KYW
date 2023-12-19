import 'package:equatable/equatable.dart';
import 'package:kyw_management/app/models/project.dart';

class ProjectState extends Equatable {
  const ProjectState({this.allProject = const <Project>[]});

  final List<Project> allProject;

  @override
  List<Object?> get props => [allProject];
}
