import 'dart:convert';

import 'package:apis_practice/Models/UsersModel.dart';
// import 'package:apis_practice/photos_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  List<UsersModel> userList = [];

  Future<List<UsersModel>> getUserApi() async {
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      for (Map i in data) {
        print(i['name']);
        userList.add(UsersModel.fromJson(i));
      }
      return userList;
    } else {
      return userList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Geting the users data'),
        backgroundColor: Colors.blue,
      ),
      backgroundColor: Colors.yellow,
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
                future: getUserApi(),
                builder: (context, AsyncSnapshot<List<UsersModel>> snapshot) {
                  if (!snapshot.hasData) {
                    return const CircularProgressIndicator();
                  } else {
                    return ListView.builder(
                        itemCount: userList.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              child: Column(
                                children: [
                                  ReuseableRow(
                                      title: 'Name',
                                      value: snapshot.data![index].name
                                          .toString()),
                                  ReuseableRow(
                                      title: 'Company',
                                      value: snapshot.data![index].company
                                          .toString()),
                                  ReuseableRow(
                                      title: 'Address',
                                      value: snapshot.data![index].address
                                          .toString()),
                                  ReuseableRow(
                                      title: 'Address Street',
                                      value: snapshot
                                          .data![index].address!.street
                                          .toString()),
                                  ReuseableRow(
                                      title: 'Address City',
                                      value: snapshot.data![index].address!.city
                                          .toString()),
                                  ReuseableRow(
                                      title: 'Address Zip',
                                      value: snapshot
                                          .data![index].address!.zipcode
                                          .toString()),
                                  ReuseableRow(
                                      title: 'Geo',
                                      value: snapshot.data![index].address!.geo
                                          .toString()),
                                  ReuseableRow(
                                      title: 'Geo Lat',
                                      value: snapshot
                                          .data![index].address!.geo!.lat
                                          .toString()),
                                  ReuseableRow(
                                      title: 'Geo Lng',
                                      value: snapshot
                                          .data![index].address!.geo!.lng
                                          .toString()),
                                ],
                              ),
                            ),
                          );
                        });
                  }
                }),
          )
        ],
      ),
    );
  }
}

class ReuseableRow extends StatelessWidget {
  final title, value;
  const ReuseableRow({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
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
