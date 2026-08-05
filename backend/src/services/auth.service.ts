import prisma from '../config/db';
import jwt from 'jsonwebtoken';
import { mockDb, MockUser } from '../config/mockStore';

const JWT_SECRET = process.env.JWT_SECRET || 'super-secret-key';

export const requestOtp = async (phone: string) => {
  console.log(`Sending OTP to ${phone}: 123456`);
  return true;
};

export const verifyOtp = async (phone: string, otp: string) => {
  if (otp !== '123456') {
    const error: any = new Error('Invalid OTP');
    error.status = 400;
    throw error;
  }

  try {
    const user = await prisma.user.findUnique({
      where: { phone },
      include: { village: true },
    });

    if (user) {
      const token = jwt.sign({ userId: user.id, role: user.role }, JWT_SECRET, { expiresIn: '30d' });
      return { user, token };
    }
  } catch (error) {
    // fallback below
  }

  let mockUser = mockDb.users.find((u) => u.phone === phone);
  if (!mockUser) {
    // Create new mock user
    mockUser = {
      id: `usr_${Date.now()}`,
      name: 'Village Leader',
      phone,
      role: 'LEADER',
      villageId: 'vlg-001',
      createdAt: new Date().toISOString(),
      updatedAt: new Date().toISOString(),
    };
    mockDb.users.push(mockUser);
  }

  const token = jwt.sign({ userId: mockUser.id, role: mockUser.role }, JWT_SECRET, { expiresIn: '30d' });
  const village = mockDb.villages.find((v) => v.id === mockUser?.villageId);
  return { user: { ...mockUser, village }, token };
};

export const register = async (data: { id?: string; name: string; phone: string; role?: any; villageId?: string }) => {
  try {
    const existingUser = await prisma.user.findUnique({ where: { phone: data.phone } });
    if (existingUser) {
      const error: any = new Error('User with this phone number already exists');
      error.status = 400;
      throw error;
    }

    const id = data.id || `usr_${Date.now()}`;
    return await prisma.user.create({
      data: {
        id,
        name: data.name,
        phone: data.phone,
        role: data.role || 'LEADER',
        villageId: data.villageId,
      },
      include: { village: true },
    });
  } catch (error: any) {
    if (error.status === 400) throw error;
  }

  const id = data.id || `usr_${Date.now()}`;
  const newUser: MockUser = {
    id,
    name: data.name,
    phone: data.phone,
    role: data.role || 'LEADER',
    villageId: data.villageId || 'vlg-001',
    createdAt: new Date().toISOString(),
    updatedAt: new Date().toISOString(),
  };
  mockDb.users.push(newUser);

  const village = mockDb.villages.find((v) => v.id === newUser.villageId);
  return { ...newUser, village };
};

export const getUserProfile = async (userId: string) => {
  try {
    const user = await prisma.user.findUnique({
      where: { id: userId },
      include: { village: true },
    });
    if (user) return user;
  } catch (error) {
    // fallback below
  }

  const mockUser = mockDb.users.find((u) => u.id === userId);
  if (!mockUser) {
    const error: any = new Error('User not found');
    error.status = 404;
    throw error;
  }

  const village = mockDb.villages.find((v) => v.id === mockUser.villageId);
  return { ...mockUser, village };
};
