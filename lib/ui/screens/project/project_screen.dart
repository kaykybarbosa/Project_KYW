import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/route_manager.dart';
import 'package:kyw_management/app/routers/my_routes.dart';
import 'package:kyw_management/domain/enums/screens.dart';
import 'package:kyw_management/ui/screens/home/widgets/my_sliver_list.dart';
import 'package:kyw_management/ui/screens/project/widgets/my_modal_filter_project.dart';
import 'package:kyw_management/ui/state_management/blocs/project_bloc/project_bloc.dart';
import 'package:kyw_management/ui/widgets/card_project.dart';
import 'package:kyw_management/ui/widgets/home_screen/filter/my_order.dart';
import 'package:kyw_management/ui/widgets/my_search_bar.dart';
import 'package:kyw_management/ui/widgets/my_two_filters.dart';
import 'package:kyw_management/utils/colors.dart';
import 'package:kyw_management/utils/constants.dart';
import 'package:kyw_management/utils/icons.dart';
import 'package:kyw_management/utils/texts.dart';

class ProjectScreen extends StatelessWidget {
  const ProjectScreen({super.key});

  Future<dynamic> myModalBottom(
    BuildContext context,
    Widget child,
  ) async {
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) => child,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProjectBloc, ProjectState>(
      builder: (context, state) {
        var projects = state.allProject;

        return Scaffold(
          body: Column(
            children: <Widget>[
              /// Buscar projetos
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: TConstants.defaultMargin,
                  vertical: 10,
                ),
                child: MySearchBar(
                  hintText: TTexts.hintTextProject,
                  onPressed: () {},
                ),
              ),

              /// Filtros
              MyTwoFilters(
                /// -- Filtrar
                filterOnTap: () => myModalBottom(context, const MyModalFilterProject()),

                /// -- Ordenar
                orderOnTap: () => myModalBottom(
                  context,
                  const MyOrder(currentScreen: Screens.project),
                ),
              ),

              /// Lista de projetos
              Expanded(
                child: MySliverList(
                  childCount: projects.length,
                  builder: (_, index) => Padding(
                    padding: EdgeInsets.only(bottom: index != projects.length - 1 ? 10 : 0),
                    child: CardProject(
                      project: projects[index],
                      onTap: () => Get.toNamed(AppRoutes.chat, parameters: {'id': '$index'}),
                    ),
                  ),
                ),
              ),
            ],
          ),

          /// Adicionar projetos
          floatingActionButton: FloatingActionButton(
            backgroundColor: TColors.primary,
            child: const Icon(TIcons.add),
            onPressed: () => Get.toNamed(AppRoutes.createProject),
          ),
        );
      },
    );
  }
}
