import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:movie_night/application/configuration/firebase_configuration.dart';
import 'package:movie_night/application/domain/entities/complaint_review.dart';

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
    final url =
        await _fetchUserField(FirebaseConfiguration.urlProfileImageField, id);
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

  Future<bool?> isFavoriteMovie(String movieId) async {
    return await _isFavorite(movieId, FirebaseConfiguration.moviesField);
  }

  Future<bool?> isFavoriteTvShow(String tvShowId) async {
    return await _isFavorite(tvShowId, FirebaseConfiguration.tvShowsField);
  }

  Future<bool?> isFavoritePerson(String personId) async {
    return await _isFavorite(personId, FirebaseConfiguration.peopleField);
  }

  Future<void> watchMovie(String movieId) async {
    return await _watch(movieId, FirebaseConfiguration.moviesField);
  }

  Future<void> watchTvShow(String tvShowId) async {
    return await _watch(tvShowId, FirebaseConfiguration.tvShowsField);
  }

  Future<bool?> isWatchedMovie(String movieId) async {
    return await _isWatched(movieId, FirebaseConfiguration.moviesField);
  }

  Future<bool?> isWatchedTvShow(String tvShowId) async {
    return await _isWatched(tvShowId, FirebaseConfiguration.tvShowsField);
  }

  Future<List<String>> fetchWatchedMovies() async {
    return await _fetchWatchedList(FirebaseConfiguration.moviesField);
  }

  Future<List<String>> fetchWatchedTvShows() async {
    return await _fetchWatchedList(FirebaseConfiguration.tvShowsField);
  }

  Future<List<String>> fetchFavoriteMovies() async {
    return await _fetchFavoriteList(FirebaseConfiguration.moviesField);
  }

  Future<List<String>> fetchFavoriteTvShows() async {
    return await _fetchFavoriteList(FirebaseConfiguration.tvShowsField);
  }

  Future<List<String>> fetchFavoritePeople() async {
    return await _fetchFavoriteList(FirebaseConfiguration.peopleField);
  }

  Future<List<String>> fetchFavoriteAndNotWatchedMovies() async {
    return await _fetchFavoriteAndNotWatchedList(
        FirebaseConfiguration.moviesField);
  }

  Future<List<String>> fetchFavoriteAndNotWatchedTvShows() async {
    return await _fetchFavoriteAndNotWatchedList(
        FirebaseConfiguration.tvShowsField);
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> favoriteStream() =>
      _favoriteStream();

  Stream<DocumentSnapshot<Map<String, dynamic>>> watchedStream() =>
      _watchedStream();

  Stream<DocumentSnapshot<Map<String, dynamic>>> userStream() => _userStream();

  Stream<QuerySnapshot<Map<String, dynamic>>> reviewsStream(String id) =>
      _reviewsStream(id);

  Future<void> _favorite(String id, String field) async {
    try {
      final userFavorite =
          _db.collection(FirebaseConfiguration.favoriteCollection).doc(uid);
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

  Future<bool?> _isFavorite(String id, String field) async {
    try {
      final userFavorite =
          _db.collection(FirebaseConfiguration.favoriteCollection).doc(uid);
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
    final uploadTask =
        _storage.ref().child(imagesStorage).child(fileName).putFile(file);
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
            _db
                .collection(collectionName)
                .doc(uid)
                .set(data, SetOptions(merge: true));
          });
        }
        completer.complete(true);
      }
    });
    return completer.future;
  }

  Future<void> _setUserField(String value, String field) async {
    try {
      final userData =
          _db.collection(FirebaseConfiguration.usersCollection).doc(uid);
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
      final userData =
          _db.collection(FirebaseConfiguration.usersCollection).doc(id ?? uid);
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
      final userWatched =
          _db.collection(FirebaseConfiguration.watchedCollection).doc(uid);
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

  Future<void> sendReview(
      {required String mediaId, required Review review}) async {
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
        FirebaseConfiguration.complainingUserIdField:
            complaintReview.complainingUserId ?? uid,
        FirebaseConfiguration.complaintMessageField:
            complaintReview.complaintMessage,
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
      final userWatched =
          _db.collection(FirebaseConfiguration.watchedCollection).doc(uid);
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

  Future<List<String>> _fetchWatchedList(String field) async {
    try {
      final userWatched =
          _db.collection(FirebaseConfiguration.watchedCollection).doc(uid);
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

  Future<List<String>> _fetchFavoriteList(String field) async {
    try {
      final userFavorite =
          _db.collection(FirebaseConfiguration.favoriteCollection).doc(uid);
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

  Stream<QuerySnapshot<Map<String, dynamic>>> _reviewsStream(String id) => _db
      .collection(FirebaseConfiguration.mediaCollection)
      .doc(id)
      .collection(FirebaseConfiguration.reviewsCollection)
      .snapshots();

  Stream<DocumentSnapshot<Map<String, dynamic>>> _favoriteStream() => _db
      .collection(FirebaseConfiguration.favoriteCollection)
      .doc(uid)
      .snapshots();

  Stream<DocumentSnapshot<Map<String, dynamic>>> _watchedStream() => _db
      .collection(FirebaseConfiguration.watchedCollection)
      .doc(uid)
      .snapshots();

  Stream<DocumentSnapshot<Map<String, dynamic>>> _userStream() => _db
      .collection(FirebaseConfiguration.usersCollection)
      .doc(uid)
      .snapshots();

  Future<List<String>> _fetchFavoriteAndNotWatchedList(String field) async {
    try {
      final userFavorite =
          _db.collection(FirebaseConfiguration.favoriteCollection).doc(uid);
      final userWatched =
          _db.collection(FirebaseConfiguration.watchedCollection).doc(uid);
      List<dynamic> listFavorite = [];
      List<dynamic> listWatched = [];
      try {
        listFavorite = (await userFavorite.get()).get(field) as List<dynamic>;
        listWatched = (await userWatched.get()).get(field) as List<dynamic>;
      } catch (e) {
        return Future.value([]);
      }
      final result = listFavorite
          .where((element) => !listWatched.contains(element))
          .toList();
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
