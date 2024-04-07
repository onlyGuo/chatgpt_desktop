class ChatMessage {
  String content;
  String role;
  String time;
  String toolsCallId;
  ToolCalls? toolCalls;

  ChatMessage({
    required this.content,
    required this.role,
    required this.time,
    this.toolsCallId = "",
    this.toolCalls
  });

  // toJson
  Map<String, dynamic> toJson() => {
    'content': content,
    'role': role,
    'time': time,
    'toolsCallId': toolsCallId
  };

  // fromJson
  ChatMessage.fromJson(Map<String, dynamic> json)
      : content = json['content'],
        role = json['role'],
        time = json['time'],
        toolsCallId = json['toolsCallId'] ?? "";
}


class ToolCalls{
  String id;
  String type;
  ToolCallsFunction function;

  ToolCalls({required this.id, required this.type, required this.function});

  toJson(){
    return {
      "id": id,
      "type": type,
      "function": function.toJson()
    };
  }

  ToolCalls.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        type = json['type'],
        function = ToolCallsFunction.fromJson(json['function']);

  Map<String, dynamic> toMap(){
    return {
      "id": id,
      "type": type,
      "function": function.toJson()
    };
  }
}

class ToolCallsFunction{
  String name;
  String arguments;

  ToolCallsFunction({required this.name, required this.arguments});

  toJson(){
    return {
      "name": name,
      "arguments": arguments
    };
  }

  ToolCallsFunction.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        arguments = json['arguments'];
}