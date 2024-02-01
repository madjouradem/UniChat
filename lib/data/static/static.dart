import '../../core/constant/AppImage.dart';
import '../../core/constant/AppRoute.dart';
import '../models/BNBModel.dart';

List<BNBModel> bnblist = [
  BNBModel(
    name: 'Chats',
    icon: AppImage.conversations,
    route: AppRoute.conversation,
    defaultNum: 0,
  ),
  BNBModel(
      name: 'Workspaces',
      icon: AppImage.people,
      route: AppRoute.ws,
      defaultNum: 1),
  BNBModel(
      name: 'Downloaded',
      icon: AppImage.offlineFile,
      route: AppRoute.downlodedFiles,
      defaultNum: 2),
  BNBModel(
      name: 'Library',
      icon: AppImage.onlineFile,
      route: AppRoute.library,
      defaultNum: 3),
];

List images = [
  'image1.jpg',
  'image2.jpg',
  'image3.jpg',
  'image4.jpg',
  'image5.jpg',
];
