import 'package:flutter/material.dart';  
import 'main.dart'; // Import the WeChatMainPage
import 'DiscoverPage.dart';  // Import your DiscoverPage
import 'profile.dart';   // Import your ProfilePage

class ContactsPage extends StatelessWidget {
  final List<Map<String, String>> fixedContacts = [
    {"name": "新的朋友", "image": 'assets/new_friend.jpg'},
    {"name": "仅聊天的朋友", "image": 'assets/chat.jpg'},
    {"name": "群聊", "image": 'assets/group.jpg'},
    {"name": "标签", "image": 'assets/label.jpg'},
    {"name": "公众号", "image": 'assets/public.jpg'},
    {"name": "服务号", "image": 'assets/service.jpg'},
  ];

  final List<Map<String, String>> dynamicContacts = [
    {"name": "XX", "image": 'assets/user_1.jpg'},
    {"name": "Lisa", "image": 'assets/user_2.jpg'},
    {"name": "Chimpanzini Bananini", "image": 'assets/user_3.jpg'},
    {"name": "美羊羊", "image": 'assets/user_4.jpg'},
    {"name": "墙头的草", "image": 'assets/user_5.jpg'},
    {"name": "Looking my eyes", "image": 'assets/user_6.jpg'},
    {"name": "哪吒", "image": 'assets/user_7.jpg'},
    {"name": "敖丙他爸", "image": 'assets/user_8.jpg'},
    {"name": "Bobibo", "image": 'assets/user_9.jpg'},
    {"name": "tralalero tralala", "image": 'assets/user_10.jpg'},
  ];

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> sortedDynamicContacts = List.from(dynamicContacts);
    sortedDynamicContacts.sort((a, b) {
      return a['name']!.compareTo(b['name']!);
    });

    List<Map<String, String>> allContacts = []
      ..addAll(fixedContacts)
      ..addAll(sortedDynamicContacts);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          '通讯录', 
          style: TextStyle(color: Colors.black, fontSize: 18.0),  // Adjusted font size for "通讯录"
        ),
        backgroundColor: Colors.grey[100],
        centerTitle: true,  // Ensures the title is centered
        automaticallyImplyLeading: false, // Remove the back button
      ),
      body: ListView.builder(
        itemCount: allContacts.length,
        itemBuilder: (context, index) {
          // If the contact is in fixedContacts, set a light grey background
          bool isFixedContact = index < fixedContacts.length;
          
          return ListTile(
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(8), // Set rounded corners for the image
              child: Image.asset(
                allContacts[index]['image']!,
                width: 40,  // Set the width and height to make the image square
                height: 40,
                fit: BoxFit.cover,  // Ensure the image is correctly scaled
              ),
            ),
            title: Text(
              allContacts[index]['name']!,
              style: TextStyle(color: Colors.black),
            ),
            tileColor: isFixedContact ? Colors.grey[200] : Colors.white, // Set a light grey background for fixedContacts
            onTap: () {
              // Handle tap here, for now, we simply navigate to the chat page
            },
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.grey[200],
        currentIndex: 1,  // Keep "通讯录" selected by default
        onTap: (index) {
          if (index == 0) {
            // If "消息" tab is selected, navigate to the messages page
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => WeChatMainPage()),
              (route) => false, // Removes all the previous routes so the current one is the only one
            );
          } else if (index == 1) {
            // If "通讯录" tab is selected, stay on this page
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => ContactsPage()),
              (route) => false,
            );
          } else if (index == 2) {
            // If "发现" tab is selected, navigate to DiscoverPage
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => DiscoverPage()),
            );
          } else if (index == 3) {
            // If "我" tab is selected, navigate to ProfilePage
            Navigator.push(
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
