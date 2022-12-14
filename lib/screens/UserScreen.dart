import 'dart:convert';

import 'package:flutter/material.dart';

import '../models/UserModel.dart';
import 'package:http/http.dart' as http;
class UserScreen extends StatefulWidget {
  const UserScreen({Key? key}) : super(key: key);

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  List<UserModel> userList = [];
  Future<List<UserModel>> getUser() async {
    final http.Response response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
    var data =  jsonDecode(response.body.toString());
    if(response.statusCode == 200){
      for(Map i in data){
        userList.add(UserModel.fromJson(i));
      }
      return userList;
    }
    else{
      return userList;
    }
    
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Api Integration"),
      ),
      body: Column(
        children: [
          Expanded(child: FutureBuilder(
            future: getUser(),
            builder: (context, AsyncSnapshot<List<UserModel>> snapshot){
              if(!snapshot.hasData){
                return CircularProgressIndicator();
              }
              else{
                return ListView.builder(
                    itemCount: userList.length,
                    itemBuilder: (context,index){
                      return Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              ReUsableRow(title: "Name", value: snapshot.data![index].name.toString()),
                              ReUsableRow(title: "UserName", value: snapshot.data![index].username.toString()),
                              ReUsableRow(title: "Email", value: snapshot.data![index].email.toString()),
                              ReUsableRow(title: "Address", value: snapshot.data![index].address!.city.toString()+" "+snapshot.data![index].address!.geo!.lat.toString()),
                            ],

                          ),
                        ),
                      );
                    });
              }

            },
          ))
          
        ],
      ),
    );
  }
}
class ReUsableRow extends StatelessWidget {
  String title;
  String value;
   ReUsableRow({Key? key,required this.title,required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return   Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment:MainAxisAlignment.spaceBetween ,
        children: [
          Text(title),
          Text(value),
        ],
      ),
    );
  }
}

