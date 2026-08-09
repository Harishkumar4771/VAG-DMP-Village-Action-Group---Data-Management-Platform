import prisma from '../config/db';
import { SyncPushPayload, SyncPullResponse } from '../types';
import * as issueService from './issue.service';
import * as meetingService from './meeting.service';
import * as villageService from './village.service';

export const syncPush = async (payload: SyncPushPayload, userId?: string) => {
  let issuesCount = 0;
  let meetingsCount = 0;
  let villagesCount = 0;

  // 1. Sync Villages
  if (payload.villages && payload.villages.length > 0) {
    for (const v of payload.villages) {
      try {
        const existing = await prisma.village.findUnique({ where: { id: v.id } });
        if (existing) {
          await villageService.updateVillage(v.id, v);
        } else {
          await villageService.createVillage(v);
        }
      } catch (error) {
        // Fallback to service handling
        try {
          await villageService.updateVillage(v.id, v);
        } catch (e) {
          await villageService.createVillage(v);
        }
      }
      villagesCount++;
    }
  }

  // 2. Sync Issues
  if (payload.issues && payload.issues.length > 0) {
    for (const iss of payload.issues) {
      try {
        const existing = await prisma.issue.findUnique({ where: { id: iss.id } });
        if (existing) {
          await issueService.updateIssue(iss.id, iss);
        } else {
          await issueService.createIssue(iss, userId);
        }
      } catch (error) {
        try {
          await issueService.updateIssue(iss.id, iss);
        } catch (e) {
          await issueService.createIssue(iss, userId);
        }
      }
      issuesCount++;
    }
  }

  // 3. Sync Meetings
  if (payload.meetings && payload.meetings.length > 0) {
    for (const mtg of payload.meetings) {
      try {
        const existing = await prisma.meeting.findUnique({ where: { id: mtg.id } });
        if (existing) {
          await meetingService.updateMeeting(mtg.id, mtg);
        } else {
          await meetingService.createMeeting(mtg);
        }
      } catch (error) {
        try {
          await meetingService.updateMeeting(mtg.id, mtg);
        } catch (e) {
          await meetingService.createMeeting(mtg);
        }
      }
      meetingsCount++;
    }
  }

  return {
    success: true,
    synced: {
      issuesCount,
      meetingsCount,
      villagesCount,
    },
    timestamp: new Date().toISOString(),
  };
};

export const syncPull = async (sinceTimestamp?: string): Promise<SyncPullResponse> => {
  const since = sinceTimestamp ? new Date(sinceTimestamp) : new Date(0);

  try {
    const [issues, meetings, villages] = await Promise.all([
      prisma.issue.findMany({
        where: { updatedAt: { gt: since } },
        include: { village: true, media: true, timeline: true },
      }),
      prisma.meeting.findMany({
        where: { updatedAt: { gt: since } },
        include: { village: true, media: true },
      }),
      prisma.village.findMany({
        where: { updatedAt: { gt: since } },
      }),
    ]);

    return {
      serverTime: new Date().toISOString(),
      issues,
      meetings,
      villages,
    };
  } catch (error) {
    const issues = (await issueService.getAllIssues({})).items;
    const meetings = await meetingService.getAllMeetings();
    const villages = await villageService.getAllVillages();

    return {
      serverTime: new Date().toISOString(),
      issues: issues as any,
      meetings: meetings as any,
      villages: villages as any,
    };
  }
};
