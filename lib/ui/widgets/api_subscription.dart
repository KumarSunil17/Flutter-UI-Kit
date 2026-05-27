import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_uikit/model/fetch_process.dart';
import 'package:flutter_uikit/ui/widgets/common_dialogs.dart';
import 'package:flutter_uikit/utils/uidata.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

StreamSubscription<FetchProcess> apiSubscription(
    Stream<FetchProcess> apiResult, BuildContext context) {
  return apiResult.listen((FetchProcess p) {
    if (p.loading) {
      showProgress(context);
    } else {
      hideProgress(context);
      final response = p.response;
      if (response == null || response.success == false) {
        if (response != null) {
          fetchApiResult(context, response);
        }
      } else {
        switch (p.type) {
          case ApiType.performLogin:
            showSuccess(context, UIData.success, FontAwesomeIcons.check);
            break;
          case ApiType.getProductInfo:
          case ApiType.performOTP:
          case null:
            break;
        }
      }
    }
  });
}
