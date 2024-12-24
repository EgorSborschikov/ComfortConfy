import 'package:firebase_analytics/firebase_analytics.dart';

class AnalyticsService {
  final FirebaseAnalytics _firebaseAnalytics =  FirebaseAnalytics.instance;

  void logSwitchEvent(String eventName, Map<String, dynamic>? parameters) {
    _firebaseAnalytics.logEvent(
      name: eventName,
      //parameters: parameters,
    );
  }
}