import 'package:breach/features/home/domain/entities/blog_entity.dart';
import 'package:equatable/equatable.dart';

abstract class WebSocketState extends Equatable {
  const WebSocketState();

  @override
  List<Object?> get props => [];
}

class WebSocketInitial extends WebSocketState {
  const WebSocketInitial();
}

class WebSocketConnecting extends WebSocketState {
  const WebSocketConnecting();
}

class WebSocketConnected extends WebSocketState {
  const WebSocketConnected();
}

class WebSocketDisconnected extends WebSocketState {
  const WebSocketDisconnected();
}


class WebSocketMessageList extends WebSocketState {
  const WebSocketMessageList(this.blogs);

  final List<BlogEntity> blogs;

  @override
  List<Object?> get props => [blogs];
}

class WebSocketError extends WebSocketState {
  const WebSocketError(this.message);
  final String message;

  @override
  List<Object?> get props => [message];
}
