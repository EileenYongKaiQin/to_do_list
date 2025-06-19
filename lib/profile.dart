import 'package:flutter/material.dart';     
import 'main.dart';
import 'DiscoverPage.dart';
import 'contacts_page.dart';
import 'SetStatusPage.dart';  // Import the SetStatusPage.dart file

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String currentStatus = "未设置";  // Default status

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[100],
        automaticallyImplyLeading: false, // No back button
        actions: [], // No setting button
      ),
      body: Container(
        color: Colors.white,  // Set background color for the body to white
        child: Column(
          children: [
            // ✅ Profile header
            Container(
              padding: EdgeInsets.fromLTRB(20, 10, 20, 20), // Move upwards a bit
              color: Colors.grey[100],
              child: Row(
                children: [
                  // ✅ Square avatar with rounded corners
                  GestureDetector(
                    onTap: () {
                      // When the avatar is clicked, navigate to another page showing the original size
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FullSizeImagePage(),
                        ),
                      );
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        'assets/me.jpg',
                        width: 80,
                        height: 80,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Eileen",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text("WeChat ID: kqinnn26"),
                      SizedBox(height: 10),
                      // ✅ Status button with desired pattern
                      Row(
                        children: [
                          OutlinedButton.icon(
                            onPressed: () {
                              // Navigate to the "Set Status" page when clicked
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SetStatusPage(onStatusSelected: (status) {
                                    setState(() {
                                      currentStatus = status;  // Update the status
                                    });
                                  }),
                                ),
                              );
                            },
                            icon: Icon(Icons.add, size: 16, color: Colors.grey),
                            label: Text(
                              "设置状态",
                              style: TextStyle(color: Colors.grey),
                            ),
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(color: Colors.grey),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              visualDensity: VisualDensity.compact,
                            ),
                          ),
                          SizedBox(width: 8),
                          Icon(Icons.refresh, size: 20, color: Colors.grey), // Right circular icon
                        ],
                      ),
                      SizedBox(height: 10),
                      // Show the selected status here
                      Text(
                        "当前状态: $currentStatus",
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                    ],
                  ),
                  Spacer(),
                  IconButton(
                    icon: Icon(Icons.qr_code_scanner),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
            // ✅ Function list with white background for ListView
            Expanded(
              child: ListView(
                padding: EdgeInsets.all(0), // Remove padding
                children: [
                  ListTile(
                    leading: Icon(Icons.payment),
                    title: Text("支付与服务"),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: Icon(Icons.star),
                    title: Text("收藏"),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: Icon(Icons.photo_album),
                    title: Text("朋友圈"),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: Icon(Icons.card_giftcard),
                    title: Text("卡包"),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: Icon(Icons.mood),
                    title: Text("表情"),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: Icon(Icons.settings),
                    title: Text("设置"),
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.grey[300],
        currentIndex: 3, // Set to "我" page when navigating to ProfilePage
        onTap: (index) {
          if (index == 0) {
            // Navigate to WeChatMainPage with "消息" selected
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => WeChatMainPage()),
              (route) => false, // Remove all previous routes
            );
          } else if (index == 1) {
            // Navigate to ContactsPage with "通讯录" selected
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => ContactsPage()),
              (route) => false, // Remove all previous routes
            );
          } else if (index == 2) {
            // Navigate to DiscoverPage with "发现" selected
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => DiscoverPage()),
              (route) => false, // Remove all previous routes
            );
          } else if (index == 3) {
            // Keep "我" as the current page
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

// A page to display the full-size image when clicked
class FullSizeImagePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("头像"),
        backgroundColor: Colors.grey[100],
        automaticallyImplyLeading: true, // Enable the back button
      ),
      body: Center(
        child: Image.asset(
          'assets/me.jpg',
          fit: BoxFit.contain,  // Display the image without clipping
          width: double.infinity,  // Allow it to take up the full width
          height: double.infinity, // Allow it to take up the full height
        ),
      ),
    );
  }
}
