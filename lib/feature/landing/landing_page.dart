import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trade_zila/common/constant/env.dart';
import 'package:trade_zila/common/http/api_provider.dart';
import 'package:trade_zila/common/util/internet_check.dart';
import 'package:trade_zila/common/widget/loading_widget.dart';
import 'package:trade_zila/feature/authentication/bloc/index.dart';
import 'package:trade_zila/feature/home/ui/screen/home_page.dart';
import 'package:trade_zila/feature/landing/splash_page.dart';
import 'package:trade_zila/feature/signin_signup/resources/auth_repository.dart';
import 'package:trade_zila/feature/signin_signup/ui/sign_in_page.dart';

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthenticationBloc, AuthenticationState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is AuthenticationLoading) {
            return const LoadingWidget();
          }

          if (state is AuthenticationAuthenticated) {
            return HomePage();
          }
          if (state is AuthenticationUnauthenticated) {
            return SignInPage(
                authRepository: AuthRepository(
                    env: RepositoryProvider.of<Env>(context),
                    apiProvider: RepositoryProvider.of<ApiProvider>(context),
                    internetCheck:
                        RepositoryProvider.of<InternetCheck>(context)));
          }

          return SplashPage();
        });
  }
}
