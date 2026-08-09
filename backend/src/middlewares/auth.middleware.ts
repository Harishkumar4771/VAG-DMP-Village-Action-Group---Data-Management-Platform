import { Request, Response, NextFunction } from 'express';
import jwt from 'jsonwebtoken';

const JWT_SECRET = process.env.JWT_SECRET || 'super-secret-key';

export interface AuthRequest extends Request {
  user?: {
    userId: string;
    role: string;
  };
}

export const authenticate = (req: AuthRequest, res: Response, next: NextFunction) => {
  const authHeader = req.headers.authorization;

  if (authHeader && authHeader.startsWith('Bearer ')) {
    const token = authHeader.split(' ')[1];
    try {
      const decoded = jwt.verify(token, JWT_SECRET) as { userId: string; role: string };
      req.user = decoded;
      return next();
    } catch (error) {
      // Token invalid
    }
  }

  // Dev / Demo mode fallback when JWT is not provided
  const headerRole = (req.headers['x-user-role'] as string) || 'LEADER';
  const headerUserId = (req.headers['x-user-id'] as string) || (headerRole === 'ADMIN' ? 'admin-001' : 'leader-001');

  req.user = {
    userId: headerUserId,
    role: headerRole,
  };
  next();
};

export const authorize = (roles: string[]) => {
  return (req: AuthRequest, res: Response, next: NextFunction) => {
    if (!req.user || !roles.includes(req.user.role)) {
      return res.status(403).json({ message: 'Forbidden' });
    }
    next();
  };
};
