import 'package:evently_app/ui/model/event_dm.dart';
import 'package:evently_app/ui/screens/edit_event/edit_event_screen.dart';
import 'package:flutter/material.dart';
import '../screens/add_event/add_event_screen.dart';
import '../screens/event_details/event_details_screen.dart';
import '../screens/login/login_screen.dart';
import '../screens/navigation/navigation_screen.dart';
import '../screens/register/register_screen.dart';

abstract final class AppRoutes {
  static MaterialPageRoute get login =>
      MaterialPageRoute(builder: (_) => const LoginScreen());

  static MaterialPageRoute get register =>
      MaterialPageRoute(builder: (_) => const RegisterScreen());

  static MaterialPageRoute get navigation =>
      MaterialPageRoute(builder: (_) => const NavigationScreen());

  static MaterialPageRoute get addEvent =>
      MaterialPageRoute(builder: (_) => const AddEventScreen());

  static MaterialPageRoute eventDetails(EventDM event) =>
      MaterialPageRoute(builder: (_) => EventDetailsScreen(event: event));

  static MaterialPageRoute editEvent(EventDM event) =>
      MaterialPageRoute(builder: (_) => EditEventScreen(event: event));
}
