import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Color.fromRGBO(38, 50, 56, 1),
        body: LoginScreen(),
      ),
    );
  }
}

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String correctPassword = 'admin';
  String animationType = 'idle';

  final passwordController = TextEditingController();

  final passwordFocusNode = FocusNode();
  final usernameFocusNode = FocusNode();

  @override
  void initState() {
    passwordFocusNode.addListener(() {
      if (passwordFocusNode.hasFocus) {
        setState(() {
          animationType = 'hands_up';
        });
      } else {
        setState(() {
          animationType = 'hands_down';
        });
      }
    });

    usernameFocusNode.addListener(() {
      if (usernameFocusNode.hasFocus) {
        setState(() {
          animationType = 'test';
        });
      } else {
        setState(() {
          animationType = 'idle';
        });
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(
        horizontal: 20,
      ),
      child: Column(
        children: <Widget>[
          Container(
            height: 300,
            width: 300,
            child: FlareActor(
              'assets/Teddy.flr',
              alignment: Alignment.bottomCenter,
              fit: BoxFit.contain,
              animation: animationType,
              callback: (animation) {
                setState(() {
                  animationType = 'idle';
                });
              },
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(20),
              ),
              color: Colors.white,
            ),
            child: Column(
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Username",
                    contentPadding: EdgeInsets.all(20),
                  ),
                  focusNode: usernameFocusNode,
                ),
                Divider(),
                TextFormField(
                  obscureText: true,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Password",
                    contentPadding: EdgeInsets.all(20),
                  ),
                  controller: passwordController,
                  focusNode: passwordFocusNode,
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            height: 70,
            padding: EdgeInsets.only(top: 20),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.pink,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              onPressed: () => signIn(),
              child: Text(
                "Submit",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void signIn() {
    if (animationType == 'hands_up') {
      setState(() {
        animationType = 'hands_down';
      });
    }

    if (passwordController.text.compareTo(correctPassword) == 0) {
      setState(() {
        animationType = "success";
      });
    } else {
      setState(() {
        animationType = "fail";
      });
    }
  }
}
