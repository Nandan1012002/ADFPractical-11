import 'package:flutter/material.dart';
import 'api_service.dart';
class DataScreen extends StatefulWidget {
  @override
  _DataScreenState createState() => _DataScreenState();
}
class _DataScreenState extends State<DataScreen> {
  late Future<List<Post>> posts; // Declare a Future for fetching posts
  @override
  void initState() {
    super.initState();
    posts = ApiService.fetchPosts(); // Initialize the Future with fetchPosts() method
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: Text('Posts'),
    ),
    body: Center(
    child: FutureBuilder<List<Post>>(
    future: posts, // Assign the Future to the FutureBuilder
    builder: (context, snapshot) {
    if (snapshot.hasData) {
// If data is available, build ListView to display posts
    return ListView.builder(
    itemCount: snapshot.data!.length,
    itemBuilder: (context, index) {
    return Card(
    elevation: 3,
    margin: EdgeInsets.all(10),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Post ${index + 1}:', // Display post index
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            SizedBox(height: 5),
            Text(
              snapshot.data![index].title, // Display post title
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            SizedBox(height: 5),
            Text(snapshot.data![index].body), // Display post body
          ],
        ),
      ),
    );
    },
    );
    } else if (snapshot.hasError) {
// If an error occurred, display error message
      return Text("${snapshot.error}");
    }
// By default, show a loading spinner
      return CircularProgressIndicator();
    },
    ),
    ),
    );
  }
}