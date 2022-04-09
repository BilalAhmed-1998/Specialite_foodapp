


import 'package:firebase_messaging/firebase_messaging.dart';

import 'local_notifications.dart';

class notificationService{

  static String notification_msg="to be filled";

  static useNotificationService(){

    LocalNotificationService.initialize();
    FirebaseMessaging.instance.getInitialMessage().then((event){

      if(event!=null && event.notification!=null) {
        LocalNotificationService.showNotificationOnForeground(event);
        notification_msg = "${event.notification.title}";
        print("coming from terminated");
      }
      else{
        print("null recieved, terminated");
      }
      //Navigator.pushNamed(context, ref_messages.routeName);

    });
    FirebaseMessaging.onMessageOpenedApp.listen((event) {

      if(event!=null && event.notification!=null) {
        LocalNotificationService.showNotificationOnForeground(event);
        notification_msg = "${event.notification.title}";
        print("coming from background");
      }
      else{
        print("null recieved, background");
      }
      //Navigator.pushNamed(context, ref_messages.routeName);

    });

    FirebaseMessaging.onMessage.listen((event) {
      if(event!=null && event.notification!=null) {
        LocalNotificationService.showNotificationOnForeground(event);
        notification_msg = "${event.notification.title}";
        print("coming from foreground");
      }
      else{
        print("null recieved, foreground");
      }
    });


  }



}