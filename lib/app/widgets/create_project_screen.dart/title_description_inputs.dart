import 'package:flutter/cupertino.dart';
import 'package:kyw_management/app/validation/input_validator.dart';
import 'package:kyw_management/app/widgets/circle_image.dart';
import 'package:kyw_management/app/widgets/create_project_screen.dart/criation_input.dart';

class TitleAndDescriptionInputs extends StatelessWidget {
  const TitleAndDescriptionInputs({
    super.key,
    required this.titleController,
    required this.descriptionController,
  });

  final TextEditingController titleController;
  final TextEditingController descriptionController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Select the image text
        const Text(
          'Selecione uma imagem pra o projeto',
          style: TextStyle(
            fontSize: 18.0,
            color: CupertinoColors.systemGrey,
          ),
        ),

        const SizedBox(height: 15.0),

        // Circle the image
        CircleImage(onTap: () {}),

        const SizedBox(height: 30.0),

        const SizedBox(height: 30.0),
        // Title with TitleInput
        MyCreationInput(
          text: 'Título do Projeto*',
          placeHolder: 'Título',
          controller: titleController,
          textInputType: TextInputType.text,
          maxLength: 30,
          validation: (title) {
            return InputValidator.validateTitle(title: title);
          },
        ),

        const SizedBox(height: 30.0),

        // Description with DescriptionInput
        MyCreationInput(
          text: 'Descrição do Projeto*',
          placeHolder: 'Descrição',
          controller: descriptionController,
          heightPrefix: 115.8,
          maxLine: 5,
          maxLength: 100,
          textInputType: TextInputType.multiline,
          validation: (description) {
            return InputValidator.validateDescription(description: description);
          },
        ),
      ],
    );
  }
}
