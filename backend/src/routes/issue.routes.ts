import { Router } from 'express';
import * as issueController from '../controllers/issue.controller';
import { authenticate, authorize } from '../middlewares/auth.middleware';

const router = Router();

router.get('/', issueController.getAllIssues);
router.get('/:id', issueController.getIssueById);
router.post('/', authenticate, issueController.createIssue);
router.put('/:id', authenticate, issueController.updateIssue);
router.patch('/:id/status', authenticate, authorize(['ADMIN']), issueController.updateIssueStatus);
router.delete('/:id', authenticate, authorize(['ADMIN']), issueController.deleteIssue);

export default router;
