import 'package:admin_dashboard/providers/register_form_provider.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

import 'package:admin_dashboard/router/router.dart';

import 'package:admin_dashboard/ui/inputs/custom_inputs.dart';
import 'package:admin_dashboard/ui/buttons/custom_outlined_button.dart';
import 'package:admin_dashboard/ui/buttons/link_text.dart';
import 'package:provider/provider.dart';

import '../../providers/auth_provider.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => RegisterFormProvider(),
      child: Builder(builder: (context) {
        final registerFormProvider =
            Provider.of<RegisterFormProvider>(context, listen: false);

        return Container(
          margin: const EdgeInsets.only(top: 50),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 370),
              child: Form(
                  autovalidateMode: AutovalidateMode.always,
                  key: registerFormProvider.formKey,
                  child: Column(
                    children: [
                      // name
                      TextFormField(
                        onChanged: (value) => registerFormProvider.name = value,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'El nombre es obligatorio';
                          }
                          return null;
                        },
                        style: const TextStyle(
                            color: Color.fromARGB(255, 66, 66, 66)),
                        decoration: CustomInputs.loginInputDecoration(
                            hint: 'Ingrese su nombre',
                            label: 'Nombre',
                            icon: Icons.supervised_user_circle_sharp),
                      ),

                      const SizedBox(height: 20),

                      // Email
                      TextFormField(
                        onChanged: (value) =>
                            registerFormProvider.email = value,
                        validator: (value) {
                          //Si no es un email se disparara ese mensaje
                          if (!EmailValidator.validate(value ?? '')) {
                            return 'Email no valido';
                          }
                          return null;
                        },
                        style: const TextStyle(
                            color: Color.fromARGB(255, 66, 66, 66)),
                        decoration: CustomInputs.loginInputDecoration(
                            hint: 'Ingrese su correo',
                            label: 'Email',
                            icon: Icons.email_outlined),
                      ),

                      const SizedBox(height: 20),

                      // Password
                      TextFormField(
                        onChanged: (value) =>
                            registerFormProvider.password = value,
                        validator: (value) {
                          //Si no se ingresa un valor, pedira la contraseña
                          if (value == null || value.isEmpty) {
                            return 'Ingrese su contraseña';
                          }
                          //Si la contraseña es menor a 6  dijitos, la vuelve apedir
                          if (value.length < 6) {
                            return 'Su contraseña debe tener minimo 6 digitos';
                          }
                          return null; //valido
                        },
                        obscureText: true,
                        style: const TextStyle(
                            color: Color.fromARGB(255, 66, 66, 66)),
                        decoration: CustomInputs.loginInputDecoration(
                            hint: '*********',
                            label: 'Contraseña',
                            icon: Icons.lock_outline_rounded),
                      ),

                      const SizedBox(height: 20),
                      CustomOutlinedButton(
                        onPressed: () {
                          final validForm = registerFormProvider.validateForm();
                          if (!validForm) return;
                          print('Email: ${registerFormProvider.email}');
                          print('PassWord: ${registerFormProvider.password}');
                          print('Name: ${registerFormProvider.name}');

                          final authProvider =
                              Provider.of<AuthProvider>(context, listen: false);
                          authProvider.register(
                              registerFormProvider.email,
                              registerFormProvider.password,
                              registerFormProvider.name);
                        },
                        text: 'Crear cuenta',
                      ),

                      const SizedBox(height: 20),
                      LinkText(
                        text: 'Ir al login',
                        onPressed: () {
                          Navigator.pushReplacementNamed(
                              context, Flurorouter.loginRoute);
                        },
                      )
                    ],
                  )),
            ),
          ),
        );
      }),
    );
  }
}
