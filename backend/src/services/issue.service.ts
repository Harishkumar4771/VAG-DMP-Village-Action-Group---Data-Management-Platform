import prisma from '../config/db';
import { CreateIssueDto, UpdateIssueDto, IssueStatus, IssueCategory, AttachmentType } from '../types';

export const getAllIssues = async (filters?: {
  category?: string;
  status?: string;
  village_id?: string;
  leader_id?: string;
  search?: string;
  limit?: number;
  offset?: number;
}) => {
  const where: any = { is_deleted: false };

  if (filters?.category) {
    where.category = filters.category as IssueCategory;
  }

  if (filters?.status) {
    where.status = filters.status as IssueStatus;
  }

  if (filters?.village_id) {
    where.village_id = filters.village_id;
  }

  if (filters?.leader_id) {
    where.leader_id = filters.leader_id;
  }

  if (filters?.search) {
    where.OR = [
      { title: { contains: filters.search, mode: 'insensitive' } },
      { description: { contains: filters.search, mode: 'insensitive' } },
      { action_taken: { contains: filters.search, mode: 'insensitive' } },
    ];
  }

  const [items, total] = await Promise.all([
    prisma.issue.findMany({
      where,
      include: {
        village: { select: { id: true, name: true, district: true } },
        leader: { select: { id: true, full_name: true, phone: true } },
        attachments: true,
        history: { orderBy: { changed_at: 'asc' } },
      },
      orderBy: { created_at: 'desc' },
      take: filters?.limit ? Number(filters.limit) : 50,
      skip: filters?.offset ? Number(filters.offset) : 0,
    }),
    prisma.issue.count({ where }),
  ]);

  return { items, total };
};

export const getIssueById = async (id: string) => {
  const issue = await prisma.issue.findUnique({
    where: { id },
    include: {
      village: true,
      leader: { select: { id: true, full_name: true, phone: true, role: true } },
      attachments: true,
      history: { orderBy: { changed_at: 'asc' } },
    },
  });

  if (!issue) {
    const error: any = new Error('Issue not found');
    error.status = 404;
    throw error;
  }
  return issue;
};

export const createIssue = async (data: CreateIssueDto, fallbackUserId?: string) => {
  const leader_id = data.leader_id || fallbackUserId;
  if (!leader_id) throw new Error("leader_id is required");

  const created_at = data.created_at ? new Date(data.created_at) : new Date();
  const status = data.status || 'reported';

  const attachmentCreates = data.attachments?.map(a => ({
    type: a.type,
    storage_path: a.storage_path,
    uploaded_by: leader_id
  })) || [];

  return await prisma.issue.create({
    data: {
      id: data.id,
      local_uuid: data.local_uuid,
      title: data.title,
      category: data.category,
      status,
      description: data.description,
      action_taken: data.action_taken,
      priority: data.priority,
      village_id: data.village_id,
      leader_id,
      created_at,
      resolved_at: data.resolved_at ? new Date(data.resolved_at) : null,
      history: {
        create: [{ new_status: status, changed_at: created_at, remarks: 'Submission recorded', changed_by: leader_id }],
      },
      attachments: { create: attachmentCreates },
    },
    include: { village: true, leader: true, attachments: true, history: true },
  });
};

export const updateIssue = async (id: string, data: UpdateIssueDto, userId?: string) => {
  const updateData: any = { ...data };
  if (data.resolved_at) updateData.resolved_at = new Date(data.resolved_at);
  updateData.updated_at = new Date();

  return await prisma.issue.update({
    where: { id },
    data: updateData,
    include: { village: true, attachments: true, history: true },
  });
};

export const updateIssueStatus = async (
  id: string,
  status: IssueStatus,
  verification_notes?: string,
  remarks?: string,
  userId?: string
) => {
  const existing = await prisma.issue.findUnique({ where: { id } });
  if (!existing) {
    const error: any = new Error('Issue not found');
    error.status = 404;
    throw error;
  }

  const isResolved = status === 'resolved';
  const resolved_at = isResolved ? new Date() : existing.resolved_at;

  return await prisma.issue.update({
    where: { id },
    data: {
      status,
      verification_notes: verification_notes || existing.verification_notes,
      resolved_at,
      updated_at: new Date(),
      history: {
        create: {
          old_status: existing.status,
          new_status: status,
          changed_at: new Date(),
          remarks: remarks || (verification_notes ? `Admin Note: ${verification_notes}` : `Status updated to ${status}`),
          changed_by: userId,
        },
      },
    },
    include: { village: true, attachments: true, history: { orderBy: { changed_at: 'asc' } } },
  });
};

export const deleteIssue = async (id: string) => {
  return await prisma.issue.update({
    where: { id },
    data: { is_deleted: true, updated_at: new Date() }
  });
};
