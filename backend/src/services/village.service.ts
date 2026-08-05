import prisma from '../config/db';
import { CreateVillageDto, UpdateVillageDto } from '../types';
import { mockDb, MockVillage } from '../config/mockStore';

export const getAllVillages = async (district?: string, search?: string) => {
  try {
    const where: any = {};

    if (district) {
      where.district = { contains: district, mode: 'insensitive' };
    }

    if (search) {
      where.OR = [
        { name: { contains: search, mode: 'insensitive' } },
        { district: { contains: search, mode: 'insensitive' } },
      ];
    }

    return await prisma.village.findMany({
      where,
      include: {
        _count: {
          select: {
            users: true,
            issues: true,
            meetings: true,
          },
        },
      },
      orderBy: { name: 'asc' },
    });
  } catch (error) {
    // Fallback to in-memory mock data
    let list = [...mockDb.villages];
    if (district) {
      list = list.filter((v) => v.district.toLowerCase().includes(district.toLowerCase()));
    }
    if (search) {
      const s = search.toLowerCase();
      list = list.filter((v) => v.name.toLowerCase().includes(s) || v.district.toLowerCase().includes(s));
    }
    return list.map((v) => ({
      ...v,
      _count: {
        users: mockDb.users.filter((u) => u.villageId === v.id).length,
        issues: mockDb.issues.filter((i) => i.villageId === v.id).length,
        meetings: mockDb.meetings.filter((m) => m.villageId === v.id).length,
      },
    }));
  }
};

export const getVillageById = async (id: string) => {
  try {
    const village = await prisma.village.findUnique({
      where: { id },
      include: {
        users: {
          select: { id: true, name: true, phone: true, role: true },
        },
        issues: {
          take: 10,
          orderBy: { createdAt: 'desc' },
        },
        meetings: {
          take: 10,
          orderBy: { date: 'desc' },
        },
        _count: {
          select: {
            users: true,
            issues: true,
            meetings: true,
          },
        },
      },
    });

    if (village) return village;
  } catch (error) {
    // Continue to mock check below
  }

  const mockVlg = mockDb.villages.find((v) => v.id === id);
  if (!mockVlg) {
    const error: any = new Error('Village not found');
    error.status = 404;
    throw error;
  }

  return {
    ...mockVlg,
    users: mockDb.users.filter((u) => u.villageId === id),
    issues: mockDb.issues.filter((i) => i.villageId === id),
    meetings: mockDb.meetings.filter((m) => m.villageId === id),
    _count: {
      users: mockDb.users.filter((u) => u.villageId === id).length,
      issues: mockDb.issues.filter((i) => i.villageId === id).length,
      meetings: mockDb.meetings.filter((m) => m.villageId === id).length,
    },
  };
};

export const createVillage = async (data: CreateVillageDto) => {
  const id = data.id || `vlg_${Date.now()}_${Math.random().toString(36).substring(2, 7)}`;

  try {
    return await prisma.village.create({
      data: {
        id,
        name: data.name,
        district: data.district,
        state: data.state || 'Maharashtra',
        memberCount: data.memberCount || 0,
        lastActivity: data.lastActivity || new Date().toISOString(),
        status: data.status || 'Active',
      },
    });
  } catch (error) {
    const newVlg: MockVillage = {
      id,
      name: data.name,
      district: data.district,
      state: data.state || 'Maharashtra',
      memberCount: data.memberCount || 0,
      lastActivity: data.lastActivity || 'Just now',
      status: data.status || 'Active',
      createdAt: new Date().toISOString(),
      updatedAt: new Date().toISOString(),
    };
    mockDb.villages.push(newVlg);
    return newVlg;
  }
};

export const updateVillage = async (id: string, data: UpdateVillageDto) => {
  try {
    const village = await prisma.village.findUnique({ where: { id } });
    if (village) {
      return await prisma.village.update({
        where: { id },
        data,
      });
    }
  } catch (error) {
    // fallback below
  }

  const idx = mockDb.villages.findIndex((v) => v.id === id);
  if (idx === -1) {
    const error: any = new Error('Village not found');
    error.status = 404;
    throw error;
  }

  mockDb.villages[idx] = {
    ...mockDb.villages[idx],
    ...data,
    updatedAt: new Date().toISOString(),
  };
  return mockDb.villages[idx];
};

export const deleteVillage = async (id: string) => {
  try {
    const village = await prisma.village.findUnique({ where: { id } });
    if (village) {
      return await prisma.village.delete({ where: { id } });
    }
  } catch (error) {
    // fallback below
  }

  const idx = mockDb.villages.findIndex((v) => v.id === id);
  if (idx !== -1) {
    mockDb.villages.splice(idx, 1);
  }
};
