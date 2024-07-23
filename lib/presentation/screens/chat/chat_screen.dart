import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:provider/provider.dart';
import 'package:yes_no_app/domain/entities/message.dart';
import 'package:yes_no_app/presentation/providers/chat_provider.dart';
import 'package:yes_no_app/presentation/widgets/chat/her_message_bubble.dart';
import 'package:yes_no_app/presentation/widgets/chat/my_message_bubble.dart';
import 'package:yes_no_app/presentation/widgets/shared/message_field_box.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(4.0),
          child: GestureDetector(
            onTap: (){
              showDialog(
                context: context, 
                builder: (context) => Dialog(
                  child: SizedBox(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height/2,
                    child: PhotoView(
                       imageProvider: const NetworkImage(
                          'https://styles.redditmedia.com/t5_5dzyeq/styles/communityIcon_b6mcwe8t3sy81.png'),
                    ),
                  ),
                )
              );
            },
          child: const CircleAvatar(
            backgroundImage: NetworkImage(
                'https://styles.redditmedia.com/t5_5dzyeq/styles/communityIcon_b6mcwe8t3sy81.png'),
            ),
          ),
        ),
        title: const Text('My Love ❤'),
        centerTitle: false,
      ),
      body: _ChatView(),
    );
  }
}

class _ChatView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final chatProvider = context.watch<ChatProvider>();

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            Expanded(
                child: ListView.builder(
                  controller: chatProvider.chatScrollController,
                    itemCount: chatProvider.messageList.length,
                    itemBuilder: (context, index) {
                      final message = chatProvider.messageList[index];
                      return (message.fromWho == FromWho.hers)
                        ? HerMessageBubble( message : message)
                        : MyMessageBubble( message : message);
                    })),
            MessageFieldBox(
              onValue: chatProvider.seendMessage,
            )
          ],
        ),
      ),
    );
  }
}
