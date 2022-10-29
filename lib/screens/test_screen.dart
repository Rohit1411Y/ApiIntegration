import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
class TestScreen extends StatefulWidget {
  const TestScreen({Key? key}) : super(key: key);

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  List<photos> photoslist = [];
  Future<List<photos>> getPhotos() async{
    final http.Response response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));
    var data = jsonDecode(response.body.toString());
    if(response.statusCode==200){
       for(Map i in data){
         photos photo = photos(albumId: i['albumId'], id: i['id'], title: i['title'], url: i['url'], thumbnailUrl: i['thumbnailUrl']);
         photoslist.add(photo);
       }

      return photoslist;
    }else{
      return photoslist;
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

          Expanded(
            child: FutureBuilder(
              future: getPhotos(),
                builder: (context, AsyncSnapshot<List<photos>>snapshot){
              return ListView.builder(
                itemCount: photoslist.length,
                  itemBuilder: (context,index){
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(snapshot.data![index].url.toString()),
                  ),
                   title: Text(snapshot.data![index].id.toString()),
                   subtitle: Text(snapshot.data![index].title.toString()),
                );
              });
            }),
          )
        ],
      ),
    );
  }

}
class photos{
  int ? albumId;
  int? id;
  String? title;
  String? url;
  String? thumbnailUrl;
photos({required this.albumId,required this.id, required this.title,required this.url,required this.thumbnailUrl});
}
