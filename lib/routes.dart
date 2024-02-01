import 'package:flutter_chatapp/Pages/AddChanMember/AddChanMemberView.dart';
import 'package:flutter_chatapp/Pages/Channels/ChannelView.dart';
import 'package:flutter_chatapp/Pages/ChatRoom/chatroomView.dart';
import 'package:flutter_chatapp/Pages/CreateWS/CreateWSView.dart';
import 'package:flutter_chatapp/Pages/EditFolders/EditFoldersView.dart';
import 'package:flutter_chatapp/Pages/Files/FilesView.dart';
import 'package:flutter_chatapp/Pages/Main/Conversation/conversationView.dart';
import 'package:flutter_chatapp/Pages/Main/workspace/workspacesView.dart';
import 'package:flutter_chatapp/Pages/Login/LogInView.dart';
import 'package:flutter_chatapp/Pages/VeiwFiles/VeiwFilesView.dart';
import 'package:flutter_chatapp/core/bindings/MainBinding.dart';
import 'package:flutter_chatapp/core/bindings/MyBinding.dart';
import 'package:flutter_chatapp/core/constant/AppRoute.dart';
import 'package:flutter_chatapp/core/middleware/MyMiddlewere.dart';
import 'package:get/get.dart';

import 'Pages/AddFiles/AddFilesView.dart';
import 'Pages/AddFolders/AddFoldersView.dart';
import 'Pages/CreateChannel/CreateChannelView.dart';
import 'Pages/CreateConversation.dart/CreateConversationView.dart';
import 'Pages/DownlodedFiles/DownlodedFilesView.dart';
import 'Pages/EditChannel/EditChannelView.dart';
import 'Pages/EditFiles/EditFilesView.dart';
import 'Pages/EditWS/EditWSView.dart';
import 'Pages/Folders/FoldersView.dart';
import 'Pages/GroupChatRoom/GroupchatroomView.dart';
import 'Pages/GroupVeiwFiles/GroupVeiwFilesView.dart';
import 'Pages/GroupmoreInfo/GroupMoreInfoView.dart';
import 'Pages/VeiwFiles/widgets/showVideo.dart';
import 'Pages/library/LibraryView.dart';
import 'Pages/moreInfoConv/MoreInfoConvView.dart';
import 'core/calsses/ImageViwer.dart';

List<GetPage<dynamic>> routes = [
  GetPage(name: '/', page: () => const LogIn(), middlewares: [MyMiddlewere()]),
  GetPage(name: AppRoute.login, page: () => const LogIn()),
  GetPage(
      name: AppRoute.conversation,
      page: () => const Conversations(),
      bindings: [
        MyBinding(),
        MainBinding(),
      ]),
  GetPage(name: AppRoute.ws, page: () => const Workspaces()),
  GetPage(name: AppRoute.createcontact, page: () => const CreateConversation()),
  GetPage(name: AppRoute.createws, page: () => const CreateWS()),
  GetPage(name: AppRoute.channel, page: () => const Channel()),
  GetPage(name: AppRoute.chatroom, page: () => const ChatRoom()),
  GetPage(name: AppRoute.groupchatroom, page: () => const Groupchatroom()),
  GetPage(name: AppRoute.createChannel, page: () => const CreateChannel()),
  GetPage(name: AppRoute.moreInfoConv, page: () => const MoreInfoConv()),
  GetPage(name: AppRoute.veiwFiles, page: () => const VeiwFiles()),
  GetPage(name: AppRoute.groupmoreInfoConv, page: () => const GroupMoreInfo()),
  GetPage(name: AppRoute.groupveiwFiles, page: () => const GroupVeiwFiles()),
  GetPage(name: AppRoute.showVideo, page: () => const ShowVideo()),
  GetPage(name: AppRoute.addChanMember, page: () => const AddChanMember()),
  GetPage(name: AppRoute.editWS, page: () => const EditWS()),
  GetPage(name: AppRoute.editChannel, page: () => const EditChannel()),
  GetPage(name: AppRoute.imageViwer, page: () => const ImageViwer()),
  GetPage(name: AppRoute.downlodedFiles, page: () => const DownlodedFiles()),
  GetPage(name: AppRoute.library, page: () => const Library()),
  GetPage(name: AppRoute.folders, page: () => const Folders()),
  GetPage(name: AppRoute.addFolders, page: () => const AddFolders()),
  GetPage(name: AppRoute.editFolders, page: () => const EditFolders()),
  GetPage(name: AppRoute.files, page: () => const Files()),
  GetPage(name: AppRoute.addFiles, page: () => const AddFiles()),
  GetPage(name: AppRoute.editFiles, page: () => const EditFiles()),
];
