import 'package:rxdart/rxdart.dart';

import '/backend/schema/structs/index.dart';
import 'custom_auth_manager.dart';

class DistributorAppAuthUser {
  DistributorAppAuthUser({
    required this.loggedIn,
    this.uid,
    this.userData,
  });

  bool loggedIn;
  String? uid;
  UserStruct? userData;
}

/// Generates a stream of the authenticated user.
BehaviorSubject<DistributorAppAuthUser> distributorAppAuthUserSubject =
    BehaviorSubject.seeded(DistributorAppAuthUser(loggedIn: false));
Stream<DistributorAppAuthUser> distributorAppAuthUserStream() =>
    distributorAppAuthUserSubject
        .asBroadcastStream()
        .map((user) => currentUser = user);
