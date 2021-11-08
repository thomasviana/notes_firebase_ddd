import 'package:another_flushbar/flushbar_helper.dart';
// ignore: implementation_imports
import 'package:auto_route/src/router/auto_router_x.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../application/auth/sign_in_form/bloc/sign_in_form_bloc.dart';
import '../../../application/auth/auth_bloc.dart';
import '../../routes/app_router.dart';

class SignInForm extends StatelessWidget {
  const SignInForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignInFormBloc, SignInFormState>(
      listener: (context, state) {
        state.authFailureOrSuccessOption.fold(
            () => {},
            (either) => either.fold(
                  (failure) => {
                    FlushbarHelper.createError(
                        message: failure.map(
                      cancelledByUser: (_) => 'Cancelled',
                      serverError: (_) => 'Server Error',
                      emailAlreadyInUser: (_) => 'Email already in use',
                      invalidEmailAndPasswordCombination: (_) =>
                          'Invalid email and password combination',
                    )).show(context)
                  },
                  (_) => {
                    context.router.replace(const NotesOverviewRoute()),
                    context
                        .read<AuthBloc>()
                        .add(const AuthEvent.authCheckRequested())
                  },
                ));
      },
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            // ignore: deprecated_member_use
            autovalidate: state.showErrorMessages,
            child: ListView(
              children: [
                const Text(
                  '📝',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 130),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.email),
                    label: Text('Email'),
                  ),
                  autocorrect: false,
                  onChanged: (value) => context
                      .read<SignInFormBloc>()
                      .add(SignInFormEvent.emailChanged(value)),
                  validator: (_) => context
                      .read<SignInFormBloc>()
                      .state
                      .emailAddress
                      .value
                      .fold(
                        (f) => f.maybeMap(
                          invalidEmail: (_) => 'Invalid Email',
                          orElse: () => null,
                        ),
                        (r) => null,
                      ),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.lock),
                    label: Text('Password'),
                  ),
                  autocorrect: false,
                  obscureText: true,
                  onChanged: (value) => context
                      .read<SignInFormBloc>()
                      .add(SignInFormEvent.passwordChanged(value)),
                  validator: (_) =>
                      context.read<SignInFormBloc>().state.password.value.fold(
                            (f) => f.maybeMap(
                              shortPassword: (_) => 'Short Password',
                              orElse: () => null,
                            ),
                            (r) => null,
                          ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () {
                          context.read<SignInFormBloc>().add(
                              const SignInFormEvent
                                  .signInWithEmailAndPasswordPressed());
                        },
                        child: const Text('SIGN-IN'),
                      ),
                    ),
                    Expanded(
                      child: TextButton(
                        onPressed: () {
                          context.read<SignInFormBloc>().add(
                              const SignInFormEvent
                                  .registerWithEmailAndPasswordPressed());
                        },
                        child: const Text('REGISTER'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () {
                    context
                        .read<SignInFormBloc>()
                        .add(const SignInFormEvent.signInWithGooglePressed());
                  },
                  child: const Text('SIGN-IN WITH GOOGLE'),
                ),
                if (state.isSubmitting) ...[
                  const SizedBox(height: 8),
                  const LinearProgressIndicator(),
                ]
              ],
            ),
          ),
        );
      },
    );
  }
}
