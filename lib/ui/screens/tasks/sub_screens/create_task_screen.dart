import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:kyw_management/app/routers/app_pages/app_pages_exports.dart';
import 'package:kyw_management/data/dtos/response/member_of_project_response.dart';
import 'package:kyw_management/data/repositories/task_repository.dart';
import 'package:kyw_management/domain/enums/snack_bar_type.dart';
import 'package:kyw_management/ui/screens/project/widgets/my_text_field_border.dart';
import 'package:kyw_management/ui/state_management/blocs/project_bloc/project_bloc.dart';
import 'package:kyw_management/ui/state_management/cubits/create_task_cubit/create_task_cubit.dart';
import 'package:kyw_management/ui/widgets/expansion_tile/avatar_url_tile.dart';
import 'package:kyw_management/ui/widgets/expansion_tile/my_expansion_child.dart';
import 'package:kyw_management/ui/widgets/expansion_tile/my_expansion_tile.dart';
import 'package:kyw_management/ui/widgets/expansion_tile/my_expansion_title.dart';
import 'package:kyw_management/ui/widgets/my_icon_drag.dart';
import 'package:kyw_management/ui/widgets/submit_button.dart';
import 'package:kyw_management/utils/colors.dart';
import 'package:kyw_management/utils/formaters.dart';
import 'package:kyw_management/utils/icons.dart';
import 'package:kyw_management/utils/input_formatters.dart';
import 'package:kyw_management/utils/snack_bar/snack_bar_custom.dart';

class CreateTaskScreen extends StatelessWidget {
  const CreateTaskScreen({
    super.key,
    required this.projectId,
  });

  final String projectId;

  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (context) => CreateTaskCubit(
          ITaskRepository.instance,
          projectId: projectId,
        ),
        child: BlocListener<CreateTaskCubit, CreateTaskState>(
          listenWhen: (previous, current) => previous.status != current.status,
          listener: (context, state) {
            if (state.status.isFailure) {
              snackBarCustom(
                message: state.errorMessage ?? 'Não foi possível criar a task.',
                type: SnackBarType.failure,
              );
            } else if (state.status.isSuccess) {
              context.read<ProjectBloc>().add(GetAllTasks(projectId));
              Get.back();
              snackBarCustom(title: 'Sucesso.', message: 'Task criada com sucesso.');
            }
          },
          child: Scaffold(
            appBar: AppBar(title: const Text('Criar task')),
            body: const Padding(
              padding: EdgeInsets.symmetric(horizontal: TConstants.defaultMargin),
              child: Column(
                children: <Widget>[
                  /// -- Campos
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          Gap(10),

                          /// Título
                          _Title(),

                          /// Categoria
                          _Category(),

                          Gap(10),

                          /// Data de conclusão
                          _DateOfConclusion(),

                          Gap(20),

                          /// Selecionar membros
                          _SelectMembers(),

                          Gap(40),

                          /// Descrição
                          _Description(),

                          Gap(10),
                        ],
                      ),
                    ),
                  ),

                  /// -- Criar task btn
                  _SubmitBtn(),
                ],
              ),
            ),
          ),
        ),
      );
}

class _Title extends StatelessWidget {
  const _Title();

  @override
  Widget build(BuildContext context) => BlocBuilder<CreateTaskCubit, CreateTaskState>(
        buildWhen: (previous, current) => previous.title.value != current.title.value,
        builder: (context, state) => MyTextFieldBorder(
          text: 'Título',
          placeHolder: 'Insira o título',
          errorText: state.title.displayError,
          onChanged: (value) => context.read<CreateTaskCubit>().titleChanged(value),
        ),
      );
}

class _Category extends StatefulWidget {
  const _Category();

  @override
  State<_Category> createState() => _CategoryState();
}

class _CategoryState extends State<_Category> {
  late final ExpansionTileController _controller;

  void _categoryOnTap(String category) {
    _controller.collapse();
    context.read<CreateTaskCubit>().categoryChanged(category);
  }

  @override
  void initState() {
    super.initState();
    _controller = ExpansionTileController();
  }

  @override
  Widget build(BuildContext context) => BlocBuilder<CreateTaskCubit, CreateTaskState>(
        buildWhen: (previous, current) => previous.category.value != current.category.value,
        builder: (context, state) {
          final categoryValue = state.category.value;
          final categories = state.categories;

          return MyExpansionTile.border(
            controller: _controller,
            title: 'Categoria',
            placeHolder: MyExpansionTitle(categoryValue.isNotEmpty ? categoryValue : 'Selecione uma categoria',
                style: categoryValue.isNotEmpty
                    ? Theme.of(context).textTheme.displayLarge
                    : Theme.of(context).inputDecorationTheme.hintStyle),
            children: state.categories.map((category) {
              final isFirst = categories.first == category;
              final isLast = categories.last == category;

              return MyExpansionChild(
                isFirst: isFirst,
                isLast: isLast,
                child: ListTile(
                  contentPadding: const EdgeInsets.only(left: 16, right: 16),
                  title: Text(category),
                  onTap: () => _categoryOnTap(category),
                ),
              );
            }).toList(),
          );
        },
      );
}

class _DateOfConclusion extends StatefulWidget {
  const _DateOfConclusion();

  @override
  State<_DateOfConclusion> createState() => _DateOfConclusionState();
}

class _DateOfConclusionState extends State<_DateOfConclusion> {
  late final TextEditingController _controller;

  void _dateChanged(DateTime? date) {
    if (date != null) {
      final value = Formatters.formatDate(date);

      context.read<CreateTaskCubit>().dateOfConclusionChanged(value);

      _controller.text = value;
    }
  }

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateTaskCubit, CreateTaskState>(
      buildWhen: (previous, current) => previous.dateOfConclusion.value != current.dateOfConclusion.value,
      builder: (context, state) {
        Future<void> showCalendar(BuildContext context) async {
          final now = DateTime.now();
          final firstDate = DateTime(now.year - 2, now.month, now.day);
          final lastDate = DateTime(now.year + 2, now.month, now.day);

          final dateSelected = await showDatePicker(
            context: context,
            initialDate: now,
            firstDate: firstDate,
            lastDate: lastDate,
            barrierColor: TColors.base900.withOpacity(.4),
          );

          _dateChanged(dateSelected);
        }

        return MyTextFieldBorder(
          text: 'Data de conclusão',
          placeHolder: 'xx/xx/xxxx',
          controller: _controller,
          inputFormatter: InputFormatters.date,
          errorText: state.dateOfConclusion.displayError,
          onChanged: (value) => context.read<CreateTaskCubit>().dateOfConclusionChanged(value),
          suffix: InkWell(
            onTap: () => showCalendar(context),
            child: const Icon(
              TIcons.calendar,
              size: TConstants.iconMd - 2,
            ),
          ),
        );
      },
    );
  }
}

class _SelectMembers extends StatefulWidget {
  const _SelectMembers();

  @override
  State<_SelectMembers> createState() => _SelectMembersState();
}

class _SelectMembersState extends State<_SelectMembers> {
  List<MemberOfProjectResponse> get _members => context.read<ProjectBloc>().state.members;

  void _addMembersToCubit() => context.read<CreateTaskCubit>().addMembersOfProject(_members);

  @override
  void initState() {
    super.initState();

    _addMembersToCubit();
  }

  @override
  Widget build(BuildContext context) => BlocBuilder<CreateTaskCubit, CreateTaskState>(
        buildWhen: (previous, current) => previous.attributedTo != current.attributedTo,
        builder: (context, state) {
          final members = state.members;

          return Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: TColors.base900.withOpacity(.1),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: MyExpansionTile.border(
              showBorder: false,
              borderColor: TColors.base100,
              backgroundColor: TColors.primary,
              icon: const Icon(
                TIcons.arrowUpIOS,
                color: TColors.base100,
              ),
              placeHolder: const Text(
                'Selecionar membros',
                style: TextStyle(
                  color: TColors.base100,
                ),
              ),
              children: state.members.map(
                (member) {
                  final isFirst = members.first == member;
                  final isLast = members.last == member;

                  return MyExpansionChild(
                    isFirst: isFirst,
                    isLast: isLast,
                    child: ListTile(
                      contentPadding: const EdgeInsets.only(left: 16, right: 5),
                      leading: AvatarUrlTile(avatarUrl: member.avatarUrlLocal),
                      title: Text(
                        member.isCurrentUser ? 'Você' : member.nickname,
                        maxLines: 1,
                        style: const TextStyle(fontWeight: FontWeight.w600),
                        overflow: TextOverflow.ellipsis,
                      ),
                      trailing: Checkbox(
                        value: state.memberIsSelected(member),
                        onChanged: (isSelected) {
                          final createContext = context.read<CreateTaskCubit>();

                          if (isSelected!) {
                            createContext.addAttributedTo(member);
                          } else {
                            createContext.removeAttributedTo(member);
                          }
                        },
                      ),
                    ),
                  );
                },
              ).toList(),
            ),
          );
        },
      );
}

class _Description extends StatefulWidget {
  const _Description();

  @override
  State<_Description> createState() => _DescriptionState();
}

class _DescriptionState extends State<_Description> {
  final valueMax = 10;
  final valueMin = 3;
  int maxLines = 3;
  final border = const BorderSide(color: TColors.base150);

  void _descriptionStyleChanged(bool isBold) {
    final createContext = context.read<CreateTaskCubit>();
    isBold ? createContext.boldDescriptionChanged() : createContext.italicDescriptionChanged();
  }

  void _setHeightInput(double? value) {
    setState(() {
      if (value != null) {
        if (value > 0 && maxLines != valueMax) {
          maxLines += 1;
        } else if (value < 0 && maxLines != valueMin) {
          maxLines -= 1;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) => BlocBuilder<CreateTaskCubit, CreateTaskState>(
        buildWhen: (previous, current) =>
            previous.description != current.description || previous.descriptionStyles != current.descriptionStyles,
        builder: (context, state) {
          TextStyle style = const TextStyle();
          bool isBold = false;
          bool isItalic = false;

          if (state.descriptionStyles.contains(TaskDescriptionStyle.bold)) {
            style = style.copyWith(fontWeight: FontWeight.bold);
            isBold = true;
          }

          if (state.descriptionStyles.contains(TaskDescriptionStyle.italic)) {
            style = style.copyWith(fontStyle: FontStyle.italic);
            isItalic = true;
          }

          final List<Map<String, dynamic>> icons = [
            {
              'icon': TIcons.bold,
              'toolTip': 'Negrito',
              'isSelected': isBold,
              'onTap': () => _descriptionStyleChanged(true),
            },
            {
              'icon': TIcons.italic,
              'toolTip': 'Itálico',
              'isSelected': isItalic,
              'onTap': () => _descriptionStyleChanged(false),
            },
            {
              'icon': TIcons.attachment,
              'toolTip': 'Anexos',
              'isSelected': false,
              'onTap': () {},
            }
          ];

          return Column(
            children: <Widget>[
              /// Ícones
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: TColors.base150),
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(TConstants.cardRadiusXs)),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: TConstants.defaultMargin,
                  ),
                  child: Row(
                    children: icons
                        .map(
                          (icon) => IconButton(
                            highlightColor: TColors.base120,
                            icon: Icon(
                              icon['icon'],
                              color: icon['isSelected'] ? TColors.primary : TColors.base900,
                            ),
                            tooltip: icon['toolTip'],
                            onPressed: icon['onTap'],
                          ),
                        )
                        .toList(),
                  ),
                ),
              ),

              /// Descrição
              AnimatedContainer(
                duration: 200.milliseconds,
                decoration: BoxDecoration(
                  border: Border(left: border, right: border, bottom: border),
                  borderRadius: const BorderRadius.vertical(bottom: Radius.circular(TConstants.cardRadiusXs)),
                ),
                child: TextFormField(
                  style: style,
                  maxLines: maxLines,
                  decoration: const InputDecoration(
                    hintText: 'Descrição',
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.vertical(bottom: Radius.circular(TConstants.cardRadiusXs)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.vertical(bottom: Radius.circular(TConstants.cardRadiusXs)),
                    ),
                  ),
                  onChanged: (value) => context.read<CreateTaskCubit>().descriptionChanged(value),
                ),
              ),

              /// Ícone
              MyIconDrag(
                isDrag: maxLines == valueMax,
                onVerticalDragUpdate: _setHeightInput,
              ),
            ],
          );
        },
      );
}

class _SubmitBtn extends StatelessWidget {
  const _SubmitBtn();

  @override
  Widget build(BuildContext context) => BlocBuilder<CreateTaskCubit, CreateTaskState>(
        buildWhen: (previous, current) => previous.status != current.status || previous.isValid != current.isValid,
        builder: (context, state) => Padding(
          padding: const EdgeInsets.only(top: 5, bottom: 10),
          child: SubmitButton(
            label: 'Criar task',
            onPressed: state.isValid ? () => context.read<CreateTaskCubit>().submitForm() : null,
            isInProgress: state.status.isInProgress,
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.zero,
              backgroundColor: TColors.success,
            ),
          ),
        ),
      );
}
