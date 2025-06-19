import 'package:flutter/material.dart';

class SetStatusPage extends StatelessWidget {
  final List<String> statusOptions = [
    "美滋滋", "梨开", "求锦鲤", "等天晴", "疲倦", "冲", "emo", "胡思乱想",
    "元气满满", "bot", "睡觉", "忙", "摸鱼", "出差", "浪", "打卡", "运动", 
    "喝咖啡", "喝奶茶", "干饭", "带娃", "拯救世界", "自拍", "玩游戏", "听歌"
  ];

  final Function(String) onStatusSelected;

  SetStatusPage({required this.onStatusSelected});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("设置状态"),
        backgroundColor: Colors.grey[100],
      ),
      body: Column(
        children: [
          // Header Text
          Container(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: Text(
              "朋友24小时内可见",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
            ),
          ),
          
          // Grid of status options
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4, // 4 columns in the grid
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 1, // Make each grid item square-shaped
              ),
              itemCount: statusOptions.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    // Set the selected status here
                    print("Selected Status: ${statusOptions[index]}");
                    onStatusSelected(statusOptions[index]); // Pass the selected status to ProfilePage
                    Navigator.pop(context); // Close the SetStatusPage after selection
                  },
                  child: Card(
                    color: Colors.pink[100],
                    child: Center(
                      child: Text(
                        statusOptions[index],
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
