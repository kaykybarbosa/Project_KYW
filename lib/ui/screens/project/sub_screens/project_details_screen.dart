import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:kyw_management/app/routers/app_pages/app_pages_exports.dart';
import 'package:kyw_management/ui/state_management/blocs/project_bloc/project_bloc.dart';
import 'package:kyw_management/utils/colors.dart';
import 'package:kyw_management/utils/icons.dart';

class ProjectDetailsScreen extends StatelessWidget {
  const ProjectDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProjectBloc, ProjectState>(
      builder: (context, state) {
        return Scaffold(
            body: CustomScrollView(
          slivers: <Widget>[
            SliverPersistentHeader(
              pinned: true,
              delegate: _SliverPersistentDelegate(),
            ),
            SliverToBoxAdapter(
              child: Column(
                children: <Widget>[
                  Text(
                    state.detailProject.name,
                    style: const TextStyle(fontSize: TConstants.fontSizeLg + 4),
                  ),
                  const SizedBox(height: 200),
                  const SizedBox(height: 200),
                  const SizedBox(height: 200),
                  const SizedBox(height: 200),
                  const SizedBox(height: 200),
                  const SizedBox(height: 200),
                  const SizedBox(height: 200),
                ],
              ),
            )
          ],
        ));
      },
    );
  }
}

class _SliverPersistentDelegate extends SliverPersistentHeaderDelegate {
  final maxHeaderHeight = 180.0;
  final minHeaderHeight = kToolbarHeight + 35.0;
  final maxImageSize = 130.0;
  final minImageSize = TConstants.imageCircular;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    final topPositioned = MediaQuery.of(context).viewPadding.top + 5;
    final percent = shrinkOffset / (maxHeaderHeight - 35);
    final percent2 = shrinkOffset / (maxHeaderHeight - 35);
    final currentImageSize = (maxImageSize * (1 - percent)).clamp(
      minImageSize,
      maxImageSize,
    );
    final currentImagePositioned = ((Get.width / 2 - 65) * (1 - percent)).clamp(
      minImageSize,
      maxImageSize,
    );
    final iconColor = percent2 * 2 < 1 ? TColors.secondary : TColors.base100;

    return BlocBuilder<ProjectBloc, ProjectState>(
      builder: (context, state) {
        final image = state.detailProject.imageUrlLocal;

        return AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle(statusBarIconBrightness: percent2 * 2 < 1 ? Brightness.dark : Brightness.light),
          child: Container(
            color: Theme.of(context).scaffoldBackgroundColor,
            child: Container(
              color: Theme.of(context).appBarTheme.backgroundColor!.withOpacity(percent2 * 2 < 1 ? percent2 * 2 : 1),
              child: Stack(
                children: <Widget>[
                  /// Nome do projeto
                  Positioned(
                    top: topPositioned + 10,
                    left: currentImagePositioned + 55,
                    child: Text(
                      state.detailProject.name,
                      style: TextStyle(
                        fontSize: TConstants.fontSizeLg,
                        color: TColors.base100.withOpacity(percent2 * 2 < 1 ? percent2 * 2 : 1),
                      ),
                    ),
                  ),

                  /// Voltar
                  Positioned(
                    left: 0,
                    top: topPositioned + 5,
                    child: BackButton(color: iconColor),
                  ),

                  /// Opções
                  Positioned(
                    right: 0,
                    top: topPositioned,
                    child: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        TIcons.more,
                        color: iconColor,
                      ),
                    ),
                  ),

                  /// Imagem
                  Positioned(
                    left: currentImagePositioned,
                    top: topPositioned,
                    bottom: 0,
                    child: image != null
                        ? Hero(
                            tag: 'details_project',
                            child: Container(
                              width: currentImageSize,
                              decoration: BoxDecoration(
                                color: TColors.base150,
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: CachedNetworkImageProvider(
                                    image,
                                    maxWidth: 157,
                                    maxHeight: 217,
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          )
                        : Hero(
                            tag: 'details_project',
                            child: Container(
                              width: currentImageSize,
                              decoration: const BoxDecoration(
                                color: TColors.base200,
                                shape: BoxShape.circle,
                              ),
                              child: Image.asset(
                                'assets/group.png',
                                width: currentImageSize,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  double get maxExtent => maxHeaderHeight;

  @override
  double get minExtent => minHeaderHeight;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) => false;
}
