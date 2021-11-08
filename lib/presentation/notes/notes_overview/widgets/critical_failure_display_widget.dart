import 'package:flutter/material.dart';

import '../../../../domain/notes/note_failure.dart';

class CriticalFailureDisplay extends StatelessWidget {
  final NoteFailure failure;
  const CriticalFailureDisplay({
    Key? key,
    required this.failure,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            '⚠️',
            style: TextStyle(fontSize: 100),
          ),
          Text(
            failure.maybeMap(
                insufficientPermission: (_) => 'Insuficient permissions',
                orElse: () => 'Unexpected error. \nPlease contact support'),
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 24),
          ),
          TextButton(
            onPressed: () {
              print('Sending email!');
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: const <Widget>[
                Icon(Icons.mail),
                SizedBox(width: 4),
                Text(
                  "I NEED HELP",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
