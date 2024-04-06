import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../state_management/cubits/add_task_cubit/add_task_cubit.dart';

class DescriptionInputTask extends StatelessWidget {
  const DescriptionInputTask({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddTaskCubit, AddTaskState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Descrição',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Theme.of(context).primaryColor,
              ),
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: Column(
                children: [
                  // Icons bar
                  const _IconsBar(),
                  // Text input
                  _TextInput(
                    state: state,
                  ),
                  const _ArrowDown(),
                ],
              ),
              // Message error
              subtitle: _MessageError(state: state),
            ),
          ],
        );
      },
    );
  }
}

class _MessageError extends StatelessWidget {
  const _MessageError({required AddTaskState state}) : _state = state;

  final AddTaskState _state;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 14, top: 5, bottom: 2),
      child: Visibility(
        visible: _state.description.displayError != null,
        child: Text(
          _state.description.displayError != null ? 'Este campo é obrigátorio!' : '',
          style: const TextStyle(
            fontSize: 12,
            color: Colors.redAccent,
          ),
        ),
      ),
    );
  }
}

class _ArrowDown extends StatelessWidget {
  const _ArrowDown();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 25),
        decoration: BoxDecoration(
          color: Colors.blue[700],
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(5.0),
            bottomRight: Radius.circular(5.0),
          ),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              FontAwesomeIcons.anglesDown,
              size: 18.0,
              color: Colors.white,
            )
          ],
        ),
      ),
      onVerticalDragUpdate: (onLong) => context.read<AddTaskCubit>().arrowDownChanged(onLong.primaryDelta),
    );
  }
}

class _TextInput extends StatelessWidget {
  const _TextInput({required AddTaskState state}) : _state = state;

  final AddTaskState _state;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddTaskCubit, AddTaskState>(
      buildWhen: (previous, current) => previous.description != current.description,
      builder: (context, state) {
        return TextFormField(
          maxLines: _state.heightDescription,
          initialValue: state.description.value,
          decoration: const InputDecoration(
            hintText: 'Insira um descrição',
            fillColor: Colors.transparent,
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
              borderRadius: BorderRadius.only(
                topLeft: Radius.zero,
                topRight: Radius.zero,
                bottomLeft: Radius.circular(5),
                bottomRight: Radius.circular(5),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(5),
                bottomRight: Radius.circular(5),
              ),
            ),
          ),
          onChanged: (value) => context.read<AddTaskCubit>().descriptionChanged(value),
        );
      },
    );
  }
}

class _IconsBar extends StatelessWidget {
  const _IconsBar();

  @override
  Widget build(BuildContext context) {
    var border = const BorderSide(color: Colors.grey);
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(5),
          topRight: Radius.circular(5),
          bottomLeft: Radius.zero,
          bottomRight: Radius.zero,
        ),
        border: Border(left: border, top: border, right: border),
      ),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.format_bold),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.format_italic),
            onPressed: () {},
          ),
          IconButton(
            icon: Transform.rotate(
              angle: 0.5,
              child: const Icon(Icons.attach_file_rounded),
            ),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
