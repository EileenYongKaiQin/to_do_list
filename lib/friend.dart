import 'package:flutter/material.dart'; 
import 'package:video_player/video_player.dart';

class FriendPage extends StatefulWidget {
  @override
  _FriendPageState createState() => _FriendPageState();
}

class _FriendPageState extends State<FriendPage> {
  late VideoPlayerController _controller;

  // 示例数据
  final List<Map<String, dynamic>> posts = [
    {
      "username": "Eileen",
      "content": "😺",
      "time": "9分钟前",
      "avatar": "assets/me.jpg",
      "video": "assets/cat.mp4", // 视频路径
      "likes": "0",
      "comments": [],
    },
    {
      "username": "xx",
      "content": "yeah~",
      "image": "assets/post1.jpg",
      "time": "9分钟前",
      "avatar": "assets/user_1.jpg",
      "likes": "0",
      "comments": [],
    },
    {
      "username": "Lisa",
      "content": "今日份快乐～",
      "image": "assets/post2.jpg",
      "time": "昨天",
      "avatar": "assets/user_2.jpg",
      "likes": "0",
      "comments": [],
    },
    {
      "username": "Eileen",
      "content": "诶 这位小姐~",
      "image": "assets/post3.jpg",
      "time": "前天",
      "avatar": "assets/me.jpg",
      "likes": "0",
      "comments": [],
    },
  ];

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('assets/cat.mp4')
      ..initialize().then((_) {
        setState(() {
          _controller.play();
          _controller.setLooping(true);
        });
      });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  void _incrementLikes(int index) {
    setState(() {
      int currentLikes = int.parse(posts[index]["likes"]!);
      posts[index]["likes"] = (currentLikes + 1).toString();
    });
  }

  void _showCommentDialog(int index) {
    final TextEditingController commentController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Comment'),
          content: TextField(
            controller: commentController,
            decoration: InputDecoration(hintText: 'Enter comment...'),
          ),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Close Button on the left
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Close'),
                ),
                // Submit Button on the right
                TextButton(
                  onPressed: () {
                    setState(() {
                      if (commentController.text.isNotEmpty) {
                        posts[index]["comments"].add(commentController.text);
                      }
                    });
                    Navigator.pop(context);
                  },
                  child: Text('Submit'),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  void _sharePost(int index) {
    print('分享: ${posts[index]["content"]}');
  }

  // Widget to build video player
  Widget _buildVideoPlayer(String videoPath) {
    return _controller.value.isInitialized
        ? Container(
            padding: EdgeInsets.all(8.0),
            child: AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              child: VideoPlayer(_controller),
            ),
          )
        : Container();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("朋友圈"),
        backgroundColor: Colors.grey[100],
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // 返回到前一个页面
          },
        ),
      ),
      body: ListView.builder(
        itemCount: posts.length,
        itemBuilder: (context, index) {
          var post = posts[index];
          return Card(
            margin: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // User's Avatar and Name
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: AssetImage(post["avatar"] ?? ""),
                        radius: 20,
                      ),
                      SizedBox(width: 10),
                      Text(
                        post["username"] ?? "Unknown",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                // Post Content
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(post["content"] ?? ""),
                ),
                // Image or Video
                if (post["video"]?.isNotEmpty ?? false)
                  Container(
                    width: 140,
                    height: 230, // You can adjust the height here
                    child: _buildVideoPlayer(post["video"]!),
                  ),
                if (post["image"]?.isNotEmpty ?? false)
                  Container(
                    padding: EdgeInsets.all(8.0),
                    width: 140,
                    height: 200, // You can adjust the height here
                    child: Image.asset(
                      post["image"] ?? "",
                      fit: BoxFit.contain,  // Keep the original aspect ratio
                    ),
                  ),
                // Time of post
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(post["time"] ?? "Unknown Time"),
                ),
                // Like, Comment, and Share Actions
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.thumb_up, size: 18),
                          SizedBox(width: 5),
                          TextButton(
                            onPressed: () => _incrementLikes(index),
                            child: Text(
                              "${post['likes']} Likes", 
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(Icons.comment, size: 18),
                          SizedBox(width: 5),
                          TextButton(
                            onPressed: () => _showCommentDialog(index),
                            child: Text("Comment"),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(Icons.share, size: 18),
                          SizedBox(width: 5),
                          TextButton(
                            onPressed: () => _sharePost(index),
                            child: Text("Share"),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                // Display Comments
                if (post["comments"].isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: post["comments"].map<Widget>((comment) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5.0),
                          child: Text(
                            comment,
                            style: TextStyle(fontSize: 14, color: Colors.grey),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
