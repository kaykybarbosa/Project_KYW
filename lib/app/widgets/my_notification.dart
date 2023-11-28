import 'package:flutter/cupertino.dart';

class MyNotification extends StatelessWidget {
  const MyNotification({super.key});

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
          const Row(
            children: [
              // Message
              Expanded(
                child: Text(
                  'Existem muitas variações de passagens de Lorem Ipsum disponíveis, mas a maioria sofreu alterações de alguma forma de tomar atitudes',
                  style: TextStyle(fontSize: 20.0),
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
              const Text(
                '1 de nov de 2023 as 10:50',
                style: TextStyle(
                  color: CupertinoColors.systemGrey,
                  fontSize: 15.0,
                ),
              ),
              Expanded(
                child: GestureDetector(
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Icon(
                        CupertinoIcons.arrowshape_turn_up_right_fill,
                        color: CupertinoColors.link,
                      ),
                      Text(
                        'Compartilhar',
                        style: TextStyle(
                            color: CupertinoColors.link, fontSize: 18.0),
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
