import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_apis/post.dart';
import 'package:http/http.dart' as http;

void main() => runApp(
      const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: ComplexAPI(),
      ),
    );

class ComplexAPI extends StatefulWidget {
  const ComplexAPI({Key? key}) : super(key: key);

  @override
  State<ComplexAPI> createState() => _ComplexAPIState();
}

class _ComplexAPIState extends State<ComplexAPI> {
  Future<List<Post>> getPosts() async {
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
    if (response.statusCode == 200) {
      if (response.body.isNotEmpty) {
        List jsonResponse = jsonDecode(response.body);
        return jsonResponse.map((posts) => Post.fromJson(posts)).toList();

        /* Alternative
        for(Map i in response){
        postList.add(Post.fromJson(i));
        }
        return jsonResponse
        */
      } else {
        throw Exception('API has no data');
      }
    } else {
      throw Exception('Server Error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('API Calling'),
      ),
      body: Center(
        child: FutureBuilder<List<Post>>(
          future: getPosts(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Post>? posts = snapshot.data;
              return ListView.builder(
                itemCount: posts!.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(30),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'UserID: ${posts[index].userID}',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'ID: ${posts[index].id}',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            'Title',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            posts[index].title.toString(),
                          ),
                          const SizedBox(height: 6),
                          const Text(
                            'Body',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            posts[index].body.toString(),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            }
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
