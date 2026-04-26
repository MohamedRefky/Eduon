import 'dart:io';

import 'package:eduon/core/constants/app_sizes.dart';
import 'package:eduon/core/service/preferences_manager.dart';
import 'package:eduon/features/eduon_ai/data/models/message_ai_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

class MessageBubble extends StatelessWidget {
  final MessageAiModel message;

  const MessageBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    final imagePath = uid != null ? PreferencesManager().getUserImage(uid) : null;

    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: AppSizes.h6,
        horizontal: AppSizes.w10,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: message.isMe
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        children: [
          if (!message.isMe) ...[
            SvgPicture.asset('assets/svg/Ai.svg'),
            Gap(AppSizes.h8),
          ],
          Flexible(
            child: Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.75,
              ),
              padding: EdgeInsets.all(AppSizes.h16),
              decoration: BoxDecoration(
                color: message.isMe ? Theme.of(context).colorScheme.primary : Theme.of(context).cardColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(AppSizes.r24),
                  topRight: Radius.circular(AppSizes.r24),
                  bottomLeft: Radius.circular(
                    message.isMe ? AppSizes.r24 : AppSizes.r2,
                  ),
                  bottomRight: Radius.circular(
                    message.isMe ? AppSizes.r2 : AppSizes.r24,
                  ),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.06),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Text(
                message.text,
                style: TextStyle(
                  fontSize: AppSizes.h15,
                  height: 1.5,
                  color: message.isMe ? Colors.white : Theme.of(context).textTheme.bodyLarge?.color,
                ),
              ),
            ),
          ),
          if (message.isMe) ...[
            Gap(AppSizes.h8),
            CircleAvatar(
              radius: AppSizes.r16,
              backgroundImage: imagePath != null && File(imagePath).existsSync()
                  ? FileImage(File(imagePath))
                  : const AssetImage("assets/images/Avatar.png") as ImageProvider,
            ),
          ],
        ],
      ),
    );
  }
}

