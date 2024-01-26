import 'package:flutter/material.dart';

Widget buildStatusIcon(String? status) {
  if (status == 'purchased') {
    return const Icon(
      Icons.check_circle,
      size: 25,
      color: Colors.green,
    );
  } else if (status == 'canceled') {
    return const Icon(
      size: 25,
      Icons.cancel,
      color: Colors.red,
    );
  } else if (status == 'waitingPayment') {
    return const Icon(
      size: 25,
      Icons.warning_rounded,
      color: Colors.amber,
    );
  } else {
    // Tambahkan ikon atau widget lainnya untuk status lainnya jika diperlukan
    return const SizedBox(); // Jika tidak ada ikon yang sesuai, kembalikan widget kosong
  }
}
