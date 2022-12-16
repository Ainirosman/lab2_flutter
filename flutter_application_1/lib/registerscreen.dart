import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/config.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';

class registerScreen extends StatefulWidget {
  @override
  State<registerScreen> createState() => registerScreenState();
}

class registerScreenState extends State<registerScreen> {
  final TextEditingController nameEditingController = TextEditingController();
  final TextEditingController emailEditingController = TextEditingController();
  final TextEditingController phoneEditingController = TextEditingController();
  final TextEditingController passEditingController = TextEditingController();

  bool _isChecked = false;
  bool _passwordVisible = true;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var passwordVisible = _passwordVisible;
    return Scaffold(
        appBar: AppBar(
          title: Text('Registration'),
        ),
        body: Center(
            child: SingleChildScrollView(
          child: Card(
            elevation: 9,
            margin: const EdgeInsets.all(8),
            child: Container(
              padding: EdgeInsets.all(15),
              child: Form(
                key: _formKey,
                child: Column(children: [
                  TextFormField(
                      controller: emailEditingController,
                      keyboardType: TextInputType.emailAddress,
                      validator: (val) => val!.isEmpty ||
                              !val.contains("@") ||
                              !val.contains(".")
                          ? "Enter a valid email"
                          : null,
                      decoration: const InputDecoration(
                          labelText: "email",
                          labelStyle: TextStyle(),
                          icon: Icon(Icons.email),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(width: 1.5),
                          ))),
                  TextFormField(
                      controller: nameEditingController,
                      keyboardType: TextInputType.text,
                      validator: (val) => val!.isEmpty || (val.length < 3)
                          ? "Name must longer than 5"
                          : null,
                      decoration: const InputDecoration(
                          labelText: "name",
                          labelStyle: TextStyle(),
                          icon: Icon(Icons.person),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(width: 1.5),
                          ))),
                  TextFormField(
                      controller: phoneEditingController,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                          labelText: "phone",
                          labelStyle: TextStyle(),
                          icon: Icon(Icons.phone),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(width: 1.5),
                          ))),
                  TextFormField(
                      controller: passEditingController,
                      keyboardType: TextInputType.visiblePassword,
                      validator: (val) => validatePassword(val.toString()),
                      obscureText: _passwordVisible,
                      decoration: InputDecoration(
                        labelText: "password",
                        labelStyle: const TextStyle(),
                        icon: const Icon(Icons.password),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(width: 1.5),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _passwordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: () => setState(() {
                            _passwordVisible = !_passwordVisible;
                          }),
                        ),
                      )),
                  const SizedBox(
                    height: 8,
                  ),
                  MaterialButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    minWidth: 115,
                    onPressed: _registerAccount,
                    elevation: 10,
                    color: Theme.of(context).colorScheme.primary,
                    child: const Text("Register"),
                  )
                ]),
              ),
            ),
          ),
        )));
  }

  String? validatePassword(String value) {
    String pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{6,}$';
    RegExp regex = RegExp(pattern);
    if (value.isEmpty) {
      return 'Please enter password';
    } else {
      if (!regex.hasMatch(value)) {
        return 'Enter valid password';
      } else {
        return null;
      }
    }
  }

  void _registerAccount() {
    String name = nameEditingController.text;
    String email = emailEditingController.text;
    String phone = phoneEditingController.text;
    String password = passEditingController.text;

    if (!_formKey.currentState!.validate()) {
      Fluttertoast.showToast(
          msg: "Please complete the registration form first",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          fontSize: 14.0);
      return;
    }
    if (password != password) {
      Fluttertoast.showToast(
          msg: "Please check your passsword",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          fontSize: 14.0);
      return;
    }
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          title: const Text(
            "Register new account?",
            style: TextStyle(),
          ),
          content: const Text("Are you sure?", style: TextStyle()),
          actions: <Widget>[
            TextButton(
              child: const Text(
                "Yes",
                style: TextStyle(),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                register_user(name, email, phone, password);
              },
            ),
            TextButton(
              child: const Text(
                "No",
                style: TextStyle(),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void register_user(String name, String email, String phone, String password) {
    http
        .post(
      Uri.parse(
          "http://localhost/homestayRaya/php/htdocs/homestayRaya/php/registration.php"),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "email": email,
        "name": name,
        "phone": phone,
        "password": password,
        "register": "register"
      }),
    )
        .then((response) {
      print(response.body);
    });
  }
}
