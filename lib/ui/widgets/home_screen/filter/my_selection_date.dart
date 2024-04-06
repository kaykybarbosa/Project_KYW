import 'package:flutter/material.dart';

class MySelectionDate extends StatelessWidget {
  const MySelectionDate({
    super.key,
    required this.title,
    required this.showCalendar,
    required this.hintText,
  });

  final String title;
  final Function showCalendar;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _dateText(text: title),
        GestureDetector(
          onTap: () => showCalendar(),
          child: SizedBox(
            width: 150,
            child: Card(
              margin: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
                side: const BorderSide(color: Color(0xFF757575)),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 12,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      hintText,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[600],
                      ),
                    ),
                    Icon(
                      Icons.calendar_today_rounded,
                      size: 24,
                      color: Colors.grey[700],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

Text _dateText({required String text}) {
  return Text(
    text,
    style: TextStyle(
      fontSize: 18,
      color: Colors.grey[600],
    ),
  );
}
