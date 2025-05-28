import 'dart:ui';

import 'package:dyd/core/data/error/expection_c.dart';
import 'package:dyd/core/data/error/failure_c.dart';
import 'package:dyd/core/widget/snackbar/getx_snackbar_widget.dart';
import 'package:flutter/widgets.dart';

enum SnackBarType { success, error }

class ErrorHelper {
  static void handleExceptions({
    required dynamic exception,
    required BuildContext context, // Pass context
  }) {
    if (exception is ServerException) {
      _handleError(message: exception.message, context: context);
    } else if (exception is ServerFailure) {
      _handleError(message: exception.message, context: context);
    } else {
      _handleError(message: exception.toString(), context: context);
    }
  }

  // Show snackbar
  static void _handleError({
    required String message,
    required BuildContext context,
  }) {
    showCustomSnackBar(
      context,
      message,
    );
  }
}
