import prisma from '../config/db';
import jwt from 'jsonwebtoken';

const JWT_SECRET = process.env.JWT_SECRET || 'super-secret-key';

export const requestOtp = async (phone: string) => {
  // In production, send OTP via SMS (Twilio/MSG91)
  console.log(`Sending OTP to ${phone}: 123456`);
  return true;
};

export const verifyOtp = async (phone: string, otp: string) => {
  if (otp !== '123456') {
    const error: any = new Error('Invalid OTP');
    error.status = 400;
    throw error;
  }

  const user = await prisma.user.findUnique({
    where: { phone },
    include: { village: true },
  });

  if (!user) {
    const error: any = new Error('User not found');
    error.status = 444;
    throw error;
  }

  const token = jwt.sign(
    { userId: user.id, role: user.role },
    JWT_SECRET,
    { expiresIn: '30d' }
  );

  return { user, token };
};

export const register = async (data: { id?: string; name: string; phone: string; role?: any; villageId?: string }) => {
  const existingUser = await prisma.user.findUnique({
    where: { phone: data.phone },
  });

  if (existingUser) {
    const error: any = new Error('User with this phone number already exists');
    error.status = 400;
    throw error;
  }

  const id = data.id || `usr_${Date.now()}`;

  return prisma.user.create({
    data: {
      id,
      name: data.name,
      phone: data.phone,
      role: data.role || 'LEADER',
      villageId: data.villageId,
    },
    include: {
      village: true,
    },
  });
};

export const getUserProfile = async (userId: string) => {
  const user = await prisma.user.findUnique({
    where: { id: userId },
    include: { village: true },
  });

  if (!user) {
    const error: any = new Error('User not found');
    error.status = 404;
    throw error;
  }

  return user;
};
