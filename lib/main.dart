import 'package:flutter/material.dart';   
import 'package:intl/intl.dart'; 
import 'contacts_page.dart'; // Import your contacts page
import 'profile.dart';  // Import the profile page
import 'DiscoverPage.dart'; // Import the discover page


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WeChat Clone',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: WeChatMainPage(),
    );
  }
}

class WeChatMainPage extends StatefulWidget {
  @override
  _WeChatMainPageState createState() => _WeChatMainPageState();
}

class _WeChatMainPageState extends State<WeChatMainPage> {
  int _selectedIndex = 0;
  String _searchQuery = ""; 
  final TextEditingController _searchController = TextEditingController();

  final List<Map<String, dynamic>> contacts = [
    {"name": "XX", "message": "", "time": "", "image": 'assets/user_1.jpg', "messages": []},
    {"name": "Lisa", "message": "", "time": "", "image": 'assets/user_2.jpg', "messages": []},
    {"name": "Chimpanzini Bananini", "message": "", "time": "", "image": 'assets/user_3.jpg', "messages": []},
    {"name": "美羊羊", "message": "", "time": "", "image": 'assets/user_4.jpg', "messages": []},
    {"name": "墙头的草", "message": "", "time": "", "image": 'assets/user_5.jpg', "messages": []},
    {"name": "Looking my eyes", "message": "", "time": "", "image": 'assets/user_6.jpg', "messages": []},
    {"name": "哪吒", "message": "", "time": "", "image": 'assets/user_7.jpg', "messages": []},
    {"name": "敖丙他爸", "message": "", "time": "", "image": 'assets/user_8.jpg', "messages": []},
    {"name": "Bobibo", "message": "", "time": "", "image": 'assets/user_9.jpg', "messages": []},
    {"name": "tralalero tralala", "message": "", "time": "", "image": 'assets/user_10.jpg', "messages": []},
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _navigateToChatPage(Map<String, dynamic> contact) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChatPage(contact: contact),
      ),
    );
  }

  List<Map<String, dynamic>> _getFilteredContacts() {
    if (_searchQuery.isEmpty) {
      return contacts;
    } else {
      return contacts
          .where((contact) => contact['name'].toLowerCase().contains(_searchQuery.toLowerCase()))
          .toList();
    }
  }

  void _navigateToContactsPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ContactsPage(),
      ),
    );
  }

  void _navigateToProfilePage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProfilePage(),
      ),
    );
  }

  void _navigateToDiscoverPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DiscoverPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(90),
        child: AppBar(
          backgroundColor: Colors.grey[200],
          elevation: 0,
          title: Stack(
            children: [
              Center(
                child: Text(
                  'WeChat',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(50),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                children: [
                  Container(
                    height: 30,
                    width: MediaQuery.of(context).size.width * 0.95,
                    child: TextField(
                      controller: _searchController,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: '搜索',
                        contentPadding: EdgeInsets.symmetric(vertical: 6),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none,
                        ),
                        hintStyle: TextStyle(color: Colors.grey),
                      ),
                      onChanged: (value) {
                        setState(() {
                          _searchQuery = value;
                        });
                      },
                    ),
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ),
      ),
      body: Container(
        color: Colors.white, // 确保整体背景是白色
        child: ListView.separated(
          itemCount: _getFilteredContacts().length,
          separatorBuilder: (context, index) => Divider(
            height: 0.05,
            color: Colors.grey[300], // 分隔线颜色浅一点
            thickness: 0.65,
          ),
          itemBuilder: (context, index) {
            final contact = _getFilteredContacts()[index];
            final isSpecialContact = contact['name'] == 'XX' || contact['name'] == 'Lisa';

            return Container(
              color: isSpecialContact ? Colors.grey[200] : Colors.white,
              child: ListTile(
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    contact['image']!,
                    width: 40,
                    height: 40,
                    fit: BoxFit.cover,
                  ),
                ),
                title: Text(
                  contact['name']!,
                  style: TextStyle(fontSize: 16),
                ),
                subtitle: Text(
                  contact['messages'].isEmpty ? '' : contact['messages'].last['message'],
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
                trailing: contact['time'] != ""
                    ? Text(
                        contact['time']!,
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      )
                    : null,
                onTap: () {
                  _navigateToChatPage(contact);
                },
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.grey[200],
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
          if (index == 0) {
            // Do nothing
          } else if (index == 1) {
            _navigateToContactsPage();
          } else if (index == 2) {
            _navigateToDiscoverPage();
          } else if (index == 3) {
            _navigateToProfilePage();
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

class ChatPage extends StatefulWidget {
  final Map<String, dynamic> contact;

  ChatPage({required this.contact});

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _controller = TextEditingController();
  bool _isTextEmpty = true;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {
        _isTextEmpty = _controller.text.isEmpty;
      });
    });
  }

  // 发送消息并更新联系人消息列表
  void _sendMessage() {
    if (_controller.text.isNotEmpty) {
      setState(() {
        widget.contact['messages'].add({
          'message': _controller.text,
          'sender': 'me',
        });
        widget.contact['time'] = DateFormat('a hh:mm').format(DateTime.now());
        _controller.clear();
        _isTextEmpty = true;
      });
    }
  }

  // 显示表情选择器
  void _showEmojiPicker() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 7,
            childAspectRatio: 1,
          ),
          itemCount: 50,
          itemBuilder: (context, index) {
            List<String> emojis = [
              '😊', '😂', '😍', '😎', '😜', '🥺', '🤔', '🥳', '💩', '❤️',
              '💀', '😇', '🤩', '🥰', '😻', '🐱', '🦄', '🐯', '🐨', '🦁',
              '👑', '🤡', '🤠', '🦋', '🐝', '🌈', '🌻', '🌺', '💐', '🌸',
              '🌷', '🍀', '🌼', '🍉', '🍓', '🍇', '🍌', '🍍', '🍒', '🍊',
              '🍉', '🍪', '🍩', '🍕', '🍔', '🌮', '🍣', '🍜', '🍿', '🥗'
            ];
            return GestureDetector(
              onTap: () {
                _controller.text += emojis[index]; // 将表情添加到文本框中
                Navigator.pop(context); // 关闭表情选择器
                setState(() {});  // 确保刷新显示
              },
              child: Center(
                child: Text(
                  emojis[index], // 显示表情
                  style: TextStyle(fontSize: 24),
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(widget.contact['name']!),
        backgroundColor: Colors.grey[200],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: widget.contact['messages'].length,
              itemBuilder: (context, index) {
                bool isSender = widget.contact['messages'][index]['sender'] == 'me';
                return Align(
                  alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                    margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                    decoration: BoxDecoration(
                      color: isSender ? Colors.green : Colors.grey[300],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      widget.contact['messages'][index]['message']!,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                IconButton(
                  icon: Icon(Icons.mic),
                  onPressed: () {
                    print('Voice recording started');
                  },
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Container(
                    height: 40,
                    child: TextField(
                      controller: _controller,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                IconButton(
                  icon: Icon(Icons.emoji_emotions),
                  onPressed: _showEmojiPicker,  // 显示表情选择器
                ),
                IconButton(
                  icon: Icon(
                    _isTextEmpty ? Icons.add_circle_outline : Icons.send,
                    color: _isTextEmpty ? Colors.black : Colors.green,
                  ),
                  onPressed: _isTextEmpty ? () {} : _sendMessage,  // 发送消息
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
