import prisma from '../config/db';
import { CreateIssueDto, UpdateIssueDto, SubmissionStatus, IssueCategory, MediaType } from '../types';
import { mockDb, MockIssue } from '../config/mockStore';

export const getAllIssues = async (filters?: {
  category?: string;
  status?: string;
  villageId?: string;
  submittedBy?: string;
  search?: string;
  limit?: number;
  offset?: number;
}) => {
  try {
    const where: any = {};

    if (filters?.category) {
      where.category = filters.category as IssueCategory;
    }

    if (filters?.status) {
      where.status = filters.status as SubmissionStatus;
    }

    if (filters?.villageId) {
      where.villageId = filters.villageId;
    }

    if (filters?.submittedBy) {
      where.submittedById = filters.submittedBy;
    }

    if (filters?.search) {
      where.OR = [
        { title: { contains: filters.search, mode: 'insensitive' } },
        { problemDescription: { contains: filters.search, mode: 'insensitive' } },
        { actionTaken: { contains: filters.search, mode: 'insensitive' } },
      ];
    }

    const [items, total] = await Promise.all([
      prisma.issue.findMany({
        where,
        include: {
          village: { select: { id: true, name: true, district: true } },
          submittedBy: { select: { id: true, name: true, phone: true } },
          media: true,
          timeline: { orderBy: { date: 'asc' } },
        },
        orderBy: { createdAt: 'desc' },
        take: filters?.limit ? Number(filters.limit) : 50,
        skip: filters?.offset ? Number(filters.offset) : 0,
      }),
      prisma.issue.count({ where }),
    ]);

    return { items, total };
  } catch (error) {
    // Fallback to in-memory store
    let items = [...mockDb.issues];

    if (filters?.category) {
      items = items.filter((i) => i.category === filters.category);
    }
    if (filters?.status) {
      items = items.filter((i) => i.status === filters.status);
    }
    if (filters?.villageId) {
      items = items.filter((i) => i.villageId === filters.villageId);
    }
    if (filters?.submittedBy) {
      items = items.filter((i) => i.submittedById === filters.submittedBy);
    }
    if (filters?.search) {
      const s = filters.search.toLowerCase();
      items = items.filter(
        (i) =>
          i.title.toLowerCase().includes(s) ||
          i.problemDescription.toLowerCase().includes(s) ||
          i.actionTaken.toLowerCase().includes(s)
      );
    }

    const total = items.length;
    const formatted = items.map((iss) => ({
      ...iss,
      village: mockDb.villages.find((v) => v.id === iss.villageId) || { id: iss.villageId, name: 'Chandpur', district: 'Pune' },
      submittedBy: mockDb.users.find((u) => u.id === iss.submittedById) || { id: iss.submittedById, name: 'Sunita Kumar', phone: '+91 98765 43210' },
      media: mockDb.media.filter((m) => m.issueId === iss.id),
      timeline: mockDb.timeline.filter((t) => t.issueId === iss.id),
    }));

    return { items: formatted, total };
  }
};

export const getIssueById = async (id: string) => {
  try {
    const issue = await prisma.issue.findUnique({
      where: { id },
      include: {
        village: true,
        submittedBy: { select: { id: true, name: true, phone: true, role: true } },
        media: true,
        timeline: { orderBy: { date: 'asc' } },
      },
    });

    if (issue) return issue;
  } catch (error) {
    // continue to mock check below
  }

  const iss = mockDb.issues.find((i) => i.id === id);
  if (!iss) {
    const error: any = new Error('Issue submission not found');
    error.status = 404;
    throw error;
  }

  return {
    ...iss,
    village: mockDb.villages.find((v) => v.id === iss.villageId),
    submittedBy: mockDb.users.find((u) => u.id === iss.submittedById),
    media: mockDb.media.filter((m) => m.issueId === iss.id),
    timeline: mockDb.timeline.filter((t) => t.issueId === iss.id),
  };
};

export const createIssue = async (data: CreateIssueDto, fallbackUserId?: string) => {
  const id = data.id || `iss_${Date.now()}_${Math.random().toString(36).substring(2, 7)}`;
  const submittedById = data.submittedById || fallbackUserId || 'leader-001';
  const reportedDate = data.reportedDate ? new Date(data.reportedDate) : new Date();
  const status = data.status || 'SUBMITTED';

  try {
    const mediaCreates: any[] = [];
    if (data.beforePhotoUrls) {
      for (const url of data.beforePhotoUrls) mediaCreates.push({ url, type: 'BEFORE' as MediaType });
    }
    if (data.afterPhotoUrls) {
      for (const url of data.afterPhotoUrls) mediaCreates.push({ url, type: 'AFTER' as MediaType });
    }
    if (data.documentUrls) {
      for (const url of data.documentUrls) mediaCreates.push({ url, type: 'DOCUMENT' as MediaType });
    }

    return await prisma.issue.create({
      data: {
        id,
        title: data.title,
        category: data.category,
        status,
        problemDescription: data.problemDescription,
        actionTaken: data.actionTaken,
        expenditureDetails: data.expenditureDetails,
        villageId: data.villageId,
        submittedById,
        reportedDate,
        resolvedDate: data.resolvedDate ? new Date(data.resolvedDate) : null,
        timeline: {
          create: [{ status: 'SUBMITTED', date: reportedDate, note: 'Submission recorded', completed: true }],
        },
        media: { create: mediaCreates },
      },
      include: { village: true, submittedBy: true, media: true, timeline: true },
    });
  } catch (error) {
    const newIssue: MockIssue = {
      id,
      title: data.title,
      category: data.category,
      status: status as any,
      problemDescription: data.problemDescription,
      actionTaken: data.actionTaken,
      expenditureDetails: data.expenditureDetails || null,
      villageId: data.villageId,
      submittedById,
      reportedDate: reportedDate.toISOString(),
      resolvedDate: data.resolvedDate ? new Date(data.resolvedDate).toISOString() : null,
      createdAt: new Date().toISOString(),
      updatedAt: new Date().toISOString(),
    };
    mockDb.issues.push(newIssue);

    mockDb.timeline.push({
      id: `tml_${Date.now()}`,
      issueId: id,
      status: 'SUBMITTED',
      date: reportedDate.toISOString(),
      note: 'Submission recorded',
      completed: true,
    });

    return {
      ...newIssue,
      village: mockDb.villages.find((v) => v.id === data.villageId),
      submittedBy: mockDb.users.find((u) => u.id === submittedById),
      media: mockDb.media.filter((m) => m.issueId === id),
      timeline: mockDb.timeline.filter((t) => t.issueId === id),
    };
  }
};

export const updateIssue = async (id: string, data: UpdateIssueDto) => {
  try {
    const existing = await prisma.issue.findUnique({ where: { id } });
    if (existing) {
      const updateData: any = { ...data };
      if (data.resolvedDate) updateData.resolvedDate = new Date(data.resolvedDate);
      return await prisma.issue.update({
        where: { id },
        data: updateData,
        include: { village: true, media: true, timeline: true },
      });
    }
  } catch (error) {
    // fallback below
  }

  const idx = mockDb.issues.findIndex((i) => i.id === id);
  if (idx === -1) {
    const error: any = new Error('Issue submission not found');
    error.status = 404;
    throw error;
  }

  mockDb.issues[idx] = {
    ...mockDb.issues[idx],
    ...(data as any),
    resolvedDate: data.resolvedDate ? new Date(data.resolvedDate).toISOString() : mockDb.issues[idx].resolvedDate,
    updatedAt: new Date().toISOString(),
  };

  return {
    ...mockDb.issues[idx],
    village: mockDb.villages.find((v) => v.id === mockDb.issues[idx].villageId),
    submittedBy: mockDb.users.find((u) => u.id === mockDb.issues[idx].submittedById),
    media: mockDb.media.filter((m) => m.issueId === id),
    timeline: mockDb.timeline.filter((t) => t.issueId === id),
  };
};

export const updateIssueStatus = async (
  id: string,
  status: SubmissionStatus,
  adminReviewNote?: string,
  note?: string
) => {
  try {
    const existing = await prisma.issue.findUnique({ where: { id } });
    if (existing) {
      const isResolved = status === 'VERIFIED';
      const resolvedDate = isResolved ? new Date() : existing.resolvedDate;

      return await prisma.issue.update({
        where: { id },
        data: {
          status,
          adminReviewNote: adminReviewNote || existing.adminReviewNote,
          resolvedDate,
          timeline: {
            create: {
              status,
              date: new Date(),
              note: note || (adminReviewNote ? `Admin Note: ${adminReviewNote}` : `Status updated to ${status}`),
              completed: status === 'VERIFIED',
            },
          },
        },
        include: { village: true, media: true, timeline: { orderBy: { date: 'asc' } } },
      });
    }
  } catch (error) {
    // fallback below
  }

  const idx = mockDb.issues.findIndex((i) => i.id === id);
  if (idx === -1) {
    const error: any = new Error('Issue submission not found');
    error.status = 404;
    throw error;
  }

  const isResolved = status === 'VERIFIED';
  mockDb.issues[idx].status = status as any;
  if (adminReviewNote) mockDb.issues[idx].adminReviewNote = adminReviewNote;
  if (isResolved) mockDb.issues[idx].resolvedDate = new Date().toISOString();
  mockDb.issues[idx].updatedAt = new Date().toISOString();

  mockDb.timeline.push({
    id: `tml_${Date.now()}`,
    issueId: id,
    status,
    date: new Date().toISOString(),
    note: note || (adminReviewNote ? `Admin Note: ${adminReviewNote}` : `Status updated to ${status}`),
    completed: isResolved,
  });

  return {
    ...mockDb.issues[idx],
    village: mockDb.villages.find((v) => v.id === mockDb.issues[idx].villageId),
    submittedBy: mockDb.users.find((u) => u.id === mockDb.issues[idx].submittedById),
    media: mockDb.media.filter((m) => m.issueId === id),
    timeline: mockDb.timeline.filter((t) => t.issueId === id),
  };
};

export const deleteIssue = async (id: string) => {
  try {
    const existing = await prisma.issue.findUnique({ where: { id } });
    if (existing) {
      await prisma.issueTimelineEntry.deleteMany({ where: { issueId: id } });
      await prisma.media.deleteMany({ where: { issueId: id } });
      return await prisma.issue.delete({ where: { id } });
    }
  } catch (error) {
    // fallback below
  }

  const idx = mockDb.issues.findIndex((i) => i.id === id);
  if (idx !== -1) {
    mockDb.issues.splice(idx, 1);
  }
};
