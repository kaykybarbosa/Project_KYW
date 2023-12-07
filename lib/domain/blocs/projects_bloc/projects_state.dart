import 'package:equatable/equatable.dart';
import 'package:kyw_management/app/models/project.dart';

// ignore: must_be_immutable
class ProjectsState extends Equatable {
  const ProjectsState({this.allProject = const <Project>[]});

  final List<Project> allProject;

  @override
  List<Object?> get props => [allProject];
}
