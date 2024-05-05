import 'package:flutter/material.dart';
import 'package:kyw_management/ui/widgets/circular_progress_indicator_mini.dart';

class SubmitButton extends StatelessWidget {
  const SubmitButton({
    super.key,
    required this.label,
    this.isInProgress = false,
    this.style,
    this.onPressed,
  });

  final String label;
  final bool isInProgress;
  final ButtonStyle? style;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) => SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          style: style ?? ElevatedButton.styleFrom(padding: EdgeInsets.zero),
          onPressed: () {
            FocusScope.of(context).unfocus();
            onPressed!();
          },
          child: isInProgress
              ? const Padding(
                  padding: EdgeInsets.symmetric(vertical: 6.0),
                  child: CircularProgressIndicatorMini(),
                )
              : Padding(
                  padding: const EdgeInsets.symmetric(vertical: 14.0),
                  child: Text(label),
                ),
        ),
      );
}
