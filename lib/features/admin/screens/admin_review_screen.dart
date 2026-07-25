import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:vag_dmp_frontend/core/theme/app_colors.dart';
import 'package:vag_dmp_frontend/core/constants/app_constants.dart';
import 'package:vag_dmp_frontend/features/issues/domain/entities/issue.dart';
import 'package:vag_dmp_frontend/features/issues/presentation/logic/issue_providers.dart';
import 'package:vag_dmp_frontend/features/issues/data/data_sources/issue_local_data_source.dart';
import 'package:vag_dmp_frontend/features/issues/data/models/issue_model.dart';
import 'package:vag_dmp_frontend/core/sync/sync_status.dart';

class AdminReviewScreen extends ConsumerStatefulWidget {
  final String submissionId;

  const AdminReviewScreen({super.key, required this.submissionId});

  @override
  ConsumerState<AdminReviewScreen> createState() => _AdminReviewScreenState();
}

class _AdminReviewScreenState extends ConsumerState<AdminReviewScreen> {
  final _revisionController = TextEditingController();

  @override
  void dispose() {
    _revisionController.dispose();
    super.dispose();
  }

  void _openFullscreenImage(List<String> paths, int initialIndex) {
    if (paths.isEmpty) return;
    showDialog(
      context: context,
      builder: (context) {
        int currentIndex = initialIndex;
        return StatefulBuilder(
          builder: (context, setStateDialog) {
            return Dialog.fullscreen(
              backgroundColor: Colors.black,
              child: Stack(
                children: [
                  PageView.builder(
                    itemCount: paths.length,
                    controller: PageController(initialPage: initialIndex),
                    onPageChanged: (idx) {
                      setStateDialog(() {
                        currentIndex = idx;
                      });
                    },
                    itemBuilder: (context, index) {
                      return InteractiveViewer(
                        panEnabled: true,
                        minScale: 1.0,
                        maxScale: 4.0,
                        child: Image.asset(
                          paths[index],
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) => const Center(
                            child: Icon(Icons.broken_image, color: Colors.white, size: 64),
                          ),
                        ),
                      );
                    },
                  ),
                  Positioned(
                    top: 40,
                    right: 20,
                    child: IconButton(
                      icon: const Icon(Icons.close, color: Colors.white, size: 32),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                  Positioned(
                    bottom: 40,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.black54,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          '${currentIndex + 1} / ${paths.length}',
                          style: const TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void _approveAndVerify(Issue issue) async {
    try {
      final localDataSource = ref.read(issueLocalDataSourceProvider);
      
      final updatedIssue = Issue(
        id: issue.id,
        title: issue.title,
        problemDescription: issue.problemDescription,
        actionTaken: issue.actionTaken,
        villageId: issue.villageId,
        villageName: issue.villageName,
        submittedBy: issue.submittedBy,
        expenditureDetails: issue.expenditureDetails,
        resolutionNotes: issue.resolutionNotes,
        adminReviewNote: issue.adminReviewNote,
        category: issue.category,
        status: SubmissionStatus.verified,
        reportedDate: issue.reportedDate,
        resolvedDate: DateTime.now(),
        beforePhotoPaths: issue.beforePhotoPaths,
        afterPhotoPaths: issue.afterPhotoPaths,
        documentPaths: issue.documentPaths,
        timeline: [
          ...issue.timeline,
          IssueTimelineEntry(
            status: SubmissionStatus.verified,
            date: DateTime.now(),
            note: 'Verified by Admin',
            completed: true,
          )
        ],
        syncStatus: SyncStatus.pendingUpdate,
      );

      final model = IssueModel.fromDomain(updatedIssue);
      await localDataSource.saveIssue(model);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Submission approved and verified successfully')),
        );
        context.pop();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to approve: $e')),
        );
      }
    }
  }

  void _requestRevision(Issue issue) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Request Revision'),
        content: TextFormField(
          controller: _revisionController,
          maxLines: 3,
          decoration: const InputDecoration(
            hintText: 'Enter notes for revision...',
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFE64A19)),
            onPressed: () async {
              if (_revisionController.text.trim().isEmpty) {
                return;
              }
              Navigator.pop(ctx);
              
              try {
                final localDataSource = ref.read(issueLocalDataSourceProvider);
                final updatedIssue = Issue(
                  id: issue.id,
                  title: issue.title,
                  problemDescription: issue.problemDescription,
                  actionTaken: issue.actionTaken,
                  villageId: issue.villageId,
                  villageName: issue.villageName,
                  submittedBy: issue.submittedBy,
                  expenditureDetails: issue.expenditureDetails,
                  resolutionNotes: issue.resolutionNotes,
                  adminReviewNote: _revisionController.text.trim(),
                  category: issue.category,
                  status: SubmissionStatus.revisionRequested,
                  reportedDate: issue.reportedDate,
                  resolvedDate: issue.resolvedDate,
                  beforePhotoPaths: issue.beforePhotoPaths,
                  afterPhotoPaths: issue.afterPhotoPaths,
                  documentPaths: issue.documentPaths,
                  timeline: [
                    ...issue.timeline,
                    IssueTimelineEntry(
                      status: SubmissionStatus.revisionRequested,
                      date: DateTime.now(),
                      note: 'Revision requested: ${_revisionController.text.trim()}',
                      completed: true,
                    )
                  ],
                  syncStatus: SyncStatus.pendingUpdate,
                );

                final model = IssueModel.fromDomain(updatedIssue);
                await localDataSource.saveIssue(model);

                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Revision requested.')),
                  );
                  context.pop();
                }
              } catch (e) {
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Failed to request revision: $e')),
                  );
                }
              }
            },
            child: const Text('Send Request', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final issueAsync = ref.watch(issueByIdProvider(widget.submissionId));

    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      appBar: AppBar(
        title: const Text('Review Submission'),
        backgroundColor: const Color(0xFF2E7D32),
        foregroundColor: Colors.white,
      ),
      body: issueAsync.when(
        data: (issue) {
          if (issue == null) {
            return const Center(child: Text('Issue not found.'));
          }

          final showBottomBar = issue.status == SubmissionStatus.submitted;

          return Column(
            children: [
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.all(16.0),
                  children: [
                    _buildHeaderCard(issue),
                    const SizedBox(height: 16),
                    _buildSection('Problem Statement', issue.problemDescription),
                    const SizedBox(height: 16),
                    _buildSection('Action Taken', issue.actionTaken),
                    if (issue.expenditureDetails != null && issue.expenditureDetails!.isNotEmpty) ...[
                      const SizedBox(height: 16),
                      _buildSection('Expenditure', issue.expenditureDetails!),
                    ],
                    const SizedBox(height: 16),
                    _buildPhotosGallery('Before Photos', issue.beforePhotoPaths),
                    const SizedBox(height: 16),
                    _buildPhotosGallery('After Photos', issue.afterPhotoPaths),
                    const SizedBox(height: 16),
                    if (issue.documentPaths.isNotEmpty)
                      _buildDocuments(issue.documentPaths),
                    const SizedBox(height: 16),
                    _buildStatusSection(issue),
                  ],
                ),
              ),
              if (showBottomBar) _buildBottomActionBar(issue),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
      ),
    );
  }

  Widget _buildHeaderCard(Issue issue) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: const Color(0xFF2E7D32).withOpacity(0.1),
              radius: 28,
              child: const Icon(Icons.category, color: Color(0xFF2E7D32), size: 32),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    issue.title,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Village: ${issue.villageName}',
                    style: const TextStyle(fontSize: 14, color: Colors.black87),
                  ),
                  Text(
                    'By: ${issue.submittedBy}',
                    style: const TextStyle(fontSize: 14, color: Colors.black54),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, String content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Text(content, style: const TextStyle(fontSize: 14)),
        ),
      ],
    );
  }

  Widget _buildPhotosGallery(String title, List<String> paths) {
    if (paths.isEmpty) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          const Text('No photos attached.', style: TextStyle(color: Colors.black54)),
        ],
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        SizedBox(
          height: 120,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: paths.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () => _openFullscreenImage(paths, index),
                child: Container(
                  margin: const EdgeInsets.only(right: 12),
                  width: 120,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.grey.shade200,
                    image: DecorationImage(
                      image: AssetImage(paths[index]), // Assuming local assets/files
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildDocuments(List<String> paths) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Documents', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        ...paths.map((path) => ListTile(
              leading: const Icon(Icons.picture_as_pdf, color: Colors.red),
              title: Text(path.split('/').last),
              tileColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              onTap: () {
                // Open doc
              },
            )),
      ],
    );
  }

  Widget _buildStatusSection(Issue issue) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Current Status', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            issue.status.name.toUpperCase(),
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

  Widget _buildBottomActionBar(Issue issue) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            offset: const Offset(0, -4),
            blurRadius: 8,
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton(
              onPressed: () => _requestRevision(issue),
              style: OutlinedButton.styleFrom(
                foregroundColor: const Color(0xFFE64A19),
                side: const BorderSide(color: Color(0xFFE64A19)),
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text('Request Revision'),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: FilledButton(
              onPressed: () => _approveAndVerify(issue),
              style: FilledButton.styleFrom(
                backgroundColor: const Color(0xFF2E7D32),
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text('Approve & Verify'),
            ),
          ),
        ],
      ),
    );
  }
}
