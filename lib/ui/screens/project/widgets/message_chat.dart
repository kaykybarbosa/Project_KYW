import 'package:flutter/material.dart';
import 'package:kyw_management/app/routers/app_pages/app_pages_exports.dart';
import 'package:kyw_management/utils/colors.dart';
import 'package:kyw_management/utils/constants.dart';

import '../../../../domain/models/message_model.dart';

class MessageChat extends StatelessWidget {
  const MessageChat({super.key, required this.message, required this.hasNip});

  final MessageModel message;
  final bool hasNip;
  static const _kRadius = Radius.circular(10);

  @override
  Widget build(BuildContext context) => Container(
        alignment: message.isSender ? Alignment.centerRight : Alignment.centerLeft,
        margin: EdgeInsets.only(
          left: message.isSender ? 75 : 8,
          top: 3,
          right: message.isSender ? 8 : 75,
        ),
        child: Container(
          padding: EdgeInsets.only(
            top: 7,
            bottom: 7,
            left: message.isSender ? 10 : 15,
            right: message.isSender ? 15 : 10,
          ),
          decoration: BoxDecoration(
            color: TColors.chatBackground,
            border: Border.all(color: TColors.base200),
            borderRadius: BorderRadius.only(
              topLeft: hasNip ? (message.isSender ? _kRadius : Radius.zero) : _kRadius,
              topRight: hasNip ? (message.isSender ? Radius.zero : _kRadius) : _kRadius,
              bottomLeft: _kRadius,
              bottomRight: _kRadius,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              /// Usuário
              Visibility(
                visible: !message.isSender,
                child: Text(
                  message.getSender.nickname,
                  style: const TextStyle(
                    fontSize: TConstants.fontSizeMd,
                  ),
                ),
              ),

              /// Messagem
              Stack(
                children: <Widget>[
                  /// -- Conteúdo
                  Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Text(
                      '${message.content}         ',
                      textAlign: TextAlign.justify,
                      style: const TextStyle(fontSize: TConstants.fontSizeMd),
                    ),
                  ),

                  /// -- Horário
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Text(
                      message.hourSentIn,
                      style: const TextStyle(
                        color: TColors.timeColor,
                        fontSize: TConstants.fontSizeSm - 2,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
}
