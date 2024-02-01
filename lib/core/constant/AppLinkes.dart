// ignore_for_file: file_names

class AppLink {
  static const String serverLink = 'http://10.0.2.2/chatApp/';
  static const String upload = '${serverLink}upload/';
  static const String api = '${serverLink}api/';
  static const String select = '${serverLink}api/select/';
  static const String insert = '${serverLink}api/insert/';
  static const String update = '${serverLink}api/update/';

//auth
  static const String login = '${api}auth/login.php';

//select

  static const String getSeaSpeGroups = '${select}getSeaSpeGroups.php';
// static const String channel = '${select}channel.php';
// static const String channelForProf = '${select}channelForProfs.php';

//insert
  static const String wsMembers = '${insert}wsmembers.php';
  static const String addWS = '${insert}addWS.php';

//update
  static const String updatetokenandStatus = '${update}updateToken.php';
//workspace
  static const String editWS = '${api}workspace/editWS.php';
  static const String deleteWS = '${api}workspace/deleteWS.php';
//channels
  static const String verifiyJoiningInChannel =
      '${api}channels/verifiy_Joining_in_channel.php';
  static const String getWsUsers = '${api}channels/get_ws_users.php';
  static const String addChannel = '${api}channels/addchannel.php';
  static const String editChannel = '${api}channels/editchannel.php';
  static const String deleteChannel = '${api}channels/deletechannel.php';
  static const String channelForStudent =
      '${api}channels/channelForStudent.php';
  static const String getUsersIsNotInChan =
      "${api}channels/get_ws_users_is_not_in_channel.php";
  static const String addmembers = '${api}channels/addmembers.php';
  static const String join = '${api}channels/join.php';

  //group chat
  static const String groupMessages = '${api}groupChat/getMessages.php';
  static const String removeGroupMessageForYou =
      '${api}groupChat/removeGroupMessageForYou.php';
  //private Chat
  static const String privateMessages = '${api}privateChat/privateMessages.php';
  static const String removeMessageForYou =
      '${api}privateChat/removeMessageForYou.php';
  static const String removeMessageForAll =
      '${api}privateChat/removeMessageForAll.php';

  //conversation
  static const String addConvById = '${api}conversation/addConvById.php';
  static const String addconversation =
      '${api}conversation/addConversation.php';
  static const String updateconversation =
      '${api}conversation/updateConversation.php';
  static const String createContact = '${api}conversation/contact.php';

  //Main
  static const String homeS = '${api}main/homeForStudent.php';
  static const String homeP = '${api}main/homeForProfs.php';

  //Library
  static const String search = '${api}library/search.php';
  static const String filter = '${api}library/filter.php';

  //folders
  static const String foldres = '${api}folders/getFolders.php';
  static const String addFoldres = '${api}folders/addFolders.php';
  static const String editFoldres = '${api}folders/editFolders.php';
  static const String removeFolders = '${api}folders/removeFolders.php';

  //files
  static const String files = '${api}files/getFiles.php';
  static const String addFiles = '${api}files/addFiles.php';
  static const String editFiles = '${api}files/editFiles.php';
  static const String removeFiles = '${api}files/removeFiles.php';
}
