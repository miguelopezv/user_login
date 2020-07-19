import 'package:flutter/material.dart';
import '../bloc/provider.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          Stack(children: <Widget>[_createBG(context), _createLogin(context)]),
    );
  }

  Widget _createBG(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final backgroundColor = Container(
      height: size.height * 0.4,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: <Color>[
          Color.fromRGBO(63, 63, 156, 1),
          Color.fromRGBO(90, 70, 178, 1)
        ]),
      ),
    );

    final circle = Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: Color.fromRGBO(255, 255, 255, 0.05)),
    );

    final icon = Container(
      padding: EdgeInsets.only(top: 80),
      child: Column(
        children: <Widget>[
          Icon(
            Icons.person_pin_circle,
            color: Colors.white,
            size: 100,
          ),
          SizedBox(width: double.infinity, height: 10),
          Text(
            'Welcome',
            style: TextStyle(color: Colors.white, fontSize: 25),
          ),
        ],
      ),
    );

    return Stack(
      children: <Widget>[
        backgroundColor,
        Positioned(child: circle, top: 90, left: 30),
        Positioned(child: circle, top: -40, right: -30),
        Positioned(child: circle, bottom: -50, right: -10),
        Positioned(child: circle, bottom: 120, right: 20),
        Positioned(child: circle, bottom: -50, left: -20),
        icon
      ],
    );
  }

  Widget _createLogin(BuildContext context) {
    final bloc = Provider.of(context);
    final size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SafeArea(
            child: Container(height: 180),
          ),
          Container(
            width: size.width * 0.85,
            margin: EdgeInsets.symmetric(vertical: 30),
            padding: EdgeInsets.symmetric(vertical: 50),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 3,
                    offset: Offset(0, 5),
                    spreadRadius: 3,
                  ),
                ]),
            child: Column(children: [
              Text('Login', style: TextStyle(fontSize: 20)),
              SizedBox(height: 60),
              _createEmail(bloc),
              SizedBox(height: 30),
              _createPassword(bloc),
              SizedBox(height: 30),
              _createButton(bloc)
            ]),
          ),
          Text('Forgot password?'),
          SizedBox(
            height: 100,
          )
        ],
      ),
    );
  }

  Widget _createEmail(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.emailStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: TextField(
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
                errorText: snapshot.error,
                icon: Icon(Icons.alternate_email, color: Colors.deepPurple),
                hintText: 'example@mail.com',
                labelText: 'E-mail'),
            onChanged: bloc.changeEmail,
          ),
        );
      },
    );
  }

  Widget _createPassword(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.passwordStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: TextField(
            obscureText: true,
            decoration: InputDecoration(
                errorText: snapshot.error,
                icon: Icon(Icons.lock_outline, color: Colors.deepPurple),
                labelText: 'Password'),
            onChanged: bloc.changePassword,
          ),
        );
      },
    );
  }

  Widget _createButton(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.loginFormStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return RaisedButton(
          child: Container(
              padding: EdgeInsets.symmetric(horizontal: 80, vertical: 15),
              child: Text('Login')),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          elevation: 0,
          color: Colors.deepPurple,
          textColor: Colors.white,
          onPressed: snapshot.hasData ? () => _login(context) : null,
        );
      },
    );
  }

  _login(BuildContext context) {
    Navigator.pushReplacementNamed(context, 'home');
  }
}
