import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:task_manager/bloc/authentication/authentication_bloc.dart';
import 'package:task_manager/bloc/todo_item/todo_item_bloc.dart';
import 'package:task_manager/locator.dart';
import 'package:task_manager/utils/custom_icons_icons.dart';

class UserView extends HookWidget {
  const UserView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        if(state is UnAuthenticated){
          Navigator.pushNamedAndRemoveUntil(context, '/auth', (Route<dynamic> route) => false);
        }
      },
      builder: (context, state) {
        if (state is Authenticated) {
          return Scaffold(
            appBar: AppBar(
              surfaceTintColor: Colors.transparent,
              shadowColor: Color.fromRGBO(245, 247, 248, 0.5019607843137255),
              elevation: 5,
              title: Text(
                'Профиль',
                style: TextStyle(
                    fontFamily: 'Nunito',
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Color.fromRGBO(38, 45, 66, 1.0)
                    // color: Color.fromRGBO(23, 101, 203, 1.0)
                ),
              ),
              centerTitle: true,
              backgroundColor: Color.fromRGBO(255, 255, 255, 1.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(20),
                ),
              ),
            ),
            backgroundColor: Color.fromRGBO(245, 247, 248, 1.0),
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: CircleAvatar(
                      backgroundImage: state.user.avatar != ''
                          ? NetworkImage(state.user.avatar!)
                          : AssetImage('asset/images/default_avatar.png')
                      as ImageProvider,
                      radius: 50,
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.person,
                          size: 20,
                          color: Color.fromRGBO(23, 101, 203, 1.0),
                        ),
                        SizedBox(width: 10),
                        Text(
                          '${state.user.firstName} ${state.user.lastName}',
                          style: TextStyle(
                              fontFamily: 'Nunito',
                              fontSize: 16,
                              color: Color.fromRGBO(38, 45, 66, 1.0)
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.email,
                          size: 20,
                          color: Color.fromRGBO(23, 101, 203, 1.0),
                        ),
                        SizedBox(width: 10),
                        Text(
                          state.user.email,
                          style: TextStyle(
                              fontFamily: 'Nunito',
                              fontSize: 16,
                              color: Color.fromRGBO(38, 45, 66, 1.0)
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.phone,
                          size: 20,
                          color: Color.fromRGBO(23, 101, 203, 1.0),
                        ),
                        SizedBox(width: 10),
                        Text(
                          state.user.phone??'Телефон не указан',
                          style: TextStyle(
                              fontFamily: 'Nunito',
                              fontSize: 16,
                              color: Color.fromRGBO(38, 45, 66, 1.0)
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  TextButton(
                    onPressed: () {
                      BlocProvider.of<AuthenticationBloc>(context).add(Logout());
                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.exit_to_app,
                          size: 20,
                          color: Color.fromRGBO(23, 101, 203, 1.0),
                        ),
                        SizedBox(width: 10),
                        Text(
                          'Выйти из приложения',
                          style: TextStyle(
                              fontFamily: 'Nunito',
                              fontSize: 16,
                              color: Color.fromRGBO(23, 101, 203, 1.0),
                          ),
                        )
                      ],
                    )
                  )
                ],
              ),
            ),
          );
        } else {
          return Scaffold();
        }
      },
    );
  }
}
