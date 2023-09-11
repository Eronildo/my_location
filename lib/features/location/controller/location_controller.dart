import 'package:flutter/material.dart';

import '../../../core/atomic_state/app_atom.dart';
import '../../../core/exceptions/app_exception.dart';
import '../../../core/exceptions/location_exception.dart';
import '../../../core/extensions/build_context_extension.dart';
import '../atomic_state/location_atoms.dart';
import '../view/pages/location_page.dart';

/// A mixin to LocationPage State
///
/// All stuffs related a [initState], listeners, [SnackBar], [Dialog]s, etc.
mixin LocationController on State<LocationPage> {

  @override
  void initState() {
    super.initState();
    getMyLocationAction();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      locationExceptionState.addListener(_locationExceptionListener);
      isInternetConnectedState.addListener(_internetStatusListener);
    });
  }

  @override
  void dispose() {
    locationExceptionState.removeListener(_locationExceptionListener);
    isInternetConnectedState.removeListener(_internetStatusListener);
    super.dispose();
  }

  void _internetStatusListener() {
    final isConnected = isInternetConnectedState.value;
    var message = '';
    if (isConnected) {
      message = context.i18n.connectionEstablished;
      getMyLocationAction();
    } else {
      message = context.i18n.offline;
    }
    _showSnackbar(message: message);
  }

  void _locationExceptionListener() {
    final locationException = locationExceptionState.value;
    var errorMessage = '';

    if (locationException is NoInternetException) {
      errorMessage = context.i18n.noConnection;
    } else if (locationException is LocationException) {
      errorMessage = context.i18n.approximateLocation;
    }

    _showSnackbar(message: errorMessage);
  }

  void _showSnackbar({required String message}) =>
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
        ),
      );
}
