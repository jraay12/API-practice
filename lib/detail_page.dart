import 'package:flutter/material.dart';

class Details extends StatelessWidget {
  final dynamic comment;
  const Details({Key? key, required this.comment}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ID# ${comment['id']}"),
        backgroundColor: Colors.green,
      ),
      body: Container(
        padding: EdgeInsets.all(15),
        margin: EdgeInsets.all(15),
        color: Colors.red,
        child: ListView(
          children: [
        Text(style: TextStyle(
          fontSize: 20
        ),"Post ID: ${comment['postId']}"),
        Text(style: TextStyle(
            fontSize: 20
        ),"ID : ${comment['id']}"),
        Text(style: TextStyle(
            fontSize: 20
        ),"Name : ${comment['name']}"),
        Text(style: TextStyle(
            fontSize: 20
        ),"Email : ${comment['email']}"),
        Text(style: TextStyle(
            fontSize: 20
        ),"Body : ${comment['body']}"),
            ],
        ),
      ),

    );
  }
}
