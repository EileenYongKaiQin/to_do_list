import 'package:flutter/material.dart';
import 'friend.dart'; // Import the FriendPage
import 'main.dart'; // Import the main page (WeChatMainPage) for bottom navigation
import 'contacts_page.dart';
import 'profile.dart';

class DiscoverPage extends StatelessWidget {
  final List<Map<String, String>> discoverFeatures = [
    {"name": "朋友圈", "image": "assets/friends_circle.jpg"},
    {"name": "视频号", "image": "assets/video_account.jpg"},
    {"name": "扫一扫", "image": "assets/scan.jpg"},
    {"name": "摇一摇", "image": "assets/shake.jpg"},
    {"name": "搜一搜", "image": "assets/search.jpg"},
    {"name": "附近的人", "image": "assets/nearby_people.jpg"},
    {"name": "小程序", "image": "assets/mini_program.jpg"},
    {"name": "WeChat Out", "image": "assets/wechat_out.jpg"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            "发现",
            style: TextStyle(color: Colors.black, fontSize: 18.0),
          ),
        ),
        backgroundColor: Colors.grey[100],
        automaticallyImplyLeading: false, // No back button
      ),
      body: Container(
        color: Colors.white,
        child: ListView.builder(
          itemCount: discoverFeatures.length,
          itemBuilder: (context, index) {
            final feature = discoverFeatures[index];
            return ListTile(
              leading: feature['image'] != null && feature['image']!.isNotEmpty
                  ? Image.asset(
                      feature['image']!,
                      width: 30,
                      height: 30,
                      fit: BoxFit.cover,
                    )
                  : SizedBox.shrink(),
              title: Text(
                feature['name'] ?? 'Unknown',
                style: TextStyle(color: Colors.black),
              ),
              trailing: Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                if (feature['name'] == '朋友圈') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => FriendPage()), // Navigate to FriendPage
                  );
                } else {
                  // Handle other features here
                }
              },
            );
          },
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.grey[200],
        currentIndex: 2,
        onTap: (index) {
          if (index == 0) {
            // If "消息" tab is selected
            Navigator.pop(context);
          } else if (index == 1) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => ContactsPage()),
            );
          } else if (index == 2) {
            // Already on the DiscoverPage
          } else if (index == 3) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => ProfilePage()),
            );
          }
        },
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.black,
        type: BottomNavigationBarType.fixed,
        iconSize: 20.0,
        selectedLabelStyle: TextStyle(fontSize: 10.0),
        unselectedLabelStyle: TextStyle(fontSize: 10.0),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.wechat),
            label: '消息',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.contacts),
            label: '通讯录',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.disc_full),
            label: '发现',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: '我',
          ),
        ],
      ),
    );
  }
}
