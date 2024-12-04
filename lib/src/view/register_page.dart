import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/others/custom_snackbar.dart';
import 'package:flutter_application_1/src/service/AuthService.dart';
import 'package:flutter_application_1/src/view/login_page.dart';

class RegisterPage extends StatefulWidget {
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController usernameController = TextEditingController();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final TextEditingController confirmPasswordController =
      TextEditingController();

  final Authservice authservice = Authservice();

  _newUser() {
    if (_formKey.currentState!.validate()) {

      var username = usernameController.text;
      var email = emailController.text;
      var password = passwordController.text;

      authservice.create(username, email, password).then((String? erro) {
        if (erro != null) {
          CustomSnackbar.show(context, erro, isSuccess: false);
          return;
        }

        CustomSnackbar.show(context, 'Cadastro realizado com sucesso!', isSuccess: true);

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LoginPage(),
          ),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cadastro"),
        backgroundColor: Colors.blue[800],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Ícone superior
                CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.blue[800],
                  child: Icon(
                    Icons.person_add,
                    size: 40,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 32),
        
                // Formulário
                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                      ),
                    ],
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: usernameController,
                          decoration: InputDecoration(
                            labelText: "Nome de usuário",
                            border: OutlineInputBorder(),
                            prefixIcon:
                                Icon(Icons.person, color: Colors.blue[800]),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Por favor, insira um nome de usuário.";
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 16),
                        TextFormField(
                          controller: emailController,
                          decoration: InputDecoration(
                            labelText: "Email",
                            border: OutlineInputBorder(),
                            prefixIcon:
                                Icon(Icons.email, color: Colors.blue[800]),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Por favor, insira seu email.";
                            } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                                .hasMatch(value)) {
                              return "Insira um email válido.";
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 16),
                        TextFormField(
                          controller: passwordController,
                          decoration: InputDecoration(
                            labelText: "Senha",
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.lock, color: Colors.blue[800]),
                          ),
                          obscureText: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Por favor, insira sua senha.";
                            } else if (value.length < 6) {
                              return "A senha deve ter pelo menos 6 caracteres.";
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 16),
                        TextFormField(
                          controller: confirmPasswordController,
                          decoration: InputDecoration(
                            labelText: "Confirmar Senha",
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.lock, color: Colors.blue[800]),
                          ),
                          obscureText: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Por favor, confirme sua senha.";
                            } else if (value != passwordController.text) {
                              return "As senhas não coincidem.";
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _newUser,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue[800],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    "Cadastrar",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
