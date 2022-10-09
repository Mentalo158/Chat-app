import 'package:flutter/material.dart';
import 'logScreen.dart';

class regScreen extends StatefulWidget {
  const regScreen({Key? key}) : super(key: key);

  @override
  State<regScreen> createState() => _regScreenState();
}

class _regScreenState extends State<regScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white12,
      body: SafeArea(
        // Macht Seite Scrollbar
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Registrieren",
                style: TextStyle(
                  color: Color(0xFF665B48),
                  fontWeight: FontWeight.bold,
                  fontSize: 45,
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              const Text(
                "E-mail Adresse",
                style: TextStyle(
                  color: Colors.white60,
                  fontWeight: FontWeight.w900,
                  fontSize: 17,
                ),
              ),
              TextField(
                decoration: InputDecoration(
                  hintText: "Tragen Sie ihre E-mail Adresse ein",
                  hintStyle: TextStyle(
                    color: Colors.white60,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: Colors.white60,
                      width: 2,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              textBoxes("Passwort eingeben"),
              const SizedBox(
                height: 10,
              ),
              textBoxes("Passwort wiederholen"),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 40,
              ),
              TextButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size(400, 50),
                  backgroundColor: const Color(0xFF665B48),
                ),
                child: const Text(
                  "Registrieren",
                  style: TextStyle(color: Colors.white60, fontSize: 30),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => logScreen()));
                    },
                    child: const Text(
                      "Besitzt du bereits einen Account?",
                      style: TextStyle(
                        color: Color(0xFF665B48),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Column textBoxes(String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            color: Colors.white60,
            fontWeight: FontWeight.w900,
            fontSize: 17,
          ),
        ),
        TextField(
          decoration: InputDecoration(
            suffixIcon: Icon(
              Icons.remove_red_eye_outlined,
              color: Colors.white10,
            ),
            hintText: "Tragen Sie ihr Passwort ein",
            hintStyle: TextStyle(
              color: Colors.white60,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: Colors.white60,
                width: 2,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
