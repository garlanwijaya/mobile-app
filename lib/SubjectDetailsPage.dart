import 'package:flutter/material.dart';
import 'meeting.dart';

class SubjectDetailsPage extends StatelessWidget {
  final String subjectName;
  final List<Meeting> meetings;

  const SubjectDetailsPage({
    super.key,
    required this.subjectName,
    required this.meetings,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: subjectName,
        height: 60,
        widthFactor: 0.95,
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: meetings.length,
                itemBuilder: (context, index) {
                  final meeting = meetings[index];
                  return Column(
                    children: [
                      ListTile(
                        title: Text(
                          "Pertemuan ${index + 1}",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        trailing: CircleAvatar(
                          radius: 10,
                          backgroundColor: meeting.isPresent ? Colors.green : Colors.red,
                        ),
                      ),
                      const Divider(
                        thickness: 1,
                        color: Colors.black,
                        height: 0,
                        indent: 16,
                        endIndent: 16,
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final double height;
  final double widthFactor;

  const CustomAppBar({
    super.key,
    required this.title,
    this.height = 60,
    this.widthFactor = 1.0, // Default 100% layar
  });

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double appBarWidth = screenWidth * widthFactor;

    return SafeArea(
      bottom: false,
      child: Align(
        alignment: Alignment.topLeft,
        child: Container(
          height: height,
          width: appBarWidth,
          decoration: BoxDecoration(
            color: Colors.blue[700],
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(0),
              topRight: Radius.circular(0),
              bottomLeft: Radius.circular(0),
              bottomRight: Radius.circular(32),
            ),
          ),
          child: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => Navigator.pop(context),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
