import { mockDb, MockProgressUpdate } from '../config/mockStore';
import { CreateProgressUpdateDto, ProgressUpdateStatus } from '../types';

// Status mapping: progress update status → issue status
const progressToIssueStatus: Record<ProgressUpdateStatus, string> = {
  'NOT_STARTED': 'REPORTED',
  'WORK_IN_PROGRESS': 'IN_PROGRESS',
  'WAITING_APPROVAL': 'WAITING',
  'WAITING_RESOURCES': 'WAITING',
  'COMPLETED': 'COMPLETED',
};

export const getProgressUpdates = async (issueId: string) => {
  return mockDb.progressUpdates.filter((pu) => pu.issueId === issueId);
};

export const addProgressUpdate = async (issueId: string, data: CreateProgressUpdateDto) => {
  // Check issue exists
  const issue = mockDb.issues.find((i) => i.id === issueId);
  if (!issue) {
    const error: any = new Error('Issue not found');
    error.status = 404;
    throw error;
  }

  // Check for duplicate update type
  const existing = mockDb.progressUpdates.find(
    (pu) => pu.issueId === issueId && pu.type === data.type
  );
  if (existing) {
    const error: any = new Error(`A ${data.type === '15_DAY' ? '15-day' : '1-month'} progress update already exists for this issue`);
    error.status = 400;
    throw error;
  }

  const newUpdate: MockProgressUpdate = {
    id: `pu_${Date.now()}_${Math.random().toString(36).substring(2, 7)}`,
    issueId,
    type: data.type,
    status: data.status,
    description: data.description,
    photoUrl: data.photoDataUrl || undefined,
    expenditure: data.expenditure || undefined,
    notes: data.notes || undefined,
    date: new Date().toISOString(),
  };

  mockDb.progressUpdates.push(newUpdate);

  // Update parent issue status based on progress update
  const newIssueStatus = progressToIssueStatus[data.status] || issue.status;
  issue.status = newIssueStatus as any;
  issue.updatedAt = new Date().toISOString();

  if (data.status === 'COMPLETED') {
    issue.resolvedDate = new Date().toISOString();
  }

  // Add timeline entry
  mockDb.timeline.push({
    id: `tml_${Date.now()}`,
    issueId,
    status: newIssueStatus,
    date: new Date().toISOString(),
    note: data.description,
    completed: data.status === 'COMPLETED',
  });

  return newUpdate;
};

export const getReminders = async () => {
  const now = new Date();
  const reminders: Array<{
    issueId: string;
    issueTitle: string;
    villageName: string;
    category: string;
    type: '15_DAY' | '1_MONTH';
    dueDate: string;
    status: 'due_soon' | 'overdue' | 'upcoming';
    daysRemaining: number;
  }> = [];

  for (const issue of mockDb.issues) {
    if (issue.status === 'COMPLETED') continue;

    const reportedDate = new Date(issue.reportedDate);
    const village = mockDb.villages.find((v) => v.id === issue.villageId);
    const villageName = village?.name || 'Unknown';

    // 15-day check
    const has15Day = mockDb.progressUpdates.some(
      (pu) => pu.issueId === issue.id && pu.type === '15_DAY'
    );
    if (!has15Day) {
      const fifteenDayDue = new Date(reportedDate);
      fifteenDayDue.setDate(fifteenDayDue.getDate() + 15);
      const daysRemaining = Math.ceil((fifteenDayDue.getTime() - now.getTime()) / (1000 * 60 * 60 * 24));

      let status: 'due_soon' | 'overdue' | 'upcoming' = 'upcoming';
      if (daysRemaining < 0) status = 'overdue';
      else if (daysRemaining <= 3) status = 'due_soon';

      reminders.push({
        issueId: issue.id,
        issueTitle: issue.title,
        villageName,
        category: issue.category,
        type: '15_DAY',
        dueDate: fifteenDayDue.toISOString(),
        status,
        daysRemaining,
      });
    }

    // 1-month check
    const has1Month = mockDb.progressUpdates.some(
      (pu) => pu.issueId === issue.id && pu.type === '1_MONTH'
    );
    if (!has1Month) {
      const oneMonthDue = new Date(reportedDate);
      oneMonthDue.setMonth(oneMonthDue.getMonth() + 1);
      const daysRemaining = Math.ceil((oneMonthDue.getTime() - now.getTime()) / (1000 * 60 * 60 * 24));

      let status: 'due_soon' | 'overdue' | 'upcoming' = 'upcoming';
      if (daysRemaining < 0) status = 'overdue';
      else if (daysRemaining <= 3) status = 'due_soon';

      reminders.push({
        issueId: issue.id,
        issueTitle: issue.title,
        villageName,
        category: issue.category,
        type: '1_MONTH',
        dueDate: oneMonthDue.toISOString(),
        status,
        daysRemaining,
      });
    }
  }

  // Sort: overdue first, then due_soon, then upcoming
  reminders.sort((a, b) => {
    const priority = { overdue: 0, due_soon: 1, upcoming: 2 };
    return priority[a.status] - priority[b.status] || a.daysRemaining - b.daysRemaining;
  });

  return reminders;
};
