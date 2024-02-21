import 'package:admin_dashboard/providers/auth_provider.dart';
import 'package:admin_dashboard/providers/login_form_provider.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

import 'package:admin_dashboard/router/router.dart';

import 'package:admin_dashboard/ui/inputs/custom_inputs.dart';
import 'package:admin_dashboard/ui/buttons/custom_outlined_button.dart';
import 'package:admin_dashboard/ui/buttons/link_text.dart';
import 'package:provider/provider.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);

  
  @override
  Widget build(BuildContext context) {

    final authProvider = Provider.of<AuthProvider>(context);

    return ChangeNotifierProvider(
     create: (_) => LoginFormProvider(),
      child: Builder(builder: (context){

        final loginFormProvider = Provider.of<LoginFormProvider>(context, listen: false);
        return Container(
        margin: const EdgeInsets.only(top: 100),
        padding: const EdgeInsets.symmetric( horizontal: 20 ),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints( maxWidth: 370 ),
            //Formulario
            child: Form(
              autovalidateMode: AutovalidateMode.always,
             key: loginFormProvider.formKey,
              child: Column(
                children: [
                  
                  // Email
                  TextFormField(
                    onFieldSubmitted:( _ ) => onFormSubmit(loginFormProvider, authProvider),
                    validator: (value){
                      //Si no es un email se disparara ese mensaje
                      if( !EmailValidator.validate(value?? '') ) return 'Email no valido';
                      
                      return null;
                    },
                    onChanged: ( value ) => loginFormProvider.email = value,
                    style: const TextStyle( color: Colors.black ),
                    decoration: CustomInputs.loginInputDecoration(
                      hint: 'Ingrese su correo',
                      label: 'Email',
                      icon: Icons.email_outlined
                    ),
                  ),
      
                  const SizedBox( height: 20 ),
      
                  // Password
                  TextFormField(
                    onFieldSubmitted: ( _ ) => onFormSubmit(loginFormProvider, authProvider),
                    onChanged: ( value ) => loginFormProvider.password = value,
                    validator: (value){
                      //Si no se ingresa un valor, pedira la contraseña
                      if (value == null || value.isEmpty) return 'Ingrese su contraseña';
                      //Si la contraseña es menor a 6  dijitos, la vuelve apedir
                      if (value.length<6) return 'Su contraseña debe tener minimo 6 digitos';
                      return null; //valido
      
                    },
                    obscureText: true,
                    style: const TextStyle( color: Colors.black ),
                    decoration: CustomInputs.loginInputDecoration(
                      hint: '*********',
                      label: 'Contraseña',
                      icon: Icons.lock_outline_rounded
                    ),
                  ),
                  
                  const SizedBox( height: 20 ),
                  CustomOutlinedButton(
                    onPressed: () => onFormSubmit(loginFormProvider, authProvider),
                    text: 'Ingresar',
                    //
                  ),
      
      
                  const SizedBox( height: 20 ),
                  LinkText(
                    text: 'Nueva cuenta',
                    onPressed: () {
                      Navigator.pushReplacementNamed( context, Flurorouter.registerRoute );
                    },
                  )
      
                ],
              )
            ),
          ),
        ),
      );
      })
    );
  }

  void onFormSubmit(LoginFormProvider loginFormProvider, AuthProvider authProvider){
    final isValid = loginFormProvider.validateForm();
    if (isValid) {
      authProvider.login(loginFormProvider.email, loginFormProvider.password);
    }

  }

}