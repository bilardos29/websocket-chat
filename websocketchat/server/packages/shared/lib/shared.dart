/// Support for doing something awesome.
///
/// More dartdocs go here.
library shared;

export './src/dto/chats/chat_dto.dart';
export 'src/dto/group/group_dto.dart';
export './src/dto/group/create_group_dto.dart';
export './src/dto/chats/new_chat_dto.dart';
export './src/dto/group/check_group_dto.dart';
export './src/dto/chats/chat_info_dto.dart';
export './src/dto/user/new_user_dto.dart';
export './src/dto/user/user_dto.dart';
export './src/dto/user/check_user_dto.dart';

export './src/mongo_entity/mongo_group_entity.dart';
export 'src/mongo_entity/mongo_chat_entity.dart';
export 'src/mongo_entity/mongo_user_entity.dart';

export './src/models/chat_model.dart';
export './src/models/group_model.dart';
export './src/models/check_group_model.dart';
export './src/models/chat_info_model.dart';
export './src/models/chat_handler_model.dart';
export './src/models/user_model.dart';
export './src/models/check_user_model.dart';

export './src/utils/utils.dart';
export './src/utils/resource.dart';
export './src/utils/ws_messages.dart';
export './src/utils/group_state.dart';
export './src/utils/user_state.dart';
export './src/utils/ws_close_codes.dart';
export './src/utils/stream_extensions.dart';
export './src/utils/date_formatters.dart';

// TODO: Export any libraries intended for clients of this package.
