import 'package:flutter/material.dart';
import 'package:flutter_application_1/registerscreen.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Login extends StatefulWidget {
  @override
  State<Login> createState() => LoginState();
}

class LoginState extends State<Login> {
  TextEditingController nameTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();

  bool _passwordVisible = true;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
            appBar: AppBar(title: const Text("Homestay Raya"), actions: [
              IconButton(
                  onPressed: registerForm,
                  icon: const Icon(Icons.app_registration))
            ]),
            body: SingleChildScrollView(
              child: Card(
                elevation: 9,
                margin: const EdgeInsets.all(8),
                child: Container(
                  padding: EdgeInsets.all(15),
                  child: Form(
                    child: Column(children: [
                      TextFormField(
                          controller: nameTextEditingController,
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
                          controller: passwordTextEditingController,
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
                        child: const Text("Login"),
                      )
                    ]),
                  ),
                ),
              ),
            )));
  }

  void registerForm() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => registerScreen()));
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
    String name = nameTextEditingController.text;
    String password = passwordTextEditingController.text;

    if (password != password) {
      Fluttertoast.showToast(
          msg: "Please check your passsword",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          fontSize: 14.0);
      return;
    }
  }
}
