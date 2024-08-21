import 'package:logger/logger.dart';
import 'package:logger/web.dart';

final logger = Logger(
    printer: PrettyPrinter(
  errorMethodCount: 50,
  printEmojis: true,
));
