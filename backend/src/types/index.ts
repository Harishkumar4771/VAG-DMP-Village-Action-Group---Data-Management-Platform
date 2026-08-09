import { Request } from 'express';

export type UserRole = 'LEADER' | 'ADMIN';
// Legacy statuses (Flutter app backward compat)
export type SubmissionStatus = 'DRAFT' | 'PENDING_SYNC' | 'SUBMITTED' | 'VERIFIED' | 'REVISION_REQUESTED'
  // New workflow statuses
  | 'REPORTED' | 'ACTION_INITIATED' | 'IN_PROGRESS' | 'WAITING' | 'COMPLETED';
export type IssueCategory = 'ROAD' | 'EDUCATION' | 'WATER' | 'SOCIETY';
export type MeetingStatus = 'SCHEDULED' | 'COMPLETED' | 'CANCELLED';
export type MediaType = 'BEFORE' | 'AFTER' | 'MEETING' | 'DOCUMENT' | 'INITIAL' | 'PROGRESS';

// Progress update types
export type ProgressUpdateType = '15_DAY' | '1_MONTH';
export type ProgressUpdateStatus = 'NOT_STARTED' | 'WORK_IN_PROGRESS' | 'WAITING_APPROVAL' | 'WAITING_RESOURCES' | 'COMPLETED';

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
  district: string;
  state?: string;
  memberCount?: number;
  lastActivity?: string;
  status?: string;
}

export interface UpdateVillageDto {
  name?: string;
  district?: string;
  state?: string;
  memberCount?: number;
  lastActivity?: string;
  status?: string;
}

export interface CreateIssueDto {
  id?: string;
  title: string;
  category: IssueCategory;
  status?: SubmissionStatus;
  problemDescription: string;
  actionTaken: string;
  expenditureDetails?: string;
  villageId: string;
  reportedDate?: string | Date;
  resolvedDate?: string | Date;
  submittedById?: string;
  beforePhotoUrls?: string[];
  afterPhotoUrls?: string[];
  documentUrls?: string[];
}

export interface UpdateIssueDto {
  title?: string;
  category?: IssueCategory;
  status?: SubmissionStatus;
  problemDescription?: string;
  actionTaken?: string;
  expenditureDetails?: string;
  resolutionNotes?: string;
  adminReviewNote?: string;
  resolvedDate?: string | Date;
}

export interface UpdateIssueStatusDto {
  status: SubmissionStatus;
  adminReviewNote?: string;
  note?: string;
}

export interface CreateMeetingDto {
  id?: string;
  villageId: string;
  date: string | Date;
  attendeesCount: number;
  status?: MeetingStatus;
  notes?: string;
  photoUrls?: string[];
}

export interface UpdateMeetingDto {
  villageId?: string;
  date?: string | Date;
  attendeesCount?: number;
  status?: MeetingStatus;
  notes?: string;
  photoUrls?: string[];
}

export interface SyncPushPayload {
  issues?: Array<CreateIssueDto & { id: string }>;
  meetings?: Array<CreateMeetingDto & { id: string }>;
  villages?: Array<CreateVillageDto & { id: string }>;
}

export interface SyncPullResponse {
  serverTime: string;
  issues: any[];
  meetings: any[];
  villages: any[];
}

// Progress Update DTOs
export interface CreateProgressUpdateDto {
  type: ProgressUpdateType;
  status: ProgressUpdateStatus;
  description: string;
  photoDataUrl?: string;
  expenditure?: string;
  notes?: string;
}

export interface ProgressUpdate {
  id: string;
  issueId: string;
  type: ProgressUpdateType;
  status: ProgressUpdateStatus;
  description: string;
  photoUrl?: string;
  expenditure?: string;
  notes?: string;
  date: string;
}
