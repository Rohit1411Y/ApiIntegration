import 'dart:convert';

import 'package:api_integration/models/products_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LastScreen extends StatefulWidget {
  const LastScreen({Key? key}) : super(key: key);

  @override
  State<LastScreen> createState() => _LastScreenState();
}

class _LastScreenState extends State<LastScreen> {
  Future<ProductsModel> getProductsData() async{
    final response = await http.get(Uri.parse('https://webhook.site/0d36a3c9-f10a-466f-ba03-a78e17818c8a'));
    var data  = jsonDecode(response.body.toString());
    if(response.statusCode == 200){
      return ProductsModel.fromJson(data);
    }
    else{
      return ProductsModel.fromJson(data);
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
          Expanded(
              child:FutureBuilder<ProductsModel>(
                future: getProductsData(),
                builder: (context,snapshot){
                  if(!snapshot.hasData){
                    return CircularProgressIndicator();
                  }
                  else{
                    return ListView.builder(

                        itemCount: snapshot.data!.data!.length,
                        itemBuilder: (context,index){

                          return Column(

                            children: [
                              Container(
                               height: MediaQuery.of(context).size.height*.3,
                                width: MediaQuery.of(context).size.width*.3,

                                child: ListView.builder(
                                     itemCount: snapshot.data!.data![index].products!.length,
                                    itemBuilder: (context,position){
                                       return Container(
                                         height: MediaQuery.of(context).size.height*.3,
                                         width: MediaQuery.of(context).size.width*.3,
                                         child: ListView.builder(
                                             itemCount: snapshot.data!.data![index].products![position].images!.length,
                                             itemBuilder: (context,size){
                                               return Container(
                                                 height: MediaQuery.of(context).size.height*.3,
                                                 width: MediaQuery.of(context).size.width*.3,
                                                  //child: Text(snapshot.data!.data![index].products![position].images![size].url.toString()),
                                                  child: Image.network(snapshot.data!.data![index].products![position].images![size].url.toString()),
                                               );

                                         }),

                                       );
                                    }),

                              // child: ListView.builder(itemBuilder: itemBuilder),
                              )
                            ],
                          );



                        });
                  }

                },
              ) )

        ],
      ),
    );
  }
}
