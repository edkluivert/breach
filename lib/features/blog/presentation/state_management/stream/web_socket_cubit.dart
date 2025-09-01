import 'dart:convert';
import 'package:breach/core/core.dart';
import 'package:breach/core/local_data/local_data.dart';
import 'package:breach/features/blog/presentation/state_management/stream/web_socket_state.dart';
import 'package:breach/features/home/data/models/blog_model.dart';
import 'package:breach/features/home/domain/entities/blog_entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:web_socket_channel/web_socket_channel.dart';


@LazySingleton()
class WebSocketCubit extends Cubit<WebSocketState> {
  WebSocketCubit(this.getLoggedInUserToken) : super(const WebSocketInitial());

  WebSocketChannel? _channel;
  final GetLoggedInUserToken getLoggedInUserToken;

  final List<BlogEntity> _blogs = [];

  Future<void> connect() async {
    emit(const WebSocketConnecting());
    try {
      final token = await getLoggedInUserToken.call();
      final uri = Uri.parse('wss://breach-api-ws.qa.mvm-tech.xyz?token=$token');
      _channel = WebSocketChannel.connect(uri);

      emit(const WebSocketConnected());
      emit(WebSocketMessageList(List.from(_blogs)));
      _channel!.stream.listen(
            (event) {
          try {
            final data = jsonDecode(event.toString());
            final blog = BlogModel.fromJson(data as Map<String, dynamic>);
            _blogs.add(blog);
            emit(WebSocketMessageList(List.from(_blogs)));
          } catch (error) {
            AppLogger.d('Failed to parse blog: $error');
          }
        },
        onError: (dynamic error) => emit(WebSocketError(error.toString())),
        onDone: () => emit(const WebSocketDisconnected()),
      );
    } catch (e) {
      emit(WebSocketError(e.toString()));
    }
  }

  void sendMessage(dynamic data) {
    if (_channel != null) {
      final json = jsonEncode(data);
      _channel!.sink.add(json);
    }
  }

  void disconnect() {
    _channel?.sink.close();
    emit(const WebSocketDisconnected());
  }

  void clearMessages() {
    _blogs.clear();
    emit(const WebSocketInitial());
  }
}

