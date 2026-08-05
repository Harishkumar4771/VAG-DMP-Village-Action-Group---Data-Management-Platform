import prisma from '../config/db';
import { CreateMeetingDto, UpdateMeetingDto, MeetingStatus, MediaType } from '../types';
import { mockDb, MockMeeting } from '../config/mockStore';

export const getAllMeetings = async (filters?: { villageId?: string; status?: string }) => {
  try {
    const where: any = {};
    if (filters?.villageId) where.villageId = filters.villageId;
    if (filters?.status) where.status = filters.status as MeetingStatus;

    return await prisma.meeting.findMany({
      where,
      include: {
        village: { select: { id: true, name: true, district: true } },
        media: true,
      },
      orderBy: { date: 'desc' },
    });
  } catch (error) {
    let items = [...mockDb.meetings];
    if (filters?.villageId) items = items.filter((m) => m.villageId === filters.villageId);
    if (filters?.status) items = items.filter((m) => m.status === filters.status);

    return items.map((mtg) => ({
      ...mtg,
      village: mockDb.villages.find((v) => v.id === mtg.villageId) || { id: mtg.villageId, name: 'Chandpur', district: 'Pune' },
      media: mockDb.media.filter((m) => m.meetingId === mtg.id),
    }));
  }
};

export const getMeetingById = async (id: string) => {
  try {
    const meeting = await prisma.meeting.findUnique({
      where: { id },
      include: { village: true, media: true },
    });
    if (meeting) return meeting;
  } catch (error) {
    // fallback below
  }

  const mtg = mockDb.meetings.find((m) => m.id === id);
  if (!mtg) {
    const error: any = new Error('Meeting record not found');
    error.status = 404;
    throw error;
  }

  return {
    ...mtg,
    village: mockDb.villages.find((v) => v.id === mtg.villageId),
    media: mockDb.media.filter((m) => m.meetingId === mtg.id),
  };
};

export const createMeeting = async (data: CreateMeetingDto) => {
  const id = data.id || `mtg_${Date.now()}_${Math.random().toString(36).substring(2, 7)}`;
  const date = new Date(data.date);

  try {
    const mediaCreates: any[] = [];
    if (data.photoUrls) {
      for (const url of data.photoUrls) {
        mediaCreates.push({ url, type: 'MEETING' as MediaType });
      }
    }

    return await prisma.meeting.create({
      data: {
        id,
        villageId: data.villageId,
        date,
        attendeesCount: data.attendeesCount,
        status: data.status || 'SCHEDULED',
        notes: data.notes,
        media: { create: mediaCreates },
      },
      include: { village: true, media: true },
    });
  } catch (error) {
    const newMtg: MockMeeting = {
      id,
      villageId: data.villageId,
      date: date.toISOString(),
      attendeesCount: data.attendeesCount,
      status: data.status || 'SCHEDULED',
      notes: data.notes || null,
      createdAt: new Date().toISOString(),
      updatedAt: new Date().toISOString(),
    };
    mockDb.meetings.push(newMtg);

    return {
      ...newMtg,
      village: mockDb.villages.find((v) => v.id === data.villageId),
      media: [],
    };
  }
};

export const updateMeeting = async (id: string, data: UpdateMeetingDto) => {
  try {
    const existing = await prisma.meeting.findUnique({ where: { id } });
    if (existing) {
      const updateData: any = { ...data };
      if (data.date) updateData.date = new Date(data.date);
      return await prisma.meeting.update({
        where: { id },
        data: updateData,
        include: { village: true, media: true },
      });
    }
  } catch (error) {
    // fallback below
  }

  const idx = mockDb.meetings.findIndex((m) => m.id === id);
  if (idx === -1) {
    const error: any = new Error('Meeting record not found');
    error.status = 404;
    throw error;
  }

  mockDb.meetings[idx] = {
    ...mockDb.meetings[idx],
    ...(data as any),
    date: data.date ? new Date(data.date).toISOString() : mockDb.meetings[idx].date,
    updatedAt: new Date().toISOString(),
  };

  return {
    ...mockDb.meetings[idx],
    village: mockDb.villages.find((v) => v.id === mockDb.meetings[idx].villageId),
    media: mockDb.media.filter((m) => m.meetingId === id),
  };
};

export const deleteMeeting = async (id: string) => {
  try {
    const existing = await prisma.meeting.findUnique({ where: { id } });
    if (existing) {
      await prisma.media.deleteMany({ where: { meetingId: id } });
      return await prisma.meeting.delete({ where: { id } });
    }
  } catch (error) {
    // fallback below
  }

  const idx = mockDb.meetings.findIndex((m) => m.id === id);
  if (idx !== -1) {
    mockDb.meetings.splice(idx, 1);
  }
};
