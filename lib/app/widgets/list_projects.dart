import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:kyw_management/app/models/project.dart';
import 'package:kyw_management/app/widgets/card_project.dart';

class ListProjects extends StatefulWidget {
  const ListProjects(
      {super.key, required this.projects, required this.showFilterBar});

  final List<Project> projects;
  final Function showFilterBar;

  @override
  State<ListProjects> createState() => _ListProjectsState();
}

class _ListProjectsState extends State<ListProjects> {
  final ScrollController _scrollController = ScrollController();
  int indexC = 0;
  double indexB = 0;

  double scrollOffset = 0.0;

  @override
  void initState() {
    _scrollController.addListener(_scrollListener);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    setState(() {
      // Up
      if (_scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        widget.showFilterBar(false);
      }

      // Down
      if (_scrollController.position.userScrollDirection ==
          ScrollDirection.forward) {
        widget.showFilterBar(true);
      }

      // To disable FilterBar scrolling
      if (_scrollController.position.pixels == 0.0) {
        widget.showFilterBar(true);
      }

      // To disable ListView scrolling
      // if (_scrollController.position.pixels == 0.0 &&
      //     _scrollController.position.userScrollDirection ==
      //         ScrollDirection.forward) {
      //   _scrolled = false;
      // } else if (_scrollController.position.userScrollDirection !=
      //     ScrollDirection.idle) {
      //   _scrolled = true;
      // }
    });
  }

  bool _scrolled = true;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.projects.length,
      controller: _scrollController,
      physics: _scrolled
          ? const AlwaysScrollableScrollPhysics()
          : const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return CardProject(
          project: widget.projects[index],
          onTap: () {},
        );
      },
    );
  }
}
