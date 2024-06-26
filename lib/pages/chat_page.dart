import 'package:chat_app/components/chat_bubble.dart';
import 'package:chat_app/components/my_textfield.dart';
import 'package:chat_app/services/auth/auth_service.dart';
import 'package:chat_app/services/chat/chat_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatPage extends StatefulWidget {
  final String reciverUserName;
  final String receiverEmail;
  final String reciverID;

  ChatPage({super.key, required this.receiverEmail, required this.reciverID, required this.reciverUserName});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();
  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

  FocusNode myFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    myFocusNode.addListener(() {
      if (myFocusNode.hasFocus) {
        Future.delayed(const Duration(milliseconds: 500),
              () => scrollDown(),
        );
      }
    });
    
    Future.delayed(
      const Duration(milliseconds: 500),
        ()=> scrollDown(),
    );
    
  }

  final ScrollController _scrollController = ScrollController();
  void scrollDown(){
    _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(seconds: 1),
        curve: Curves.fastOutSlowIn,
    );
  }

  @override
  void dispose() {
    myFocusNode.dispose();
    _messageController.dispose();
    super.dispose();
  }

  void sendMessage() async{
    if (_messageController.text.isNotEmpty){
      await _chatService.sendMessage(widget.reciverID, _messageController.text);
      _messageController.clear();
    }
    
    scrollDown();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.reciverUserName, style: GoogleFonts.dmSerifText(fontSize: 24),),
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Column(
        children: [
          Expanded(
              child: _buildMessageList()
          ),
          _buildUserInput(),
        ],
      ),
    );
  }

  Widget _buildMessageList() {
    String senderID = _authService.getCurrentUser()!.uid;
    return StreamBuilder(
        stream: _chatService.getMessages(widget.reciverID, senderID),
        builder: (context, snapshot){
          if(snapshot.hasError){
            return const Text("Error");
          }

          if(snapshot.connectionState == ConnectionState.waiting){
            return const Text("Loading...");
          }

          return ListView(
            controller: _scrollController,
              children: snapshot.data!.docs.map((doc)=> _buildMessageItem(doc)).toList(),
          );
        },
    );
  }

  Widget _buildMessageItem(DocumentSnapshot doc){
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    bool isCurrentUser = data['senderID'] == _authService.getCurrentUser()!.uid;
    var alignment = isCurrentUser ? Alignment.centerRight : Alignment.centerLeft;
    return Container(
      alignment: alignment,
        child: ChatBubble(isCurrentUser: isCurrentUser, message: data["message"],)
    );
  }

  Widget _buildUserInput(){
    return Padding(
      padding: const EdgeInsets.only(bottom: 23),
      child: Row(
        children: [
          Expanded(child: MyTextfield(
            controller: _messageController,
            hintText: "Type a Message",
            pass: false,
            focusNode: myFocusNode,
          ),
          ),

          Container(
            decoration: BoxDecoration(
              color: Colors.black12,
              shape: BoxShape.circle,
            ),
              margin: EdgeInsets.only(right: 15),
              child: IconButton(onPressed: sendMessage, icon: Icon(Icons.arrow_right_outlined, size: 40,))
          )
        ],
      ),
    );
  }
}
