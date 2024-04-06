import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyNotification extends StatelessWidget {
  const MyNotification(
      {super.key, required String message, required String time})
      : _message = message,
        _time = time;

  final String _message;
  final String _time;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 14.0,
        vertical: 15.0,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        children: [
          Row(
            children: [
              // Message
              Expanded(
                child: Text(
                  _message,
                  style: const TextStyle(fontSize: 18.0),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.justify,
                ),
              )
            ],
          ),

          const SizedBox(height: 10.0),

          // Date and To share
          Row(
            children: [
              Text(
                _time,
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 15.0,
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Icon(
                        CupertinoIcons.arrowshape_turn_up_right_fill,
                        color: Colors.blue[700],
                      ),
                      Text(
                        'Compartilhar',
                        style:
                            TextStyle(color: Colors.blue[700], fontSize: 18.0),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
