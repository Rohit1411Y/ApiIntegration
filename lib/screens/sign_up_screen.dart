import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  void login(String email,String password) async{
    try{
      final http.Response response = await http.post(
          Uri.parse('https://reqres.in/api/register'),
          body:{
            'email': email,
            'password': password
          }
      );
      if(response.statusCode==200){
        var data = jsonDecode(response.body.toString());
        print(data['token']+"\n"+ data['id'].toString());
      }
      else{
        print('Failed');
      }


    }
    catch(e){
      print(e.toString());
    }

  }
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title: Text(" Sign Up Screen "),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(
                hintText: 'Email'
              ),
            ),
            SizedBox(height: 20,),

            TextFormField(
              controller: _passwordController,
              decoration: InputDecoration(

                  hintText: 'Password'
              ),
            ),
            SizedBox(height: 40,),
            GestureDetector(
              onTap: (){
                login(_emailController.text.toString(),_passwordController.text.toString());
              },
              child: Container(
                height: 40,
                width: 120,
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(

                  child: Text("SignUp"),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
