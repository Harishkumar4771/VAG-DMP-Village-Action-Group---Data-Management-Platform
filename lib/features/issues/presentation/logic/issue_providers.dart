import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/data_sources/issue_local_data_source.dart';
import '../../domain/entities/issue.dart';

final issueLocalDataSourceProvider = Provider<IssueLocalDataSource>((ref) {
  return IssueLocalDataSource();
});

/// Fetches all submissions and maps them to domain entities.
final issuesProvider = FutureProvider<List<Issue>>((ref) async {
  final dataSource = ref.watch(issueLocalDataSourceProvider);
  final models = await dataSource.getAllIssues();
  return models.map((e) => e.toDomain()).toList();
});

/// Fetches a specific submission by ID.
final issueByIdProvider = FutureProvider.family<Issue?, String>((ref, id) async {
  final dataSource = ref.watch(issueLocalDataSourceProvider);
  final model = await dataSource.getIssueById(id);
  return model?.toDomain();
});

/// Count of non-verified submissions (for Leader dashboard).
final activeIssuesCountProvider = FutureProvider<int>((ref) async {
  final issues = await ref.watch(issuesProvider.future);
  return issues.where((i) => i.status != SubmissionStatus.verified).length;
});

/// Filter submissions by category.
final submissionsByCategoryProvider = FutureProvider.family<List<Issue>, IssueCategory?>((ref, category) async {
  final issues = await ref.watch(issuesProvider.future);
  if (category == null) return issues;
  return issues.where((i) => i.category == category).toList();
});

/// Filter submissions by status.
final submissionsByStatusProvider = FutureProvider.family<List<Issue>, SubmissionStatus?>((ref, status) async {
  final issues = await ref.watch(issuesProvider.future);
  if (status == null) return issues;
  return issues.where((i) => i.status == status).toList();
});

/// Count of submissions awaiting admin verification.
final pendingVerificationCountProvider = FutureProvider<int>((ref) async {
  final issues = await ref.watch(issuesProvider.future);
  return issues.where((i) => i.status == SubmissionStatus.submitted).length;
});

/// Count of verified submissions this month.
final verifiedThisMonthProvider = FutureProvider<int>((ref) async {
  final issues = await ref.watch(issuesProvider.future);
  final now = DateTime.now();
  return issues.where((i) =>
    i.status == SubmissionStatus.verified &&
    i.resolvedDate != null &&
    i.resolvedDate!.month == now.month &&
    i.resolvedDate!.year == now.year
  ).length;
});
