
import 'package:flutter/material.dart';
import 'package:peron_project/core/helper/colors.dart';

import 'chat_body_screen.dart';


class ChatViewBody extends StatefulWidget {
  const ChatViewBody({super.key});

  @override
  _ChatViewBodyState createState() => _ChatViewBodyState();
}

class _ChatViewBodyState extends State<ChatViewBody> {
  final List<Map<String, dynamic>> chats = [
    {
      "name": "أمل إبراهيم",
      "lastMessages": "أيوه السعر واحد يافندم",
      "time": "منذ 3 دقائق",
      "image": "assets/images/amll.png",
      "unreadCount": 2,
    },
    {
      "name": "مالك حسن",
      "lastMessages": "تمام",
      "time": "منذ 10 دقائق",
      "image": "assets/images/malek.png",
      "unreadCount": 0,
    },
    {
      "name": "ريهام السيد",
      "lastMessages": "مرحبا و أهلا بكم",
      "time": "منذ 23 دقيقة",
      "image": "assets/images/riham.png",
      "unreadCount": 5,
    }
  ];

  List<Map<String, dynamic>> filteredChats = [];
  Set<int> selectedChats = {};
  bool isSelectionMode = false;

  @override
  void initState() {
    super.initState();
    filteredChats = List.from(chats);
  }

  void _filterChats(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredChats = List.from(chats);
      } else {
        filteredChats = chats.where((chat) {
          return chat["name"]!.toLowerCase().contains(query.toLowerCase());
        }).toList();
      }
    });
  }

  void _toggleSelection(int index) {
    setState(() {
      if (selectedChats.contains(index)) {
        selectedChats.remove(index);
        if (selectedChats.isEmpty) {
          isSelectionMode = false;
        }
      } else {
        selectedChats.add(index);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    var theme=Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text("المحادثات", style: theme.headlineMedium!.copyWith(fontSize: 20)),
        centerTitle: true,
        leading: isSelectionMode
            ? IconButton(
                icon: const Icon(Icons.close),
                onPressed: () {
                  setState(() {
                    isSelectionMode = false;
                    selectedChats.clear();
                  });
                },
              )
            : null,
        actions: [
          PopupMenuButton<String>(
            color: AppColors.scaffoldBackgroundColor,
            onSelected: (value) {
              if (value == "delete") {
                setState(() {
                  selectedChats.forEach((index) {
                    chats.removeAt(index);
                  });
                  selectedChats.clear();
                  isSelectionMode = false;
                });
              } else if (value == "archive" || value == "pin") {
                print("تم اختيار: $value");
              }
            },
            itemBuilder: (context) => [
               PopupMenuItem(
                value: "delete",
                child: Row(
                  children: [
                    Text("حذف",style: theme.labelLarge!.copyWith(color:Color(0xff282929))),
Spacer(),
                    Icon(Icons.delete, color: Colors.grey),
                  ],
                ),
              ),
               PopupMenuItem(
                value: "archive",
                child: Row(
                  children: [
                    Text("أرشيف",style: theme.labelLarge!.copyWith(color:Color(0xff282929)),),
                    Spacer(),
                    Icon(Icons.archive, color: Colors.grey),
                  ],
                ),
              ),
               PopupMenuItem(
                value: "pin",
                child: Row(
                  children: [
                    Text("تثبيت",style: theme.labelLarge!.copyWith(color:Color(0xff282929))),
                    Spacer(),
                    Icon(Icons.push_pin, color: Colors.grey),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(screenWidth * 0.03),
            child: TextField(
              onChanged: _filterChats,
              decoration: InputDecoration(
                hintText: "ابحث عن الاسم...",
                hintStyle: theme.displayMedium!.copyWith(color: Color(0xff818181)),
                prefixIcon: const Icon(Icons.search),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(screenWidth * 0.03),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(screenWidth * 0.03),
                  borderSide: const BorderSide(
                      color: Color.fromARGB(255, 123, 122, 122), width: 2),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredChats.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: screenHeight * 0.005,
                      horizontal: screenWidth * 0.02),
                  child: ListTile(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
                    tileColor: selectedChats.contains(index)
                        ? Colors.grey.shade300
                        : Colors.transparent,
                    leading: Stack(
                      children: [
                        CircleAvatar(
                          backgroundImage:
                              AssetImage(filteredChats[index]["image"]!),
                          radius: screenWidth * 0.08,
                        ),
                        if (selectedChats.contains(index))
                          Positioned(
                            right: 0,
                            bottom: 0,
                            child: Container(
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color.fromARGB(255, 76, 141, 95),
                              ),
                              child: const Icon(Icons.check,
                                  color: Colors.white, size: 18),
                            ),
                          ),
                      ],
                    ),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          filteredChats[index]["name"]!,
                          style:theme.labelLarge!.copyWith(color: Color(0xff231F20)),
                        ),
                        Text(
                          filteredChats[index]["time"]!,
                          style: theme.displayMedium!.copyWith(color: Color(0xff000000))),

                      ],
                    ),
                    subtitle: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            filteredChats[index]["lastMessages"]!,
                            style: theme.bodySmall!.copyWith(color: Color(0xff818181),overflow: TextOverflow.ellipsis)
                        ),),
                        if (filteredChats[index]["unreadCount"] > 0)
                          Container(
                            padding: const EdgeInsets.all(6),
                            decoration: const BoxDecoration(
                              color: Color.fromARGB(255, 76, 141, 95),
                              shape: BoxShape.circle,
                            ),
                            child: Text(
                              "${filteredChats[index]["unreadCount"]}",
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                      ],
                    ),
                    onTap: () {
                      if (isSelectionMode) {
                        _toggleSelection(index);
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ChatBodyScreen(
                              name: filteredChats[index]["name"]!,
                              image: filteredChats[index]["image"]!,
                            ),
                          ),
                        );
                      }
                    },
                    onLongPress: () {
                      setState(() {
                        isSelectionMode = true;
                        _toggleSelection(index);
                      });
                    },
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
