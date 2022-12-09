import 'dart:convert';
import 'package:api/comment_model.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class EditPage extends StatefulWidget {
  final dynamic comment;

  const EditPage({Key? key, required this.comment}) : super(key: key);

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {


  var formKey = GlobalKey<FormState>();
  var mainUrl = Uri.parse('https://jsonplaceholder.typicode.com/comments');
  var id = '';
  var verifyName;
  var verifyEmail;
  var verifyBody;

  @override
  void initState() {
    super.initState();
    name.text = widget.comment["name"];
    email.text = widget.comment["email"];
    body.text = widget.comment["body"];
    id = widget.comment["id"].toString();
    verifyName = widget.comment['name'];
    verifyEmail = widget.comment['email'];
    verifyBody = widget.comment['body'];
  }



  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController body = TextEditingController();

  editData() async {
    var newName = name.text;
    var newEmail = email.text;
    var newBody = body.text;
    var url = Uri.parse('$mainUrl/$id');
    var Data = json.encode({
      'name:': newName,
      'email' : newEmail,
      'body' : newBody
    });
    var response = await http.patch(url, body: Data);
    if (response.statusCode == 200) {
      print('\nSuccessfully edit comment id: $id!');
      var display = response.body;
      print(display);
    } else {
      return null;
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Page"),
        backgroundColor: Colors.red,
      ),
      body: Form(
        key: formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Container(
            padding: EdgeInsets.all(30),
            child: Column(
              children: [
                TextFormField(
                  controller: name,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    labelText: 'Name',
                    hintText: 'E.x John Ray'
                  ),
                  validator: (value) {
                    return (value == '') ? "Please enter a value": null;
                  },
                ),
                TextFormField(
                  controller: email,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                      labelText: 'Email',
                      hintText: 'E.x Johnray@gmail.com'
                  ),
                  validator: (value) {
                    return (value == '') ? "Please enter a value": null;
                  },
                ),
                Container(
                  padding: EdgeInsets.only(bottom: 20),
                  child: TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: body,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      labelText: 'body',
                      contentPadding: const EdgeInsets.symmetric(vertical: 60.0, horizontal: 10.0),
                    ),
                    validator: (value) {
                      return (value == '') ? "Please enter a value": null;
                    },
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(40),
                  child: SizedBox(
                    height: 40,
                    child: ElevatedButton(onPressed: () async{



                      if (formKey.currentState!.validate()) {
                        if (verifyName != name.text){
                          await editData();
                          Navigator.pop(context,verifyName);
                        }else if (verifyEmail != email.text){
                           editData();
                          Navigator.pop(context,verifyEmail);
                        }else if (verifyBody != body.text){
                           editData();
                          Navigator.pop(context,verifyBody);
                        }
                      }else{
                        return null;
                      }
                    }, child: Text("Submit")),
                  ),
                )
              ],
            ),
          )
      )


    );
  }
}
