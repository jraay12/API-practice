import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'comment_model.dart';


class FormPage extends StatefulWidget {
  const FormPage({Key? key}) : super(key: key);

  @override
  State<FormPage> createState() => _FormPageState();
}


Future<CommentModel?> submit (String name, String email, String body) async {
  var url = Uri.parse('https://jsonplaceholder.typicode.com/comments');
  var Data = json.encode({'name': name, 'email': email, 'body' : body});
  var response = await http.post(url, body: Data);

  if (response.statusCode == 201) {
    print('Successfully added');
    var display = response.body;
    print(display);
    String todoResponse = response.body;
    commentModelFromJson(todoResponse);
  } else {
    return null;
  }
}
class _FormPageState extends State<FormPage> {


  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController body = TextEditingController();

  var formKey = GlobalKey<FormState>();
  CommentModel? commentModel;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Form Page"),
        backgroundColor: Colors.blue,
      ),
      body: Form(
        key: formKey,
          child: Container(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: name,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        labelText: 'name'
                    ),
                    validator: (value) {
                      return (value == '') ? "Please enter a value": null;
                    },

                  ),
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: email,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        labelText: 'Email'
                    ),
                    validator: (value) {
                      return (value == '') ? "Please enter a value": null;
                    },

                  ),
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: body,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        labelText: 'Body'
                    ),
                    validator: (value) {
                      return (value == '') ? "Please enter a value": null;
                    },

                  ),
                  Container(
                    height: 40,
                    margin: EdgeInsets.all(10),

                    child: SizedBox(

                      height: 40,
                      child: ElevatedButton(onPressed: () async{
                        if (formKey.currentState!.validate()) {
                          CommentModel? data = await submit(name.text, email.text, body.text);
                          setState(()  {
                            commentModel = data;

                          });
                        } else {
                          return null;
                        }
                        Navigator.pop(context);

                      }, child: Text("Submit")),
                    ),
                  )

                ],
              
            ),
          ),
      ),


    );

  }
}
