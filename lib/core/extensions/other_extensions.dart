
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension ExFuture<T> on Future<T> {
  Future<T> trackTime(String label) async {
    final start = DateTime.now();
    final result = await this;
    final end = DateTime.now();
    final duration = end.difference(start);
    debugPrint('$label completed in ${duration.inMilliseconds} ms');
    return result;
  }
} // for example await fetchData().trackTime('Fetch Data');

extension ExIndexedMap<E> on Iterable<E> {
  Iterable<T> mapIndexed<T>(T Function(int index, E element) f) {
    var i = 0;
    return map((e) => f(i++, e));
  }
}  // for example anyList.mapIndexed((i, item) => Text('$i: $item'))


extension ExScreenMetrics on BuildContext {
  MediaQueryData get mq => MediaQuery.of(this);
  double get width => mq.size.width;
  double get height => mq.size.height;
}

extension Extheme on BuildContext {
  ThemeData get theme => Theme.of(this);
  TextTheme get textThemeC => theme.textTheme;
  ColorScheme get colorScheme => theme.colorScheme;

}

extension DateFormatting on String {
  String toFormattedDate({String format = 'd MMMM y'}) {
    try {
      final date = DateTime.parse(this);
      final formatter = DateFormat(format);
      return formatter.format(date);
    } catch (e) {

      return this;
    }
  }
}

extension EmailExtensions on String {
  String get username {
    if (!contains('@')) return this;
    return split('@')[0];
  }
}
