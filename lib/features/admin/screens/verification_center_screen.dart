import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:vag_dmp_frontend/core/theme/app_colors.dart';
import 'package:vag_dmp_frontend/core/constants/app_constants.dart';
import 'package:vag_dmp_frontend/features/issues/domain/entities/issue.dart';
import 'package:vag_dmp_frontend/features/issues/presentation/logic/issue_providers.dart';
import 'package:vag_dmp_frontend/core/sync/sync_status_indicator.dart';

class VerificationCenterScreen extends ConsumerStatefulWidget {
  const VerificationCenterScreen({super.key});

  @override
  ConsumerState<VerificationCenterScreen> createState() => _VerificationCenterScreenState();
}

class _VerificationCenterScreenState extends ConsumerState<VerificationCenterScreen> {
  IssueCategory? _selectedCategory;
  SubmissionStatus? _selectedStatus;

  @override
  Widget build(BuildContext context) {
    final issuesAsync = ref.watch(issuesProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      appBar: AppBar(
        title: const Text('Verification Center'),
        backgroundColor: const Color(0xFF2E7D32),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          _buildFilterBar(),
          Expanded(
            child: issuesAsync.when(
              data: (issues) {
                // Apply filters
                var filteredIssues = issues.where((issue) {
                  final matchCategory = _selectedCategory == null || issue.category == _selectedCategory;
                  final matchStatus = _selectedStatus == null || issue.status == _selectedStatus;
                  return matchCategory && matchStatus;
                }).toList();

                if (filteredIssues.isEmpty) {
                  return const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.inbox, size: 64, color: Colors.grey),
                        SizedBox(height: 16),
                        Text(
                          'No issues found matching criteria.',
                          style: TextStyle(color: Colors.black54, fontSize: 16),
                        ),
                      ],
                    ),
                  );
                }

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                      child: Text(
                        'Showing ${filteredIssues.length} of ${issues.length}',
                        style: const TextStyle(fontWeight: FontWeight.w500, color: Colors.black54),
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        itemCount: filteredIssues.length,
                        itemBuilder: (context, index) {
                          final issue = filteredIssues[index];
                          return _buildIssueCard(context, issue);
                        },
                      ),
                    ),
                  ],
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => Center(child: Text('Error loading issues: $e')),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterBar() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Expanded(
            child: DropdownButtonFormField<IssueCategory?>(
              decoration: InputDecoration(
                labelText: 'Category',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              ),
              value: _selectedCategory,
              items: [
                const DropdownMenuItem(value: null, child: Text('All')),
                ...IssueCategory.values.map(
                  (c) => DropdownMenuItem(
                    value: c,
                    child: Text(c.name.toUpperCase()),
                  ),
                ),
              ],
              onChanged: (val) => setState(() => _selectedCategory = val),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: DropdownButtonFormField<SubmissionStatus?>(
              decoration: InputDecoration(
                labelText: 'Status',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              ),
              value: _selectedStatus,
              items: [
                const DropdownMenuItem(value: null, child: Text('All')),
                const DropdownMenuItem(value: SubmissionStatus.submitted, child: Text('Submitted')),
                const DropdownMenuItem(value: SubmissionStatus.verified, child: Text('Verified')),
                const DropdownMenuItem(value: SubmissionStatus.revisionRequested, child: Text('Revision Requested')),
              ],
              onChanged: (val) => setState(() => _selectedStatus = val),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIssueCard(BuildContext context, Issue issue) {
    IconData categoryIcon;
    switch (issue.category) {
      case IssueCategory.road:
        categoryIcon = Icons.add_road;
        break;
      case IssueCategory.education:
        categoryIcon = Icons.school;
        break;
      case IssueCategory.water:
        categoryIcon = Icons.water_drop;
        break;
      case IssueCategory.society:
        categoryIcon = Icons.people;
        break;
    }

    final totalPhotos = issue.beforePhotoPaths.length + issue.afterPhotoPaths.length;

    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () => context.push('/admin/verify/${issue.id}'),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: const Color(0xFF2E7D32).withOpacity(0.1),
                    child: Icon(categoryIcon, color: const Color(0xFF2E7D32)),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          issue.title,
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          '${issue.villageName} • ${issue.submittedBy}',
                          style: const TextStyle(fontSize: 13, color: Colors.black54),
                        ),
                      ],
                    ),
                  ),
                  _buildStatusChip(issue.status),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${issue.reportedDate.toLocal().toString().split(' ')[0]}',
                    style: const TextStyle(fontSize: 12, color: Colors.black54),
                  ),
                  if (totalPhotos > 0)
                    Badge(
                      label: Text('$totalPhotos'),
                      backgroundColor: const Color(0xFFE64A19),
                      child: const Icon(Icons.photo_library, size: 20, color: Colors.black54),
                    ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusChip(SubmissionStatus status) {
    Color bgColor;
    Color textColor;
    String label;

    switch (status) {
      case SubmissionStatus.verified:
        bgColor = const Color(0xFF2E7D32).withOpacity(0.1);
        textColor = const Color(0xFF2E7D32);
        label = 'Verified';
        break;
      case SubmissionStatus.revisionRequested:
        bgColor = const Color(0xFFE64A19).withOpacity(0.1);
        textColor = const Color(0xFFE64A19);
        label = 'Revision';
        break;
      case SubmissionStatus.submitted:
        bgColor = const Color(0xFFF9A825).withOpacity(0.2);
        textColor = Colors.black87;
        label = 'Submitted';
        break;
      default:
        bgColor = Colors.grey.shade200;
        textColor = Colors.black87;
        label = status.name;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        label,
        style: TextStyle(color: textColor, fontSize: 12, fontWeight: FontWeight.w600),
      ),
    );
  }
}
