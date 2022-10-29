import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
class Example4 extends StatefulWidget {
  const Example4({Key? key}) : super(key: key);

  @override
  State<Example4> createState() => _Example4State();
}

class _Example4State extends State<Example4> {
  var data;
  Future<void> getUserapi() async{
    final http.Response response = await http.get(Uri.parse("https://jsonplaceholder.typicode.com/users"));
    if(response.statusCode==200){
      data = jsonDecode(response.body.toString());
    }
    else{

    }

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Api Integration"),
      ),
      body: Column(
        children: [
          Expanded(child:
          FutureBuilder(
            future: getUserapi(),
            builder: (context,snapshot){
              if(snapshot.connectionState == ConnectionState.waiting){
                return CircularProgressIndicator();
              }
              else{
              return ListView.builder(
                itemCount:data.length ,
                  itemBuilder: (contex,index){
                return Card(
                  child: Column(
                    children: [
                      ReUsableRow(title: 'id', value: data[index]['id'].toString()),
                      ReUsableRow(title: "name", value:data[index]['name'] ),
                      ReUsableRow(title: 'username', value: data[index]['username']),
                      ReUsableRow(title: 'City', value: data[index]['address']['city']),
                      ReUsableRow(title: 'longitude', value: data[index]['address']['geo']['lng'].toString()),
                      ReUsableRow(title: 'latitude', value: data[index]['address']['geo']['lat'].toString()),
                    ],
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
   ReUsableRow({Key? key,required this.title, required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.all(8.0),
    child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title),
    Text(value),
      ],
    ),
    );
    
  }
}

