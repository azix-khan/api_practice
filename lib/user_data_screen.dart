// user data screen withut json model
// Building List with Complex JSON Data WithOut Model Flutter Get API Call with null safety.
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UsersDataScreen extends StatefulWidget {
  const UsersDataScreen({super.key});

  @override
  State<UsersDataScreen> createState() => _UsersDataScreenState();
}

class _UsersDataScreenState extends State<UsersDataScreen> {
  var data;
  Future<void> getUserApi() async {
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
    if (response.statusCode == 200) {
      data = jsonDecode(response.body.toString());
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Getting users data without json model'),
        backgroundColor: Colors.blue,
      ),
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
                future: getUserApi(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Loading',
                            style: TextStyle(
                                fontSize: 30,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    );
                  }
                  return ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        return Card(
                          color: Colors.orange,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            children: [
                              ReuseableRow(
                                  title: 'Name',
                                  value: data[index]['name'].toString()),
                              ReuseableRow(
                                  title: 'Username',
                                  value: data[index]['username'].toString()),
                              ReuseableRow(
                                  title: 'Email',
                                  value: data[index]['email'].toString()),
                              ReuseableRow(
                                  title: 'Address City',
                                  value: data[index]['address']['city']
                                      .toString()),
                              ReuseableRow(
                                  title: 'Address Geo lat',
                                  value: data[index]['address']['geo']['lat']
                                      .toString()),
                            ],
                          ),
                        );
                      });
                }),
          )
        ],
      ),
    );
  }
}

class ReuseableRow extends StatelessWidget {
  final String title, value;
  const ReuseableRow({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
          ),
          Text(
            value,
            style: const TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
