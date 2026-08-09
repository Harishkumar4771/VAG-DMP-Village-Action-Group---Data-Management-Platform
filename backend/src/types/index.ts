import { Request } from 'express';
import {
  user_role,
  issue_category,
  issue_status,
  meeting_status,
  attachment_type,
  meeting_type
} from '@prisma/client';

export type UserRole = user_role;
export type IssueStatus = issue_status;
export type IssueCategory = issue_category;
export type MeetingStatus = meeting_status;
export type MeetingType = meeting_type;
export type AttachmentType = attachment_type;

export interface AuthenticatedUser {
  userId: string;
  role: UserRole;
}

export interface AuthRequest extends Request {
  user?: AuthenticatedUser;
}

export interface CreateVillageDto {
  id?: string;
  name: string;
  taluka?: string;
  district?: string;
  state?: string;
  gram_panchayat_name?: string;
  chairman_name?: string;
  chairman_phone?: string;
}

export interface UpdateVillageDto {
  name?: string;
  taluka?: string;
  district?: string;
  state?: string;
  gram_panchayat_name?: string;
  chairman_name?: string;
  chairman_phone?: string;
}

export interface CreateIssueDto {
  id?: string;
  local_uuid?: string;
  title: string;
  category: IssueCategory;
  status?: IssueStatus;
  description?: string;
  action_taken?: string;
  priority?: number;
  village_id: string;
  leader_id?: string; // typically inferred from auth, but maybe passed in sync
  created_at?: string | Date;
  resolved_at?: string | Date;
  synced_at?: string | Date;
  attachments?: { type: AttachmentType, storage_path: string }[];
}

export interface UpdateIssueDto {
  title?: string;
  category?: IssueCategory;
  status?: IssueStatus;
  description?: string;
  action_taken?: string;
  priority?: number;
  verification_notes?: string;
  resolved_at?: string | Date;
}

export interface UpdateIssueStatusDto {
  status: IssueStatus;
  verification_notes?: string;
  remarks?: string;
}

export interface CreateMeetingDto {
  id?: string;
  local_uuid?: string;
  village_id: string;
  type: MeetingType;
  title?: string;
  scheduled_date: string | Date;
  status?: MeetingStatus;
  agenda?: string;
  minutes_notes?: string;
  attendees?: { name: string, role?: string, present?: boolean }[];
}

export interface UpdateMeetingDto {
  village_id?: string;
  type?: MeetingType;
  title?: string;
  scheduled_date?: string | Date;
  status?: MeetingStatus;
  agenda?: string;
  minutes_notes?: string;
}

export interface SyncPushPayload {
  issues?: CreateIssueDto[];
  meetings?: CreateMeetingDto[];
  villages?: CreateVillageDto[];
}

export interface SyncPullResponse {
  serverTime: string;
  issues: any[];
  meetings: any[];
  villages: any[];
}

// Progress Update DTOs - kept for compatibility if needed, but adapt them to the new schema
export interface CreateProgressUpdateDto {
  status: IssueStatus;
  description: string;
  photoDataUrl?: string; // handled as attachment
  expenditure?: string; // no longer explicitly in schema, maybe goes in remarks/description
  notes?: string;
}
