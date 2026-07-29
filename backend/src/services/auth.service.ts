import prisma from '../config/db';
import jwt from 'jsonwebtoken';

const JWT_SECRET = process.env.JWT_SECRET || 'super-secret-key';

export const requestOtp = async (phone: String) => {
  // In a real app, send OTP via SMS (Twilio/MSG91)
  console.log(`Sending OTP to ${phone}: 123456`);
  return true;
};

export const verifyOtp = async (phone: string, otp: string) => {
  // Mock OTP verification
  if (otp !== '123456') {
    throw new Error('Invalid OTP');
  }

  const user = await prisma.user.findUnique({
    where: { phone },
    include: { village: true },
  });

  if (!user) {
    throw new Error('User not found');
  }

  const token = jwt.sign(
    { userId: user.id, role: user.role },
    JWT_SECRET,
    { expiresIn: '30d' }
  );

  return { user, token };
};

export const register = async (data: any) => {
  const existingUser = await prisma.user.findUnique({
    where: { phone: data.phone },
  });

  if (existingUser) {
    throw new Error('User with this phone number already exists');
  }

  return prisma.user.create({
    data: {
      id: data.id,
      name: data.name,
      phone: data.phone,
      role: data.role,
      villageId: data.villageId,
    },
  });
};
