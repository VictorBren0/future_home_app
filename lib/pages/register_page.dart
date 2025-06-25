import 'package:flutter/material.dart';
import 'package:future_home_app/providers/auth_provider.dart';
import 'package:future_home_app/routes.dart';
import 'package:future_home_app/widgets/input.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  void handleRegister() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    final confirmPassword = _confirmPasswordController.text.trim();

    if (password != confirmPassword) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('As senhas não coincidem')));
      return;
    }

    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final response = await authProvider.signUpUser(email, password);

    if (!mounted) return;

    if (response) {
      Navigator.pushReplacementNamed(context, Routes.HOME);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(authProvider.message ?? 'Ocorreu um erro.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    return Scaffold(
      backgroundColor: const Color(0xFF0A1A3C),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0A1A3C),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            double verticalSpacing = isPortrait ? size.height * 0.1 : 20;

            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: size.width < 400 ? 16 : 24,
                vertical: 20,
              ),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 500),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(height: verticalSpacing),
                        Text(
                          'Crie sua conta',
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: theme.colorScheme.primary,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          'Preencha os campos abaixo para se registrar no aplicativo.',
                          style: TextStyle(fontSize: 16, color: Colors.white70),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 32),

                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Input(
                                key: const Key('email-input'),
                                controller: _emailController,
                                label: "Email",
                                isRequired: true,
                                onChange: (_) {},
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return 'Campo obrigatório';
                                  }
                                  if (!RegExp(
                                    r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                                  ).hasMatch(value.trim())) {
                                    return 'Email inválido';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 16),

                              Input(
                                key: const Key('password-input'),
                                controller: _passwordController,
                                label: "Senha",
                                isRequired: true,
                                obscureText: true,
                                onChange: (_) {},
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return 'Campo obrigatório';
                                  }
                                  if (value.length < 6) {
                                    return 'Senha deve ter pelo menos 6 caracteres';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 16),

                              Input(
                                key: const Key('confirm-password-input'),
                                controller: _confirmPasswordController,
                                label: "Confirmar Senha",
                                isRequired: true,
                                obscureText: true,
                                onChange: (_) {},
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return 'Campo obrigatório';
                                  }
                                  if (value !=
                                      _passwordController.text.trim()) {
                                    return 'As senhas não coincidem';
                                  }
                                  return null;
                                },
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 32),

                        // Botão
                        ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState?.validate() ?? false) {
                              handleRegister();
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size.fromHeight(50),
                            backgroundColor: theme.colorScheme.primary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text(
                            'Cadastrar',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
