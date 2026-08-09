import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../network/api_client.dart';
import '../../features/issues/data/models/issue_model.dart';
import '../../features/meetings/data/models/meeting_model.dart';
import '../../features/villages/data/models/village_model.dart';

class SyncRemoteDataSource {
  final Dio _dio = ApiClient.instance;

  Future<Map<String, dynamic>?> pushSyncData({
    List<IssueModel> issues = const [],
    List<MeetingModel> meetings = const [],
    List<VillageModel> villages = const [],
  }) async {
    try {
      final payload = {
        'issues': issues.map((i) => {
          'id': i.id,
          'title': i.title,
          'category': i.category.name.toUpperCase(),
          'status': i.status.name.toUpperCase(),
          'problemDescription': i.problemDescription,
          'actionTaken': i.actionTaken,
          'expenditureDetails': i.expenditureDetails,
          'villageId': i.villageId,
          'submittedById': i.submittedBy,
          'reportedDate': i.reportedDate.toIso8601String(),
          'beforePhotoUrls': i.beforePhotoPaths,
          'afterPhotoUrls': i.afterPhotoPaths,
        }).toList(),
        'meetings': meetings.map((m) => {
          'id': m.id,
          'villageId': m.villageId,
          'date': m.date.toIso8601String(),
          'attendeesCount': m.attendeesCount,
          'status': m.status.name.toUpperCase(),
          'notes': m.notes,
        }).toList(),
        'villages': villages.map((v) => {
          'id': v.id,
          'name': v.name,
          'district': v.district,
          'state': v.state,
          'memberCount': v.memberCount,
          'lastActivity': v.lastActivity,
          'status': v.status,
        }).toList(),
      };

      final response = await _dio.post('/sync/push', data: payload);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data as Map<String, dynamic>;
      }
    } catch (e) {
      debugPrint('SyncRemoteDataSource: Error pushing sync data: $e');
    }
    return null;
  }

  Future<Map<String, dynamic>?> pullSyncData({String? since}) async {
    try {
      final response = await _dio.get(
        '/sync/pull',
        queryParameters: since != null ? {'since': since} : null,
      );
      if (response.statusCode == 200) {
        return response.data as Map<String, dynamic>;
      }
    } catch (e) {
      debugPrint('SyncRemoteDataSource: Error pulling sync data: $e');
    }
    return null;
  }
}
