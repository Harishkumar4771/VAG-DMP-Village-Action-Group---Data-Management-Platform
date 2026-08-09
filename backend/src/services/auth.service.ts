import prisma from '../config/db';
import jwt from 'jsonwebtoken';
import { UserRole } from '../types';

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

  const profile = await prisma.profile.findUnique({
    where: { phone },
    include: { village: true },
  });

  if (profile) {
    const token = jwt.sign({ userId: profile.id, role: profile.role }, JWT_SECRET, { expiresIn: '30d' });
    return { user: profile, token };
  } else {
    // Auto-register for demo purposes
    const newProfile = await prisma.profile.create({
      data: {
        id: `usr_${Date.now()}`,
        phone,
        full_name: 'Village Leader',
        role: 'leader'
      }
    });
    const token = jwt.sign({ userId: newProfile.id, role: newProfile.role }, JWT_SECRET, { expiresIn: '30d' });
    return { user: newProfile, token };
  }
};

export const register = async (data: { id?: string; name: string; phone: string; role?: any; village_id?: string }) => {
  const existingProfile = await prisma.profile.findUnique({ where: { phone: data.phone } });
  if (existingProfile) {
    const error: any = new Error('User with this phone number already exists');
    error.status = 400;
    throw error;
  }

  const id = data.id || `usr_${Date.now()}`;
  return await prisma.profile.create({
    data: {
      id,
      full_name: data.name,
      phone: data.phone,
      role: data.role || 'leader',
      village_id: data.village_id,
    },
    include: { village: true },
  });
};

export const getUserProfile = async (userId: string) => {
  const profile = await prisma.profile.findUnique({
    where: { id: userId },
    include: { village: true },
  });
  
  if (!profile) {
    const error: any = new Error('User not found');
    error.status = 404;
    throw error;
  }

  return profile;
};
