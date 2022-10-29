import 'dart:convert';

import 'package:api_integration/models/post_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<PostModel> postList = [];
  Future<List<PostModel>> getPosts() async{
   final http.Response response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts/'));
   var data = jsonDecode(response.body.toString());
   if(response.statusCode==200){
    for(Map i in data){
      postList.add(PostModel.fromJson(i));
    }
     return postList;
   }
   else{
     return postList;
   }


  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Api Integration"),
      ),
      body:Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: getPosts(),
              builder: (context,snapshot){
                if(!snapshot.hasData){
                  return Text('Loading');
                }
                else{
                  return ListView.builder(
                    itemCount: postList.length,
                      itemBuilder: (context,hello){
                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.all(0.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.network('https://www.shutterstock.com/image-photo/30092019-riga-latvia-sports-girl-600w-1616559388.jpg'),
                            Text(postList[hello].title.toString())
                          ],
                        ),
                      ),
                    );
                  });

                }
              },
            ),
          )

        ],
      )
    );
  }
}
