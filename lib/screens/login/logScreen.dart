import 'package:flutter/material.dart';
import '../../mainScreen.dart';
import 'regScreen.dart';

class logScreen extends StatefulWidget {
  const logScreen({Key? key}) : super(key: key);

  @override
  State<logScreen> createState() => _logScreenState();
}

class _logScreenState extends State<logScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white12,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          // Ermöglicht scrollen wenn z.B im Textfeld
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              children: [
                Image.asset(
                  'assets/images/bild.jpg',
                  height: 140,
                ),
                const Text(
                  "2 von 2 Studenten empfehlen: VeeJob",
                  style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.w900,
                      fontSize: 16),
                ),
                const SizedBox(
                  height: 70,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Melden Sie sich an:",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF665B48),
                        fontSize: 25,
                      ),
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                    // Email Button
                    const Text(
                      "E-Mail Adresse",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 22,
                      ),
                    ),
                    // Abstand zwischen Buttons
                    const SizedBox(height: 9),
                    TextField(
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(
                                color: Colors.white60,
                                width: 3,
                              )),
                          hintText: "E-mail eingeben!",
                          hintStyle: const TextStyle(
                            color: Colors.grey,
                          )),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    // Passwort Button
                    const Text(
                      "Kennwort",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 22,
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      decoration: InputDecoration(
                        suffixIcon: const Icon(
                          Icons.remove_red_eye_outlined,
                          color: Colors.white60,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                            color: Colors.white60,
                            width: 3,
                          ),
                        ),
                        hintText: "Kennwort eingeben!",
                        hintStyle: const TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    // Anmelde Button
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => mainScreen()));
                      },
                      style: OutlinedButton.styleFrom(
                        minimumSize: const Size(400, 50),
                        backgroundColor: const Color(0xFF665B48),
                      ),
                      child: const Text(
                        "Anmelden",
                        style: TextStyle(color: Colors.white60, fontSize: 30),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => regScreen()));
                          },
                          child: const Text(
                            "Registriere dich!",
                            style: TextStyle(
                              color: Color(0xFF665B48),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
