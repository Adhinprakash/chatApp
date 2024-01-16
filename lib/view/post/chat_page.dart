import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_demo/view/auth/auth_services.dart';
import 'package:firebase_demo/view/chatservices/chat_services.dart';
import 'package:firebase_demo/widgets/chat_bubble.dart';
import 'package:firebase_demo/widgets/my_textfield.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  final String receiverEmail;
  final String receiverID;
  ChatPage({super.key, required this.receiverEmail, required this.receiverID});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final Chatservices chatservices = Chatservices();

  final Authservices authservices = Authservices();
  FocusNode myfocus=FocusNode();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    myfocus.addListener(() {
      if(myfocus.hasFocus){
        Future.delayed(const Duration(microseconds: 500),()=>scrolldown());
      }
    });

    Future.delayed(const Duration(milliseconds: 500),()=>scrolldown());
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    myfocus.dispose();
    _messagecontroller.dispose();
  }
final ScrollController _scrollController=ScrollController();

  scrolldown(){
_scrollController.animateTo(_scrollController.position.maxScrollExtent, duration: const Duration(seconds: 1), curve: Curves.fastOutSlowIn);
  }

  final TextEditingController _messagecontroller = TextEditingController();

  void sendmessage() async {
    if (_messagecontroller.text.isNotEmpty) {
      await chatservices.sendmessage(
          widget.receiverID, _messagecontroller.text.toString());
      _messagecontroller.clear();
    }
    scrolldown();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
      backgroundColor: Theme.of(context).colorScheme.background,
        title: Text(widget.receiverEmail),
      ),
      body: Column(
        children: [Expanded(child: _buildMessageList()), _buildUserInput()],
      ),
    );
  }

  Widget _buildMessageList() {
    String senderID = authservices.getcurrentuser()!.uid;

    return StreamBuilder(
        stream: chatservices.getMessages(widget.receiverID, senderID),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text("Error");
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text("Loading");
          }

          return ListView(
            controller: _scrollController,
            children: snapshot.data!.docs
                .map((doc) => _buildMessageItems(doc))
                .toList(),
          );
        });
  }

  Widget _buildMessageItems(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    bool iscurrentUser = data['senderID'] == authservices.getcurrentuser()!.uid;
    var alignment =
        iscurrentUser ? Alignment.centerRight : Alignment.centerLeft;
    return Container(
      alignment: alignment,
      child: Column(
        crossAxisAlignment: iscurrentUser ?CrossAxisAlignment.end :CrossAxisAlignment.start,
        children: [
          ChatBubble(message: data['message'], iscurrentUser: iscurrentUser),
        ],
      ),
    );
  }

  Widget _buildUserInput() {
    return Row(
      children: [
        Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 14),
              child: Mytextfield(
                focusNode: myfocus,
                  hintText: "type a message", controller: _messagecontroller),
            )),
        Container(
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.green
            
          ),
          margin: const EdgeInsets.only(right: 25),
          child: IconButton(onPressed: sendmessage, icon: const Icon(Icons.send,color: Colors.white,)))
      ],
    );
  }
}
