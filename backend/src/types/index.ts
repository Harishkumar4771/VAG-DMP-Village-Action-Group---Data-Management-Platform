import { Request } from 'express';

export type UserRole = 'LEADER' | 'ADMIN';
export type SubmissionStatus = 'DRAFT' | 'PENDING_SYNC' | 'SUBMITTED' | 'VERIFIED' | 'REVISION_REQUESTED';
export type IssueCategory = 'ROAD' | 'EDUCATION' | 'WATER' | 'SOCIETY';
export type MeetingStatus = 'SCHEDULED' | 'COMPLETED' | 'CANCELLED';
export type MediaType = 'BEFORE' | 'AFTER' | 'MEETING' | 'DOCUMENT';

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
