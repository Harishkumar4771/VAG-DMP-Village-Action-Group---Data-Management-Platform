import express from 'express';
import cors from 'cors';
import dotenv from 'dotenv';
import villageRoutes from './routes/village.routes';
import issueRoutes from './routes/issue.routes';
import meetingRoutes from './routes/meeting.routes';
import authRoutes from './routes/auth.routes';
import syncRoutes from './routes/sync.routes';
import { errorHandler } from './middlewares/error.middleware';

dotenv.config();

const app = express();

app.use(cors());
app.use(express.json());

// Root welcome & API status
app.get('/', (req, res) => {
  res.status(200).json({
    name: 'VAG-DMP Backend API',
    status: 'running',
    version: '1.0.0',
    endpoints: {
      health: '/health',
      auth: '/v1/auth',
      villages: '/v1/villages',
      issues: '/v1/issues',
      meetings: '/v1/meetings',
      sync: '/v1/sync',
    },
  });
});

// Health check
app.get('/health', (req, res) => {
  res.status(200).json({ status: 'ok' });
});

// Routes
app.use('/v1/auth', authRoutes);
app.use('/v1/villages', villageRoutes);
app.use('/v1/issues', issueRoutes);
app.use('/v1/meetings', meetingRoutes);
app.use('/v1/sync', syncRoutes);

// Error handling
app.use(errorHandler);

export default app;
