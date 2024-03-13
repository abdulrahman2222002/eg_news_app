// ignore_for_file: file_names, non_constant_identifier_names, must_call_super, avoid_print

import 'dart:convert';

import 'package:egy_news_app/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class HealthScreen extends StatefulWidget {
  const HealthScreen({Key? key}) : super(key: key);

  @override
  State<HealthScreen> createState() => _HealthScreenState();
}

String apiKey = 'e8e6ff95b3694648a6312a7f2f661c1c';

class _HealthScreenState extends State<HealthScreen> {
  var url = "https://newsapi.org/v2/top-headlines?country=eg&category=health&apiKey=$apiKey";

  var Tlist = [];

  Future getdata() async {
    var response = await http.get(Uri.parse(url));
    var responsebody = await jsonDecode(response.body);

    setState(() {
      Tlist = responsebody["articles"];
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    getdata();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: Tlist.length,
      itemBuilder: (BuildContext context, int index) {
        var uurl = Uri.parse(Tlist[index]["url"]);
        return GestureDetector(
          onTap: () async {
            if (await canLaunchUrl(uurl)) {
              await launchUrl(uurl);
            } else {
              print("failed");
            }
          },
          child: Padding(
              padding:
              const EdgeInsets.only(top:5.0, left:  10,right: 10),
              child: Column(
                children: [
                  Row(
                    children: [
                      Tlist[index]["urlToImage"] != Null
                          ? ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: SizedBox(
                            height: 130,
                            child: Image.network(
                                "${Tlist[index]["urlToImage"]}",
                                fit: BoxFit.fill,
                                height: 100,
                                width: 120, errorBuilder:
                                (BuildContext context,
                                Object exception,
                                StackTrace? stackTrace) {
                              return SizedBox(
                                  width: 100,
                                  child: Image.asset(
                                    "assets/images/egNews.png",
                                    fit: BoxFit.fill,
                                  ));
                            }),
                          ),
                        ),
                      )
                          : const SizedBox(),
                      SizedBox(
                        width: 200,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${Tlist[index]["title"]}",
                              style: const TextStyle(
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              "Author: ${Tlist[index]["author"]}",
                              maxLines: 1,
                              style: const TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                            const SizedBox(
                              height: 1,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 145.0),
                              child: Text(
                                "${Tlist[index]["publishedAt"]}",
                                maxLines: 1,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    Share.share('${Tlist[index]["url"]}');
                                  },
                                  icon: Icon(
                                    Icons.share,
                                    color: PrimaryColor,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () async {
                                    if (await canLaunchUrl(uurl)) {
                                      await launchUrl(uurl);
                                    } else {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(content: Text('failed!'))
                                      );
                                    }
                                  },
                                  icon: Icon(
                                    Icons.launch,
                                    color: PrimaryColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                    ],
                  ),
                  const Divider(
                    color: Colors.grey,
                    thickness: 0.5,
                  ),
                ],
              ),
          ),
        );
      },
    );
  }
}
