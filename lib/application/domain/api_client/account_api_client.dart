import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:movie_night/application/configuration/firebase_configuration.dart';
import 'package:movie_night/application/domain/entities/complaint_review.dart';
import 'package:movie_night/application/domain/entities/user.dart' as otherUser;

import '../entities/review.dart';
import 'api_client_exception.dart';

class AccountApiClient {
  final _db = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  final _storage = FirebaseStorage.instance;

  String get uid => _auth.currentUser!.uid;

  Future<bool> uploadProfileImage({
    required String fileName,
    required File file,
  }) async {
    return await _uploadImage(
      imagesStorage: FirebaseConfiguration.userProfileImagesStorage,
      fileName: fileName,
      file: file,
      collectionName: FirebaseConfiguration.usersCollection,
      fieldName: FirebaseConfiguration.urlProfileImageField,
      deleteBeforeImage: true,
    );
  }

  Future<void> setUserName(String name) async {
    return await _setUserField(name, FirebaseConfiguration.nameField);
  }

  Future<String> fetchUserProfileImageUrl([String? id]) async {
    final url = await _fetchUserField(FirebaseConfiguration.urlProfileImageField, id);
    return url ?? '';
  }

  Future<String> fetchUserName([String? id]) async {
    final name = await _fetchUserField(FirebaseConfiguration.nameField, id);
    return name ?? '';
  }

  Future<void> favoriteMovie(String movieId) async {
    return await _favorite(movieId, FirebaseConfiguration.moviesField);
  }

  Future<void> favoriteTvShow(String tvShowId) async {
    return await _favorite(tvShowId, FirebaseConfiguration.tvShowsField);
  }

  Future<void> favoritePerson(String personId) async {
    return await _favorite(personId, FirebaseConfiguration.peopleField);
  }

  Future<void> favoriteUser(String userId) async {
    await Future.wait<void>([
      _favorite(userId, FirebaseConfiguration.usersField),
      _addToSubscribers(uid, userId, FirebaseConfiguration.usersField),
    ]);
  }

  Future<bool?> isFavoriteMovie(String movieId) async {
    return await _isFavorite(movieId, FirebaseConfiguration.moviesField);
  }

  Future<bool?> isFavoriteTvShow(String tvShowId) async {
    return await _isFavorite(tvShowId, FirebaseConfiguration.tvShowsField);
  }

  Future<bool?> isFavoritePerson(String personId) async {
    return await _isFavorite(personId, FirebaseConfiguration.peopleField);
  }

  Future<bool?> isFavoriteUser(String userId) async {
    return await _isFavorite(userId, FirebaseConfiguration.usersField);
  }

  Future<void> watchMovie(String movieId) async {
    return await _watch(movieId, FirebaseConfiguration.moviesField);
  }

  Future<void> watchTvShow(String tvShowId) async {
    return await _watch(tvShowId, FirebaseConfiguration.tvShowsField);
  }

  Future<void> allowShowFavoriteMovies() async {
    return await _allowShow(FirebaseConfiguration.allowShowFavoriteMovieField);
  }

  Future<void> allowShowFavoriteAndNotWatchedMovies() async {
    return await _allowShow(FirebaseConfiguration.allowShowFavoritesAndNotWatchedMovieField);
  }

  Future<void> allowShowWatchedMovies() async {
    return await _allowShow(FirebaseConfiguration.allowShowWatchedMovieField);
  }

  Future<void> allowShowFavoriteTvShows() async {
    return await _allowShow(FirebaseConfiguration.allowShowFavoriteTvShowsField);
  }

  Future<void> allowShowFavoriteAndNotWatchedTvShows() async {
    return await _allowShow(FirebaseConfiguration.allowShowFavoritesAndNotWatchedTvShowsField);
  }

  Future<void> allowShowWatchedTvShows() async {
    return await _allowShow(FirebaseConfiguration.allowShowWatchedTvShowsField);
  }

  Future<void> allowShowFavoriteActors() async {
    return await _allowShow(FirebaseConfiguration.allowShowFavoritePeopleField);
  }

  Future<bool?> isAllowShowFavoriteMovies([String? userId]) async {
    return await _isAllowShow(FirebaseConfiguration.allowShowFavoriteMovieField, userId);
  }

  Future<bool?> isAllowShowFavoriteAndNotWatchedMovies([String? userId]) async {
    return await _isAllowShow(
        FirebaseConfiguration.allowShowFavoritesAndNotWatchedMovieField, userId);
  }

  Future<bool?> isAllowShowWatchedMovies([String? userId]) async {
    return await _isAllowShow(FirebaseConfiguration.allowShowWatchedMovieField, userId);
  }

  Future<bool?> isAllowShowFavoriteTvShows([String? userId]) async {
    return await _isAllowShow(FirebaseConfiguration.allowShowFavoriteTvShowsField, userId);
  }

  Future<bool?> isAllowShowFavoriteAndNotWatchedTvShows([String? userId]) async {
    return await _isAllowShow(
        FirebaseConfiguration.allowShowFavoritesAndNotWatchedTvShowsField, userId);
  }

  Future<bool?> isAllowShowWatchedTvShows([String? userId]) async {
    return await _isAllowShow(FirebaseConfiguration.allowShowWatchedTvShowsField, userId);
  }

  Future<bool?> isAllowShowFavoriteActors([String? userId]) async {
    return await _isAllowShow(FirebaseConfiguration.allowShowFavoritePeopleField, userId);
  }

  Future<bool?> isWatchedMovie(String movieId) async {
    return await _isWatched(movieId, FirebaseConfiguration.moviesField);
  }

  Future<bool?> isWatchedTvShow(String tvShowId) async {
    return await _isWatched(tvShowId, FirebaseConfiguration.tvShowsField);
  }

  Future<List<String>> fetchWatchedMovies([String? userId]) async {
    return await _fetchWatchedList(FirebaseConfiguration.moviesField, userId);
  }

  Future<List<String>> fetchWatchedTvShows([String? userId]) async {
    return await _fetchWatchedList(FirebaseConfiguration.tvShowsField, userId);
  }

  Future<List<String>> fetchFavoriteMovies([String? userId]) async {
    return await _fetchFavoriteList(FirebaseConfiguration.moviesField, userId);
  }

  Future<List<String>> fetchFavoriteTvShows([String? userId]) async {
    return await _fetchFavoriteList(FirebaseConfiguration.tvShowsField, userId);
  }

  Future<List<String>> fetchFavoritePeople([String? userId]) async {
    return await _fetchFavoriteList(FirebaseConfiguration.peopleField, userId);
  }

  Future<List<String>> fetchFavoriteUsers([String? userId]) async {
    return await _fetchFavoriteList(FirebaseConfiguration.usersField, userId);
  }

  Future<List<String>> fetchSubscribers([String? userId]) async {
    return await _fetchSubscribersList(userId);
  }

  Future<List<String>> fetchFavoriteAndNotWatchedMovies([String? userId]) async {
    return await _fetchFavoriteAndNotWatchedList(FirebaseConfiguration.moviesField, userId);
  }

  Future<List<String>> fetchFavoriteAndNotWatchedTvShows([String? userId]) async {
    return await _fetchFavoriteAndNotWatchedList(FirebaseConfiguration.tvShowsField, userId);
  }

  Stream<List<otherUser.User>> usersStream(String query) => _usersStream(query)
          .transform<List<otherUser.User>>(StreamTransformer.fromHandlers(handleData: (data, sink) {
        final users = data.docs
            .map((doc) {
              final user = otherUser.User.fromJson(doc.data());
              return user.copyWith(uid: doc.id);
            })
            .where((element) =>
                element.name != null && element.name!.contains(query) && uid != element.uid)
            .toList()
          ..sort(((a, b) => a.name!.compareTo(b.name!)));

        sink.add(users);
      }));

  Stream<DocumentSnapshot<Map<String, dynamic>>> favoriteStream([String? userId]) =>
      _favoriteStream(userId);

  Stream<DocumentSnapshot<Map<String, dynamic>>> watchedStream([String? userId]) =>
      _watchedStream(userId);

  Stream<otherUser.User> userStream([String? userId]) => _userStream(userId)
          .transform<otherUser.User>(StreamTransformer.fromHandlers(handleData: (data, sink) {
        final user = otherUser.User.fromJson(data.data()!).copyWith(uid: data.id);
        sink.add(user);
      }));

  Stream<QuerySnapshot<Map<String, dynamic>>> reviewsStream(String id) => _reviewsStream(id);

  Future<void> _favorite(String id, String field) async {
    try {
      final userFavorite = _db.collection(FirebaseConfiguration.favoriteCollection).doc(uid);
      List<dynamic> list = [];
      try {
        list = (await userFavorite.get()).get(field) as List<dynamic>;
      } catch (e) {}
      list.contains(id) ? list.remove(id) : list.add(id);
      final data = {
        field: list.toSet().toList(),
      };
      await userFavorite.set(data, SetOptions(merge: true));
    } on FirebaseAuthException catch (e) {
      _handleException(e);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> _addToSubscribers(String whoId, String whomId, String field) async {
    try {
      final subscribers = _db.collection(FirebaseConfiguration.subscribersCollection).doc(whomId);
      List<dynamic> list = [];
      try {
        list = (await subscribers.get()).get(field) as List<dynamic>;
      } catch (e) {}
      list.contains(whoId) ? list.remove(whoId) : list.add(whoId);
      final data = {
        field: list.toSet().toList(),
      };
      await subscribers.set(data, SetOptions(merge: true));
    } on FirebaseAuthException catch (e) {
      _handleException(e);
    } catch (e) {
      rethrow;
    }
  }

  Future<bool?> _isFavorite(String id, String field) async {
    try {
      final userFavorite = _db.collection(FirebaseConfiguration.favoriteCollection).doc(uid);
      List<dynamic> list = [];
      try {
        list = (await userFavorite.get()).get(field) as List<dynamic>;
      } catch (e) {
        return Future.value(false);
      }
      return list.contains(id);
    } on FirebaseAuthException catch (e) {
      _handleException(e);
    } catch (e) {
      rethrow;
    }
    return null;
  }

  Future<bool> _uploadImage({
    required String imagesStorage,
    required String fileName,
    required File file,
    String? collectionName,
    String? fieldName,
    bool deleteBeforeImage = false,
  }) async {
    final completer = Completer<bool>();
    final uploadTask = _storage.ref().child(imagesStorage).child(fileName).putFile(file);
    uploadTask.snapshotEvents.listen((event) async {
      if (event.state == TaskState.error) {
        completer.complete(false);
      }
      if (event.state == TaskState.success) {
        if (collectionName != null && fieldName != null) {
          if (deleteBeforeImage) {
            final url = await fetchUserProfileImageUrl();
            if (url.isNotEmpty) {
              _storage.refFromURL(url).delete();
            }
          }
          uploadTask.snapshot.ref.getDownloadURL().then((url) {
            final data = {fieldName: url};
            _db.collection(collectionName).doc(uid).set(data, SetOptions(merge: true));
          });
        }
        completer.complete(true);
      }
    });
    return completer.future;
  }

  Future<void> _setUserField(String value, String field) async {
    try {
      final userData = _db.collection(FirebaseConfiguration.usersCollection).doc(uid);
      final data = {
        field: value,
      };
      await userData.set(data, SetOptions(merge: true));
    } on FirebaseAuthException catch (e) {
      _handleException(e);
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> _fetchUserField(String field, [String? id]) async {
    try {
      final userData = _db.collection(FirebaseConfiguration.usersCollection).doc(id ?? uid);
      try {
        return (await userData.get()).get(field);
      } catch (e) {
        return Future.value(null);
      }
    } on FirebaseAuthException catch (e) {
      _handleException(e);
    } catch (e) {
      rethrow;
    }
    return null;
  }

  Future<void> _watch(String id, String field) async {
    try {
      final userWatched = _db.collection(FirebaseConfiguration.watchedCollection).doc(uid);
      List<dynamic> list = [];
      try {
        list = (await userWatched.get()).get(field) as List<dynamic>;
      } catch (e) {}
      list.contains(id) ? list.remove(id) : list.add(id);
      final data = {
        field: list.toSet().toList(),
      };
      await userWatched.set(data, SetOptions(merge: true));
    } on FirebaseAuthException catch (e) {
      _handleException(e);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> _allowShow(String field) async {
    try {
      final userData = _db.collection(FirebaseConfiguration.settingsCollection).doc(uid);
      late final bool value;
      try {
        value = (await userData.get()).get(field) as bool;
      } catch (e) {
        value = false;
      }
      final data = {
        field: !value,
      };
      await userData.set(data, SetOptions(merge: true));
    } on FirebaseAuthException catch (e) {
      _handleException(e);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> sendReview({required String mediaId, required Review review}) async {
    try {
      _db
          .collection(FirebaseConfiguration.mediaCollection)
          .doc(mediaId)
          .collection(FirebaseConfiguration.reviewsCollection)
          .add({
        FirebaseConfiguration.userIdField: uid,
        FirebaseConfiguration.reviewField: review.review,
        FirebaseConfiguration.dateField: Timestamp.fromDate(review.date),
      });
    } on FirebaseAuthException catch (e) {
      _handleException(e);
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> sendComplaintToReview(ComplaintReview complaintReview) async {
    try {
      _db.collection(FirebaseConfiguration.complaintsReviewsCollection).add({
        FirebaseConfiguration.reviewIdField: complaintReview.reviewId,
        FirebaseConfiguration.accusedUserIdField: complaintReview.accusedUserId,
        FirebaseConfiguration.complainingUserIdField: complaintReview.complainingUserId ?? uid,
        FirebaseConfiguration.complaintMessageField: complaintReview.complaintMessage,
        FirebaseConfiguration.reviewMessageField: complaintReview.reviewMessage,
      });
      return true;
    } on FirebaseAuthException catch (e) {
      _handleException(e);
    } catch (e) {
      rethrow;
    }
    return false;
  }

  Future<void> deleteReview({
    required String reviewId,
    required String mediaId,
  }) async {
    try {
      _db
          .collection(FirebaseConfiguration.mediaCollection)
          .doc(mediaId)
          .collection(FirebaseConfiguration.reviewsCollection)
          .doc(reviewId)
          .delete();
    } on FirebaseAuthException catch (e) {
      _handleException(e);
    } catch (e) {
      rethrow;
    }
  }

  Future<bool?> _isWatched(String id, String field) async {
    try {
      final userWatched = _db.collection(FirebaseConfiguration.watchedCollection).doc(uid);
      List<dynamic> list = [];
      try {
        list = (await userWatched.get()).get(field) as List<dynamic>;
      } catch (e) {
        return Future.value(false);
      }
      return list.contains(id);
    } on FirebaseAuthException catch (e) {
      _handleException(e);
    } catch (e) {
      rethrow;
    }
    return null;
  }

  Future<bool?> _isAllowShow(String field, [String? userId]) async {
    try {
      final userAllowShow =
          _db.collection(FirebaseConfiguration.settingsCollection).doc(userId ?? uid);
      try {
        return (await userAllowShow.get()).get(field) as bool;
      } catch (e) {
        return Future.value(false);
      }
    } on FirebaseAuthException catch (e) {
      _handleException(e);
    } catch (e) {
      rethrow;
    }
    return null;
  }

  Future<List<String>> _fetchWatchedList(String field, [String? userId]) async {
    try {
      final userWatched =
          _db.collection(FirebaseConfiguration.watchedCollection).doc(userId ?? uid);
      List<dynamic> list = [];
      try {
        list = (await userWatched.get()).get(field) as List<dynamic>;
      } catch (e) {
        return Future.value([]);
      }
      return list.cast<String>();
    } on FirebaseAuthException catch (e) {
      _handleException(e);
    } catch (e) {
      rethrow;
    }
    return [];
  }

  Future<List<String>> _fetchFavoriteList(String field, [String? userId]) async {
    try {
      final userFavorite =
          _db.collection(FirebaseConfiguration.favoriteCollection).doc(userId ?? uid);
      List<dynamic> list = [];
      try {
        list = (await userFavorite.get()).get(field) as List<dynamic>;
      } catch (e) {
        return Future.value([]);
      }
      return list.cast<String>();
    } on FirebaseAuthException catch (e) {
      _handleException(e);
    } catch (e) {
      rethrow;
    }
    return [];
  }

  Future<List<String>> _fetchSubscribersList([String? userId]) async {
    try {
      final userSubscribers =
          _db.collection(FirebaseConfiguration.subscribersCollection).doc(userId ?? uid);
      List<dynamic> list = [];
      try {
        list = (await userSubscribers.get()).get(FirebaseConfiguration.usersField) as List<dynamic>;
      } catch (e) {
        return Future.value([]);
      }
      return list.cast<String>();
    } on FirebaseAuthException catch (e) {
      _handleException(e);
    } catch (e) {
      rethrow;
    }
    return [];
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> _reviewsStream(String id) => _db
      .collection(FirebaseConfiguration.mediaCollection)
      .doc(id)
      .collection(FirebaseConfiguration.reviewsCollection)
      .snapshots();

  Stream<QuerySnapshot<Map<String, dynamic>>> _usersStream(String query) =>
      _db.collection(FirebaseConfiguration.usersCollection).snapshots();

  Stream<DocumentSnapshot<Map<String, dynamic>>> _favoriteStream([String? userId]) =>
      _db.collection(FirebaseConfiguration.favoriteCollection).doc(userId ?? uid).snapshots();

  Stream<DocumentSnapshot<Map<String, dynamic>>> _watchedStream([String? userId]) =>
      _db.collection(FirebaseConfiguration.watchedCollection).doc(userId ?? uid).snapshots();

  Stream<DocumentSnapshot<Map<String, dynamic>>> _userStream([String? userId]) =>
      _db.collection(FirebaseConfiguration.usersCollection).doc(userId ?? uid).snapshots();

  Future<List<String>> _fetchFavoriteAndNotWatchedList(String field, [String? userId]) async {
    try {
      final userFavorite =
          _db.collection(FirebaseConfiguration.favoriteCollection).doc(userId ?? uid);
      final userWatched =
          _db.collection(FirebaseConfiguration.watchedCollection).doc(userId ?? uid);
      List<dynamic> listFavorite = [];
      List<dynamic> listWatched = [];
      try {
        listFavorite = (await userFavorite.get()).get(field) as List<dynamic>;
        listWatched = (await userWatched.get()).get(field) as List<dynamic>;
      } catch (e) {
        return Future.value([]);
      }
      final result = listFavorite.where((element) => !listWatched.contains(element)).toList();
      return result.cast<String>();
    } on FirebaseAuthException catch (e) {
      _handleException(e);
    } catch (e) {
      rethrow;
    }
    return [];
  }

  void _handleException(FirebaseException e) {
    if (e.code.compareTo('user-not-found') == 0) {
      throw ApiClientException('user-not-found', e.message);
    } else if (e.code.compareTo('invalid-email') == 0) {
      throw ApiClientException('invalid-email', e.message);
    } else if (e.code.compareTo('not-verified') == 0) {
      throw ApiClientException('not-verified', e.message);
    } else if (e.code.compareTo('wrong-password') == 0) {
      throw ApiClientException('wrong-password', e.message);
    } else if (e.code.compareTo('weak-password') == 0) {
      throw ApiClientException('weak-password', e.message);
    } else if (e.code.compareTo('email-already-in-use') == 0) {
      throw ApiClientException('email-already-in-use', e.message);
    } else if (e.code.compareTo('too-many-requests') == 0) {
      throw ApiClientException('too-many-requests', e.message);
    } else {
      throw ApiClientException('unknown-error', e.message);
    }
  }
}
