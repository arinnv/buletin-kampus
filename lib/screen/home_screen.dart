import 'dart:async';
import 'dart:convert';

import 'package:buletin_kampus/screen/detail.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:buletin_kampus/screen/splashScreen.dart';

import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _email = "";
  List _posts = [];

  @override
  void initState() {
    _getEmail();
    _getData();

    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: Colors.teal,
            height: 120,
            width: double.infinity,
          ),
          Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).padding.top + 12,
              ),
              _buildNameWidget(),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 125),
            child: ListView.builder(
              // itemCount: 5,
              itemCount: _posts.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Container(
                    color: Colors.grey[200],
                    height: 100,
                    width: 100,
                    child: _posts[index]['urlToImage'] != null
                        ? Image.network(
                            _posts[index]['urlToImage'],
                            width: 100,
                            fit: BoxFit.cover,
                          )
                        : Center(),
                  ),
                  title: Text(
                    '${_posts[index]['title']}',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  subtitle: Text(
                    '${_posts[index]['description']}',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (c) => Detail(
                          url: _posts[index]['url'],
                          title: _posts[index]['title'],
                          content: _posts[index]['content'],
                          publishedAt: _posts[index]['publishedAt'],
                          author: _posts[index]['author'],
                          urlToImage: _posts[index]['urlToImage'],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          )
        ],
      ),
    );
  }

  Widget _buildNameWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          CircleAvatar(
            child: Icon(Icons.person),
            backgroundColor: Colors.white,
          ),
          SizedBox(width: 14),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _email,
                // 'isi text',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SizedBox(width: 40),
          Container(
            child: ElevatedButton(
              onPressed: () => logout(),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red[700]),
              child: Text('Log Out'),
            ),
          )
        ],
      ),
    );
  }

  Future _getData() async {
    try {
      String urlString =
          "https://newsapi.org/v2/top-headlines?country=us&category=science&apiKey=a2764e31ef404bbf9935951eeb53900f";
      // "https://newsapi.org/v2/top-headlines?country=id&apiKey=a2764e31ef404bbf9935951eeb53900f";

      Uri uri = Uri.parse(urlString);

      final response = await http.get(uri);

      if (response.statusCode == 200) {
        // print(response.body);
        final data = json.decode(response.body);
        setState(() {
          _posts = data['articles'];
        });
        // print(_posts);
      }
    } catch (e) {
      print(e);
    }
  }

  logout() async {
    // await ini utk menunggu apakah singout ini berhasil atau belum
    await FirebaseAuth.instance.signOut();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => const SplashScreen(),
      ),
      (route) => false,
    );
  }

  void _getEmail() {
    final auth = FirebaseAuth.instance.currentUser;
    _email = auth!.email!;
  }
}
