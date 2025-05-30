import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trade_zila/common/constant/env.dart';
import 'package:trade_zila/common/http/api_provider.dart';
import 'package:trade_zila/common/route/routes.dart';
import 'package:trade_zila/common/util/internet_check.dart';
import 'package:trade_zila/feature/authentication/bloc/index.dart';
import 'package:trade_zila/feature/home/bloc/index.dart';
import 'package:trade_zila/feature/home/resource/home_repository.dart';
import 'package:trade_zila/feature/home/ui/widget/home_widget.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueGrey,
          title: const Text('Books'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.adjust),
              onPressed: () {
                BlocProvider.of<AuthenticationBloc>(context).add(LoggedOut());
                Navigator.pushReplacementNamed(context, Routes.landing);
              },
            ),
          ],
        ),
        body: BlocProvider(
            create: (context) => BooksBloc(
                homeRepository: HomeRepository(
                    env: RepositoryProvider.of<Env>(context),
                    apiProvider: RepositoryProvider.of<ApiProvider>(context),
                    internetCheck:
                        RepositoryProvider.of<InternetCheck>(context)))
              ..add(Fetch()),
            child: Container(child: const HomeWidget())));
  }
}
