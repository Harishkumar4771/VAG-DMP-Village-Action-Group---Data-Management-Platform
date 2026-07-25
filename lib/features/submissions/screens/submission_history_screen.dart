import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:vag_dmp_frontend/core/theme/app_colors.dart';
import 'package:vag_dmp_frontend/features/issues/domain/entities/issue.dart';
import 'package:vag_dmp_frontend/features/issues/presentation/logic/issue_providers.dart';

class SubmissionHistoryScreen extends ConsumerStatefulWidget {
  const SubmissionHistoryScreen({super.key});

  @override
  ConsumerState<SubmissionHistoryScreen> createState() => _SubmissionHistoryScreenState();
}

class _SubmissionHistoryScreenState extends ConsumerState<SubmissionHistoryScreen> {
  IssueCategory? _selectedFilter;

  @override
  Widget build(BuildContext context) {
    final asyncIssues = _selectedFilter == null 
        ? ref.watch(issuesProvider)
        : ref.watch(submissionsByCategoryProvider(_selectedFilter));

    return Scaffold(
      backgroundColor: AppColors.backgroundCream ?? const Color(0xFFFAFAFA),
      appBar: AppBar(
        title: Row(
          children: [
            const Text('My Submissions'),
            const SizedBox(width: 8),
            asyncIssues.when(
              data: (issues) => Badge(
                label: Text('${issues.length}'),
                backgroundColor: AppColors.primaryGreen ?? const Color(0xFF2E7D32),
              ),
              loading: () => const SizedBox.shrink(),
              error: (_, __) => const SizedBox.shrink(),
            ),
          ],
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              children: [
                _buildFilterChip('All', null),
                const SizedBox(width: 8),
                _buildFilterChip('Road', IssueCategory.road),
                const SizedBox(width: 8),
                _buildFilterChip('Education', IssueCategory.education),
                const SizedBox(width: 8),
                _buildFilterChip('Society', IssueCategory.society),
                const SizedBox(width: 8),
                _buildFilterChip('Water', IssueCategory.water),
              ],
            ),
          ),
          Expanded(
            child: asyncIssues.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, stack) => Center(child: Text('Error: $err')),
              data: (issues) {
                if (issues.isEmpty) {
                  return const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.folder_open, size: 64, color: Colors.grey),
                        SizedBox(height: 16),
                        Text('No submissions found', style: TextStyle(color: Colors.grey)),
                      ],
                    ),
                  );
                }
                return ListView.builder(
                  padding: const EdgeInsets.all(16.0),
                  itemCount: issues.length,
                  itemBuilder: (context, index) {
                    final issue = issues[index];
                    return Card(
                      margin: const EdgeInsets.only(bottom: 12.0),
                      color: AppColors.surfaceCard ?? Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ListTile(
                        leading: _buildCategoryIcon(issue.category),
                        title: Text(
                          issue.title,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text('${issue.villageName} • ${_formatDate(issue.reportedDate)}'),
                        trailing: _buildStatusChip(issue.status),
                        onTap: () {
                          context.push('/leader/history/${issue.id}');
                        },
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label, IssueCategory? category) {
    final isSelected = _selectedFilter == category;
    return FilterChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (selected) {
        setState(() {
          _selectedFilter = selected ? category : null;
        });
      },
      selectedColor: (AppColors.primaryGreen ?? const Color(0xFF2E7D32)).withOpacity(0.2),
      checkmarkColor: AppColors.primaryGreen ?? const Color(0xFF2E7D32),
    );
  }

  Widget _buildCategoryIcon(IssueCategory category) {
    IconData icon;
    Color color;
    switch (category) {
      case IssueCategory.road:
        icon = Icons.construction_rounded;
        color = const Color(0xFF6D4C41);
        break;
      case IssueCategory.education:
        icon = Icons.school_rounded;
        color = const Color(0xFF5E35B1);
        break;
      case IssueCategory.society:
        icon = Icons.groups_rounded;
        color = const Color(0xFFE65100);
        break;
      case IssueCategory.water:
        icon = Icons.water_drop_rounded;
        color = const Color(0xFF0288D1);
        break;
    }
    return CircleAvatar(
      backgroundColor: color.withOpacity(0.2),
      child: Icon(icon, color: color),
    );
  }

  Widget _buildStatusChip(SubmissionStatus status) {
    Color color;
    String label;
    switch (status) {
      case SubmissionStatus.draft:
        color = Colors.grey;
        label = 'Draft';
        break;
      case SubmissionStatus.pendingSync:
        color = const Color(0xFFF9A825); // Gold
        label = 'Pending Sync';
        break;
      case SubmissionStatus.submitted:
        color = Colors.blue;
        label = 'Submitted';
        break;
      case SubmissionStatus.verified:
        color = AppColors.primaryGreen ?? const Color(0xFF2E7D32);
        label = 'Verified';
        break;
      case SubmissionStatus.revisionRequested:
        color = Colors.red;
        label = 'Revision';
        break;
    }
    return Chip(
      label: Text(
        label,
        style: const TextStyle(color: Colors.white, fontSize: 12),
      ),
      backgroundColor: color,
      padding: EdgeInsets.zero,
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}
