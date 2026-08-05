import prisma from '../config/db';
import { CreateMeetingDto, UpdateMeetingDto, MeetingStatus, MediaType } from '../types';

export const getAllMeetings = async (villageId?: string, status?: string, search?: string) => {
  const where: any = {};

  if (villageId) {
    where.villageId = villageId;
  }

  if (status) {
    where.status = status as MeetingStatus;
  }

  if (search) {
    where.OR = [
      { notes: { contains: search, mode: 'insensitive' } },
      { village: { name: { contains: search, mode: 'insensitive' } } },
    ];
  }

  return prisma.meeting.findMany({
    where,
    include: {
      village: {
        select: { id: true, name: true, district: true },
      },
      media: true,
    },
    orderBy: { date: 'desc' },
  });
};

export const getMeetingById = async (id: string) => {
  const meeting = await prisma.meeting.findUnique({
    where: { id },
    include: {
      village: true,
      media: true,
    },
  });

  if (!meeting) {
    const error: any = new Error('Meeting record not found');
    error.status = 404;
    throw error;
  }

  return meeting;
};

export const createMeeting = async (data: CreateMeetingDto) => {
  const id = data.id || `mtg_${Date.now()}_${Math.random().toString(36).substring(2, 7)}`;
  const date = new Date(data.date);

  const mediaCreates: any[] = [];
  if (data.photoUrls) {
    for (const url of data.photoUrls) {
      mediaCreates.push({ url, type: 'MEETING' as MediaType });
    }
  }

  return prisma.meeting.create({
    data: {
      id,
      villageId: data.villageId,
      date,
      attendeesCount: data.attendeesCount,
      status: data.status || 'SCHEDULED',
      notes: data.notes,
      media: {
        create: mediaCreates,
      },
    },
    include: {
      village: true,
      media: true,
    },
  });
};

export const updateMeeting = async (id: string, data: UpdateMeetingDto) => {
  const existing = await prisma.meeting.findUnique({ where: { id } });
  if (!existing) {
    const error: any = new Error('Meeting record not found');
    error.status = 404;
    throw error;
  }

  const updateData: any = { ...data };
  if (data.date) {
    updateData.date = new Date(data.date);
  }
  delete updateData.photoUrls;

  return prisma.meeting.update({
    where: { id },
    data: updateData,
    include: {
      village: true,
      media: true,
    },
  });
};

export const deleteMeeting = async (id: string) => {
  const existing = await prisma.meeting.findUnique({ where: { id } });
  if (!existing) {
    const error: any = new Error('Meeting record not found');
    error.status = 404;
    throw error;
  }

  await prisma.media.deleteMany({ where: { meetingId: id } });

  return prisma.meeting.delete({ where: { id } });
};
