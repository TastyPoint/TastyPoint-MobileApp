import 'package:flutter/material.dart';
import 'package:tasty/api/Service.dart';
import 'package:tasty/api/UserProfile.dart';
class profile extends StatefulWidget {
  final int userId;

  const profile({Key? key, required this.userId}) : super(key: key);

  @override
  State<profile> createState() => _profileState();
}


class _profileState extends State<profile> {
  UserProfile? userProfile;

  @override
  void initState() {
    super.initState();
    _fetchUserProfile();
  }

  void _fetchUserProfile() async {
    userProfile = await service.getUserProfileById(widget.userId);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEEE7CF),
      appBar: AppBar(
        backgroundColor: Color(0xFFEFBC3D),
        elevation: 0,
        title: Text(
          "Bienvenido a Tasty Point :D",
          style: TextStyle(
            color: Color(0xFF3a3737),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: userProfile != null
            ? Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Nombre:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              userProfile!.name,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              'Email:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              userProfile!.phoneNumber,
              style: TextStyle(fontSize: 16),
            ),
          ],
        )
            : Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
