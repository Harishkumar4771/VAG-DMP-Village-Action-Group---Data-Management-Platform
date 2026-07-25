import 'package:isar/isar.dart';
import '../../../../core/database/isar_utils.dart';
import '../../../../core/sync/sync_status.dart';
import '../../domain/entities/issue.dart';

part 'issue_model.g.dart';

@collection
class IssueModel {
  Id get isarId => fastHash(id);
  
  @Index(unique: true, replace: true)
  late String id;
  
  late String title;
  
  @enumerated
  late IssueCategory category;
  
  @enumerated
  late SubmissionStatus status;
  
  late String problemDescription;
  
  late String actionTaken;
  
  String? expenditureDetails;
  
  @Index()
  late String villageId;
  
  late String villageName;
  
  late DateTime reportedDate;
  
  DateTime? resolvedDate;
  
  late List<IssueTimelineEntryModel> timeline;
  
  @enumerated
  @Index()
  late SyncStatus syncStatus;

  late List<String> beforePhotoPaths;
  
  late List<String> afterPhotoPaths;

  late List<String> documentPaths;
  
  String? resolutionNotes;

  @Index()
  late String submittedBy;
  
  String? adminReviewNote;

  /// Convert to Domain Entity
  Issue toDomain() {
    return Issue(
      id: id,
      title: title,
      category: category,
      status: status,
      problemDescription: problemDescription,
      actionTaken: actionTaken,
      expenditureDetails: expenditureDetails,
      villageId: villageId,
      villageName: villageName,
      reportedDate: reportedDate,
      resolvedDate: resolvedDate,
      timeline: timeline.map((e) => e.toDomain()).toList(),
      syncStatus: syncStatus,
      beforePhotoPaths: beforePhotoPaths,
      afterPhotoPaths: afterPhotoPaths,
      documentPaths: documentPaths,
      resolutionNotes: resolutionNotes,
      submittedBy: submittedBy,
      adminReviewNote: adminReviewNote,
    );
  }

  /// Create from Domain Entity
  static IssueModel fromDomain(Issue issue) {
    return IssueModel()
      ..id = issue.id
      ..title = issue.title
      ..category = issue.category
      ..status = issue.status
      ..problemDescription = issue.problemDescription
      ..actionTaken = issue.actionTaken
      ..expenditureDetails = issue.expenditureDetails
      ..villageId = issue.villageId
      ..villageName = issue.villageName
      ..reportedDate = issue.reportedDate
      ..resolvedDate = issue.resolvedDate
      ..timeline = issue.timeline.map((e) => IssueTimelineEntryModel.fromDomain(e)).toList()
      ..syncStatus = issue.syncStatus
      ..beforePhotoPaths = issue.beforePhotoPaths
      ..afterPhotoPaths = issue.afterPhotoPaths
      ..documentPaths = issue.documentPaths
      ..resolutionNotes = issue.resolutionNotes
      ..submittedBy = issue.submittedBy
      ..adminReviewNote = issue.adminReviewNote;
  }
}

@embedded
class IssueTimelineEntryModel {
  @enumerated
  late SubmissionStatus status;
  
  late DateTime date;
  
  late String note;
  
  late bool completed;

  IssueTimelineEntry toDomain() {
    return IssueTimelineEntry(
      status: status,
      date: date,
      note: note,
      completed: completed,
    );
  }

  static IssueTimelineEntryModel fromDomain(IssueTimelineEntry entry) {
    return IssueTimelineEntryModel()
      ..status = entry.status
      ..date = entry.date
      ..note = entry.note
      ..completed = entry.completed;
  }
}
