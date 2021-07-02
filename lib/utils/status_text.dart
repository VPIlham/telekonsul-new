import 'package:flutter/material.dart';

class StatusText extends StatefulWidget {
  final String text;
  const StatusText({Key key, @required this.text}) : super(key: key);

  @override
  _StatusTextState createState() => _StatusTextState();
}

class _StatusTextState extends State<StatusText> {
  @override
  Widget build(BuildContext context) {
    return Text(
      widget.text,
      style: TextStyle(
        color: widget.text == "Menunggu Pembayaran" ||
                widget.text == "Menunggu Konfirmasi"
            ? Colors.lightBlue
            : widget.text == "Sukses"
                ? Colors.greenAccent
                : Colors.redAccent,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
