import 'dart:convert';

import 'package:apis_practice/Models/ProductsModel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  Future<ProductsModel> getProdcts() async {
    final response = await http.get(
        Uri.parse('https://webhook.site/e799f31c-b92c-48fe-8bfe-59ccb0e72f1a'));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      return ProductsModel.fromJson(data);
    } else {
      return ProductsModel.fromJson(data);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Complex json'),
        backgroundColor: Colors.amber,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder(
                  future: getProdcts(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                          itemCount: snapshot.data!.data!.length,
                          itemBuilder: (context, index) {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ListTile(
                                  title: Text(snapshot
                                      .data!.data![index].shop!.name
                                      .toString()),
                                  subtitle: Text(snapshot
                                      .data!.data![index].shop!.description
                                      .toString()),
                                  trailing: const Icon(
                                    Icons.shopping_basket_outlined,
                                    color: Colors.green,
                                  ),
                                  leading: CircleAvatar(
                                    backgroundImage: NetworkImage(snapshot
                                        .data!.data![index].images
                                        .toString()),
                                  ),
                                ),
                                // ignore: sized_box_for_whitespace
                                Container(
                                  height:
                                      MediaQuery.of(context).size.height * .3,
                                  width: MediaQuery.of(context).size.width * 1,
                                  child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: snapshot
                                          .data!.data![index].images!.length,
                                      itemBuilder: (context, possition) {
                                        return Padding(
                                          padding:
                                              const EdgeInsets.only(right: 10),
                                          child: Container(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                .25,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                .5,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                                image: DecorationImage(
                                                    fit: BoxFit.cover,
                                                    image: NetworkImage(snapshot
                                                        .data!
                                                        .data![index]
                                                        .images![possition]
                                                        .url
                                                        .toString()))),
                                          ),
                                        );
                                      }),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Icon(
                                  snapshot.data!.data![index].inWishlist! ==
                                          false
                                      ? Icons.favorite
                                      : Icons.favorite_border_outlined,
                                  color: Colors.red,
                                )
                              ],
                            );
                          });
                    } else {
                      return const Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [Text('Loading')],
                        ),
                      );
                    }
                  }),
            )
          ],
        ),
      ),
    );
  }
}
