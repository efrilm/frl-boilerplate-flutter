import 'dart:io';

import 'package:frl_boilerplate/constants/common_api_string.dart';
import 'package:frl_boilerplate/constants/common_string.dart';
import 'package:frl_boilerplate/utils/logger.dart';

void createCommonFile(String folder) {
  Logger.section('Generating common $folder...');
  final baseDir = Directory('lib/common/$folder');

  if (!baseDir.existsSync()) {
    baseDir.createSync(recursive: true);
    Logger.success('Created folder: ${baseDir.path}');
  }

  final files = [
    {
      'name': 'api_client.dart',
      'content': CommonFileApiString.apiClient,
      'type': CommonFolderString.api,
      'subPath': '',
    },
    {
      'name': 'api_failure.dart',
      'content': CommonFileApiString.apiFailure,
      'type': CommonFolderString.api,
      'subPath': '',
    },
    {
      'name': 'bad_network_error.dart',
      'content': CommonFileApiString.apiErrorsBadNetwork,
      'type': CommonFolderString.api,
      'subPath': 'errors',
    },
    {
      'name': 'bad_request_error.dart',
      'content': CommonFileApiString.apiErrorsBadRequest,
      'type': CommonFolderString.api,
      'subPath': 'errors',
    },
    {
      'name': 'connection_timeout_error.dart',
      'content': CommonFileApiString.apiErrorsConnectionTimeout,
      'type': CommonFolderString.api,
      'subPath': 'errors',
    },
    {
      'name': 'internal_server_error.dart',
      'content': CommonFileApiString.apiErrorsInternalServerError,
      'type': CommonFolderString.api,
      'subPath': 'errors',
    },
    {
      'name': 'not_found_error.dart',
      'content': CommonFileApiString.apiErrorsNotFound,
      'type': CommonFolderString.api,
      'subPath': 'errors',
    },
    {
      'name': 'unauthorized_error.dart',
      'content': CommonFileApiString.apiErrorsUnauthorized,
      'type': CommonFolderString.api,
      'subPath': 'errors',
    },
    {
      'name': 'bad_network_interceptor.dart',
      'content': CommonFileApiString.apiInterceptorBadNetwork,
      'type': CommonFolderString.api,
      'subPath': 'interceptors',
    },
    {
      'name': 'bad_request_interceptor.dart',
      'content': CommonFileApiString.apiInterceptorBadRequest,
      'type': CommonFolderString.api,
      'subPath': 'interceptors',
    },
    {
      'name': 'connection_timeout_interceptor.dart',
      'content': CommonFileApiString.apiInterceptorConnectionTimeout,
      'type': CommonFolderString.api,
      'subPath': 'interceptors',
    },
    {
      'name': 'internal_server_interceptor.dart',
      'content': CommonFileApiString.apiInterceptorInternalServer,
      'type': CommonFolderString.api,
      'subPath': 'interceptors',
    },
    {
      'name': 'not_found_interceptor.dart',
      'content': CommonFileApiString.apiInterceptorNotFound,
      'type': CommonFolderString.api,
      'subPath': 'interceptors',
    },
    {
      'name': 'unauthorized_interceptor.dart',
      'content': CommonFileApiString.apiInterceptorUnauthorized,
      'type': CommonFolderString.api,
      'subPath': 'interceptors',
    },
    {
      'name': 'app_constant.dart',
      'content': CommonFileString.constans,
      'type': CommonFolderString.constant,
      'subPath': '',
    },
    {
      'name': 'di_auto_route.dart',
      'content': CommonFileString.diAutoRoute,
      'type': CommonFolderString.di,
      'subPath': '',
    },
    {
      'name': 'di_connectivity.dart',
      'content': CommonFileString.diConnectivity,
      'type': CommonFolderString.di,
      'subPath': '',
    },
    {
      'name': 'di_dio.dart',
      'content': CommonFileString.diDio,
      'type': CommonFolderString.di,
      'subPath': '',
    },
    {
      'name': 'di_shared_preferences.dart',
      'content': CommonFileString.diSharedPreference,
      'type': CommonFolderString.di,
      'subPath': '',
    },
    {
      'name': 'component.dart',
      'content': CommonFileString.base,
      'type': CommonFolderString.components,
      'subPath': '',
    },
    {
      'name': 'extension.dart',
      'content': CommonFileString.base,
      'type': CommonFolderString.extension,
      'subPath': '',
    },
    {
      'name': 'app_function.dart',
      'content': CommonFileString.function,
      'type': CommonFolderString.function,
      'subPath': '',
    },
    {
      'name': 'network_client.dart',
      'content': CommonFileString.networkClient,
      'type': CommonFolderString.network,
      'subPath': '',
    },
  ];

  int createdCount = 0;

  final groupFile = files.where((element) => element['type'] == folder);

  for (var file in groupFile) {
    final subPath = file['subPath'] as String;
    final targetDir = subPath.isEmpty ? baseDir : Directory('${baseDir.path}/$subPath');

    // Cek dan buat folder jika belum ada
    if (!targetDir.existsSync()) {
      targetDir.createSync(recursive: true);
      Logger.success('Created subfolder: ${targetDir.path}');
    }

    final filePath = '${targetDir.path}/${file['name']}';
    final fileObj = File(filePath);

    if (fileObj.existsSync()) {
      Logger.warning('File already exists: $filePath');
    } else {
      fileObj.writeAsStringSync(file['content']!);
      Logger.success('Created: $filePath');
      createdCount++;
    }
  }

  if (createdCount > 0) {
    Logger.success('Generated $createdCount $folder file(s) successfully.');
  } else {
    Logger.warning('No $folder files were generated.');
  }
}
