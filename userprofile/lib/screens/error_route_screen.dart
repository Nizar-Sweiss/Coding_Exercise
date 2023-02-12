import 'package:flutter/material.dart';
import 'package:userprofile/style/app_style.dart';

class ErrorRouteScreen extends StatelessWidget {
  const ErrorRouteScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Error Route"),
        elevation: 0,
        backgroundColor: red_tint_1,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _errorRouteIcon(),
            _errorRouteText(),
            _errorRouteTextButton()
          ],
        ),
      ),
    );
  }

  sendErrorMessageCode() {
    // TODO: handle message code request
  }
  TextButton _errorRouteTextButton() {
    return TextButton.icon(
      onPressed: sendErrorMessageCode(),
      icon: const Icon(
        Icons.send,
        color: light_blue_tint_2,
      ),
      label: const Text(
        "Send Error",
        style: TextStyle(color: light_blue_tint_2),
      ),
      style: TextButton.styleFrom(
        side: const BorderSide(width: 2, color: light_blue_tint_2),
      ),
    );
  }

  Text _errorRouteText() => const Text(
        "Route Does not exist,\nWould you like to submit this error?",
        style: TextStyle(color: red_error),
      );

  Icon _errorRouteIcon() {
    return const Icon(
      Icons.error,
      size: 100,
      color: light_blue_tint_2,
    );
  }
}
