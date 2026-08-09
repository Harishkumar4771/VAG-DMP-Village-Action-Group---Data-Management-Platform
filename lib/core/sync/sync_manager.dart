import 'dart:async';
import 'package:flutter/foundation.dart' show debugPrint;
import 'package:connectivity_plus/connectivity_plus.dart';
import '../../features/issues/data/data_sources/issue_local_data_source.dart';
import '../../features/meetings/data/data_sources/meeting_local_data_source.dart';
import '../../features/villages/data/data_sources/village_local_data_source.dart';
import '../database/local_db.dart';
import 'sync_remote_data_source.dart';
import 'sync_status.dart';

/// Manages background synchronization when the device comes online.
class SyncManager {
  static StreamSubscription<List<ConnectivityResult>>? _subscription;
  static final SyncRemoteDataSource _remoteDataSource = SyncRemoteDataSource();

  /// Starts listening for network changes to trigger background sync.
  static void initialize() {
    if (!LocalDb.isAvailable) return;
    
    final connectivity = Connectivity();
    _subscription = connectivity.onConnectivityChanged.listen((results) {
      if (results.isNotEmpty && results.first != ConnectivityResult.none) {
        processSyncQueue();
      }
    });
  }

  /// Explicit trigger for background sync process.
  static Future<void> triggerSync() async {
    await processSyncQueue();
  }

  static Future<void> processSyncQueue() async {
    if (!LocalDb.isAvailable) return;
    debugPrint('SyncManager: Network connected. Processing pending queue...');
    
    final isar = LocalDb.instance;
    if (isar == null) return;

    try {
      final issueDs = IssueLocalDataSource();
      final meetingDs = MeetingLocalDataSource();
      final villageDs = VillageLocalDataSource();

      final pendingIssues = await issueDs.getPendingSyncIssues();
      final pendingMeetings = await meetingDs.getPendingSyncMeetings();
      final pendingVillages = await villageDs.getPendingSyncVillages();

      if (pendingIssues.isEmpty && pendingMeetings.isEmpty && pendingVillages.isEmpty) {
        debugPrint('SyncManager: No pending items to sync.');
        return;
      }

      final result = await _remoteDataSource.pushSyncData(
        issues: pendingIssues,
        meetings: pendingMeetings,
        villages: pendingVillages,
      );

      if (result != null && result['success'] == true) {
        for (final issue in pendingIssues) {
          issue.syncStatus = SyncStatus.synced;
          await issueDs.saveIssue(issue);
        }
        for (final meeting in pendingMeetings) {
          meeting.syncStatus = SyncStatus.synced;
          await meetingDs.saveMeeting(meeting);
        }
        for (final village in pendingVillages) {
          village.syncStatus = SyncStatus.synced;
          await villageDs.saveVillage(village);
        }
        debugPrint('SyncManager: Successfully synced queue with backend API.');
      } else {
        debugPrint('SyncManager: Backend push returned unsuccessful response.');
      }
    } catch (e) {
      debugPrint('SyncManager: Error processing sync queue: $e');
    }
  }

  static void dispose() {
    _subscription?.cancel();
  }
}
