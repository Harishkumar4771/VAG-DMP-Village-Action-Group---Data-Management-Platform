import '../../../../core/sync/sync_status.dart';

/// Submission workflow status — replaces the old IssueStatus.
enum SubmissionStatus { draft, pendingSync, submitted, verified, revisionRequested }

/// Problem domain categories for the 4 reporting verticals.
enum IssueCategory { road, education, water, society }

/// A single activity submission documenting a problem and its resolution proof.
class Issue {
  final String id;
  final String title;
  final IssueCategory category;
  final SubmissionStatus status;
  final String problemDescription;
  final String actionTaken;
  final String? expenditureDetails;
  final String villageId;
  final String villageName;
  final DateTime reportedDate;
  final DateTime? resolvedDate;
  final List<IssueTimelineEntry> timeline;
  final SyncStatus syncStatus;
  final List<String> beforePhotoPaths;
  final List<String> afterPhotoPaths;
  final List<String> documentPaths;
  final String? resolutionNotes;
  final String submittedBy;
  final String? adminReviewNote;

  const Issue({
    required this.id,
    required this.title,
    required this.category,
    required this.status,
    required this.problemDescription,
    required this.actionTaken,
    this.expenditureDetails,
    required this.villageId,
    required this.villageName,
    required this.reportedDate,
    this.resolvedDate,
    this.timeline = const [],
    this.syncStatus = SyncStatus.synced,
    this.beforePhotoPaths = const [],
    this.afterPhotoPaths = const [],
    this.documentPaths = const [],
    this.resolutionNotes,
    required this.submittedBy,
    this.adminReviewNote,
  });

  Issue copyWith({
    String? id,
    String? title,
    IssueCategory? category,
    SubmissionStatus? status,
    String? problemDescription,
    String? actionTaken,
    String? expenditureDetails,
    String? villageId,
    String? villageName,
    DateTime? reportedDate,
    DateTime? resolvedDate,
    List<IssueTimelineEntry>? timeline,
    SyncStatus? syncStatus,
    List<String>? beforePhotoPaths,
    List<String>? afterPhotoPaths,
    List<String>? documentPaths,
    String? resolutionNotes,
    String? submittedBy,
    String? adminReviewNote,
  }) {
    return Issue(
      id: id ?? this.id,
      title: title ?? this.title,
      category: category ?? this.category,
      status: status ?? this.status,
      problemDescription: problemDescription ?? this.problemDescription,
      actionTaken: actionTaken ?? this.actionTaken,
      expenditureDetails: expenditureDetails ?? this.expenditureDetails,
      villageId: villageId ?? this.villageId,
      villageName: villageName ?? this.villageName,
      reportedDate: reportedDate ?? this.reportedDate,
      resolvedDate: resolvedDate ?? this.resolvedDate,
      timeline: timeline ?? this.timeline,
      syncStatus: syncStatus ?? this.syncStatus,
      beforePhotoPaths: beforePhotoPaths ?? this.beforePhotoPaths,
      afterPhotoPaths: afterPhotoPaths ?? this.afterPhotoPaths,
      documentPaths: documentPaths ?? this.documentPaths,
      resolutionNotes: resolutionNotes ?? this.resolutionNotes,
      submittedBy: submittedBy ?? this.submittedBy,
      adminReviewNote: adminReviewNote ?? this.adminReviewNote,
    );
  }
}

class IssueTimelineEntry {
  final SubmissionStatus status;
  final DateTime date;
  final String note;
  final bool completed;

  const IssueTimelineEntry({
    required this.status,
    required this.date,
    required this.note,
    this.completed = false,
  });
}
