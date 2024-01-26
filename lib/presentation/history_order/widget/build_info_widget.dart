import 'package:flutter/material.dart';

Widget buildOrderInfo(String label, dynamic value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      children: [
        Text(
          '$label: ',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.grey[600],
          ),
        ),
        Text(
          value != null ? '$value' : '-',
          style: TextStyle(
            color: Colors.grey[800],
          ),
        ),
      ],
    ),
  );
}
