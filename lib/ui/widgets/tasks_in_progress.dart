import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:kyw_management/ui/widgets/skelton_indicator.dart';
import 'package:kyw_management/utils/constants.dart';

class TasksInProgress extends StatelessWidget {
  const TasksInProgress({super.key});

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: TConstants.defaultMargin),
        child: Column(
          children: <Widget>[
            const Gap(10),

            /// Buscar
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                SkeltonIndicator(
                  width: Get.width * .8,
                  height: 40,
                ),
                const SkeltonIndicator(
                  width: 40,
                  height: 40,
                ),
              ],
            ),

            const Gap(15),

            /// Filtros
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                SkeltonIndicator(
                  width: 100,
                  height: 35,
                ),
                SkeltonIndicator(
                  width: 100,
                  height: 35,
                ),
                SkeltonIndicator(
                  width: 100,
                  height: 35,
                ),
              ],
            ),

            const Gap(10),

            /// Tasks
            Column(
              children: List.generate(
                3,
                (index) => const Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 5,
                  ),
                  child: SkeltonIndicator(
                    width: double.infinity,
                    height: 90,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
}
