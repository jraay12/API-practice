import 'package:api/detail_page.dart';
import 'package:api/edit_page.dart';
import 'package:api/formpage.dart';
import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {

  var mainUrl = 'https://jsonplaceholder.typicode.com/comments';
  List comments = <dynamic>[];

  @override
  void initState(){
    super.initState();
    getComments();
  }

  getComments() async{
    var url = mainUrl;
    var response = await http.get(Uri.parse(url));

    setState(() {
      comments = convert.jsonDecode(response.body) as List<dynamic>;
    });
  }


  //delete function para sa http.delete
  deleteComments(var object) async {
    var url = Uri.parse('$mainUrl/${object["id"]}');
    var response = await http.delete(url);

    if (response.statusCode == 200) {
      print('Successfully deleted Comments: ${object["name"]} ID: ${object["id"]}');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.redAccent,
          content: Text(
              'Successfully deleted comments: ${object["name"]} ID: ${object["id"]}')));
    } else {
      return null;
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("API"),
        backgroundColor: Colors.black,
      ),
      body: ListView.builder(
        itemCount: comments.length,
        itemBuilder: (context, index) {
          return ListTile(
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(onPressed: () {
                  setState(() {
                    deleteComments(comments[index]);
                    comments.removeAt(index);
                  });
                }, icon: Icon(Icons.delete, color: Colors.red,)),
                IconButton(onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => EditPage(comment: comments[index])));
                }, icon: Icon(Icons.edit, color: Colors.black,))
              ],
            ),
            title: Text(comments[index]['name']),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => Details(comment: comments[index])));
            },
          );
      },
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => FormPage()));
      },
        child: Icon(Icons.add),
      ),
    );
  }
}
