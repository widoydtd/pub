import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:precoder/home.dart';
import 'package:precoder/login.dart';
import 'package:precoder/register.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  Firebase.initializeApp();
  runApp(MyApp());
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Color.fromARGB(255, 0, 0, 0), // status bar color
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User>(
      stream: FirebaseAuth.instance.authStateChanges().cast<User>(),
      builder: (context, AsyncSnapshot<User> snapshot) {
        if (snapshot.hasData) {
          return WillPopScope(
            onWillPop: () async {
              return false;
            },
            child: MaterialApp(
              home: HomePage(),
              debugShowCheckedModeBanner: false,
            ),
          );
          // return HomePage();
        } else {
          return MaterialApp(
            home: MainPage(title: 'PreCoder'),
            debugShowCheckedModeBanner: false,
          );
          // return ProfilePicturePage();
        }
      },
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key, required this.title});
  final String title;

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.fromLTRB(50, 150, 50, 10),
              child: Image.asset(
                'assets/PreCoder.png',
                height: 60,
                width: 300,
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 20),
              height: 60,
              width: 300,
              child: Text(
                'Access algorithm and programming courses and other interesting features from your phone',
                style: TextStyle(fontSize: 16),
              ),
            ),
            Container(
                height: 60,
                width: 300,
                margin: const EdgeInsets.only(top: 20),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RegisterPage()),
                    );
                  },
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      backgroundColor: MaterialStateProperty.all(
                          Color.fromARGB(255, 0, 105, 120))),
                  child: Text('Register',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 20)),
                )),
            Container(
                height: 60,
                width: 300,
                margin: const EdgeInsets.fromLTRB(50, 20, 50, 0),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                    );
                  },
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      backgroundColor: MaterialStateProperty.all(
                          Color.fromARGB(255, 0, 105, 120))),
                  child: Text('Login',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 20)),
                )),
          ],
        ),
      ),
    );
  }
}
