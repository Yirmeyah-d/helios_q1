import 'package:flutter/material.dart';

class UserDetailsView extends StatelessWidget {
  const UserDetailsView({Key? key}) : super(key: key);
  static const routeName = '/user_details';

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final Map<String, dynamic> user =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Details'),
      ),
      body: Container(
        height: 450,
        child: Stack(
          children: [
            Positioned(
              top: 35,
              left: 20,
              child: Material(
                child: Container(
                  height: 300,
                  width: width * 0.9,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.blue.withOpacity(0.3),
                        offset: Offset(-10, 10),
                        blurRadius: 20,
                        spreadRadius: 4,
                      )
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              top: 50,
              left: 30,
              child: Card(
                elevation: 5,
                shadowColor: Colors.blue,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                child: Container(
                  height: 200,
                  width: 150,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                          image: NetworkImage(user["profilePicture"]),
                          fit: BoxFit.fill)),
                ),
              ),
            ),
            Positioned(
              top: 60,
              left: 200,
              child: Container(
                height: 280,
                width: 180,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Name: ${user["name"]}",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const Divider(
                      color: Colors.black,
                    ),
                    Text(
                      "Age: ${user["age"]}",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const Divider(
                      color: Colors.black,
                    ),
                    Text(
                      "Email: ${user["email"]}",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const Divider(
                      color: Colors.black,
                    ),
                    Text(
                      "Phone number: ${user["phoneNumber"]}",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const Divider(
                      color: Colors.black,
                    ),
                    Text(
                      "Address: ${user["street"]}",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const Divider(
                      color: Colors.black,
                    ),
                    Text(
                      "City: ${user["city"]}",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const Divider(
                      color: Colors.black,
                    ),
                    Text(
                      "Post Code: ${user["postCode"]}",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
