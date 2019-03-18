import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart'as http;




void main() => runApp(new MaterialApp(
  home:HomePage(),
));

class HomePage extends StatefulWidget{
  @override
  HomePageState createState()=> HomePageState();

}

class HomePageState extends State<HomePage>{

final String url ="https://swapi.co/api/people";
List data;

@override
void initState(){
  super.initState();
  this.getJsonData();
}

Future <String> getJsonData() async{
var response =await http.get(
//encode the url
Uri.encodeFull(url),
//only expect json response
 headers:{"Accept":"application/json"}
);

print(response.body);

setState(() {
  var convertDataToJson=json.decode(response.body);
  data=convertDataToJson['results'];
});
return "Success";
}

  @override
  Widget build(BuildContext context){
    return Scaffold(
       appBar: AppBar(
         title : Text ("retrive the data via HTTP")
       ),
        body: ListView.builder(
          itemCount: data == null ? 0 : data.length,
          itemBuilder: (BuildContext context ,int index){
            return new Container(
              child: Center(
                 child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                     children: <Widget>[
                        Card(
                           child: Container(
                              child: Text(data[index]['name']),
                               padding: const EdgeInsets.all(20.0),
                           ),
                        )
                     ],
                 ),
              ),

            );
          }
        ),
    );
  }
}