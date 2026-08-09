export interface MockUser {
  id: string;
  name: string;
  phone: string;
  role: 'LEADER' | 'ADMIN';
  villageId?: string | null;
  createdAt: string;
  updatedAt: string;
}

export interface MockVillage {
  id: string;
  name: string;
  district: string;
  state: string;
  memberCount: number;
  lastActivity: string;
  status: string;
  createdAt: string;
  updatedAt: string;
}

export interface MockMedia {
  id: string;
  url: string;
  type: 'BEFORE' | 'AFTER' | 'MEETING' | 'DOCUMENT';
  issueId?: string | null;
  meetingId?: string | null;
  createdAt: string;
}

export interface MockTimeline {
  id: string;
  issueId: string;
  status: string;
  date: string;
  note: string;
  completed: boolean;
}

export interface MockIssue {
  id: string;
  title: string;
  category: 'ROAD' | 'EDUCATION' | 'WATER' | 'SOCIETY';
  status: 'DRAFT' | 'PENDING_SYNC' | 'SUBMITTED' | 'VERIFIED' | 'REVISION_REQUESTED';
  problemDescription: string;
  actionTaken: string;
  expenditureDetails?: string | null;
  villageId: string;
  submittedById: string;
  reportedDate: string;
  resolvedDate?: string | null;
  resolutionNotes?: string | null;
  adminReviewNote?: string | null;
  createdAt: string;
  updatedAt: string;
}

export interface MockProgressUpdate {
  id: string;
  issueId: string;
  type: '15_DAY' | '1_MONTH';
  status: 'NOT_STARTED' | 'WORK_IN_PROGRESS' | 'WAITING_APPROVAL' | 'WAITING_RESOURCES' | 'COMPLETED';
  description: string;
  photoUrl?: string;
  expenditure?: string;
  notes?: string;
  date: string;
}

class MockDatabase {
  users: MockUser[] = [
    {
      id: 'leader-001',
      name: 'Sunita Kumar',
      phone: '+91 98765 43210',
      role: 'LEADER',
      villageId: 'vlg-001',
      createdAt: new Date().toISOString(),
      updatedAt: new Date().toISOString(),
    },
    {
      id: 'admin-001',
      name: 'Priya Deshmukh',
      phone: '+91 98765 00001',
      role: 'ADMIN',
      villageId: null,
      createdAt: new Date().toISOString(),
      updatedAt: new Date().toISOString(),
    },
  ];

  villages: MockVillage[] = [
    {
      id: 'vlg-001',
      name: 'Chandpur',
      district: 'Pune',
      state: 'Maharashtra',
      memberCount: 1250,
      lastActivity: '2 hours ago',
      status: 'Active',
      createdAt: new Date().toISOString(),
      updatedAt: new Date().toISOString(),
    },
    {
      id: 'vlg-002',
      name: 'Khed',
      district: 'Pune',
      state: 'Maharashtra',
      memberCount: 890,
      lastActivity: '1 day ago',
      status: 'Needs Attention',
      createdAt: new Date().toISOString(),
      updatedAt: new Date().toISOString(),
    },
    {
      id: 'vlg-003',
      name: 'Shirur',
      district: 'Pune',
      state: 'Maharashtra',
      memberCount: 2100,
      lastActivity: '3 hours ago',
      status: 'Active',
      createdAt: new Date().toISOString(),
      updatedAt: new Date().toISOString(),
    },
    {
      id: 'vlg-004',
      name: 'Baramati',
      district: 'Pune',
      state: 'Maharashtra',
      memberCount: 3400,
      lastActivity: '5 hours ago',
      status: 'Active',
      createdAt: new Date().toISOString(),
      updatedAt: new Date().toISOString(),
    },
    {
      id: 'vlg-005',
      name: 'Junnar',
      district: 'Pune',
      state: 'Maharashtra',
      memberCount: 1560,
      lastActivity: 'Yesterday',
      status: 'Needs Attention',
      createdAt: new Date().toISOString(),
      updatedAt: new Date().toISOString(),
    },
  ];

  issues: MockIssue[] = [
    {
      id: 'iss-001',
      title: 'Water Pipeline Leak in Ward 3',
      category: 'WATER',
      status: 'COMPLETED',
      problemDescription: 'Leaking main water supply line causing water scarcity in Ward 3.',
      actionTaken: 'Discussed with Gram Panchayat and submitted repair request.',
      expenditureDetails: '₹4,500 spent on replacement PVC pipes and labor.',
      villageId: 'vlg-001',
      submittedById: 'leader-001',
      reportedDate: '2026-07-20T08:30:00Z',
      resolvedDate: '2026-08-04T16:00:00Z',
      adminReviewNote: null,
      createdAt: '2026-07-20T08:30:00Z',
      updatedAt: '2026-08-04T16:00:00Z',
    },
    {
      id: 'iss-002',
      title: 'Solar Street Light Installation in Sector B',
      category: 'ROAD',
      status: 'REPORTED',
      problemDescription: 'Unlit street section leading to safety concerns at night.',
      actionTaken: 'Submitted proposal to Gram Panchayat and surveyed locations.',
      expenditureDetails: 'Estimated ₹12,000 for 4 solar poles.',
      villageId: 'vlg-001',
      submittedById: 'leader-001',
      reportedDate: '2026-08-02T10:15:00Z',
      createdAt: '2026-08-02T10:15:00Z',
      updatedAt: '2026-08-02T10:15:00Z',
    },
    {
      id: 'iss-003',
      title: 'Primary School Roof Waterproofing',
      category: 'EDUCATION',
      status: 'IN_PROGRESS',
      problemDescription: 'Roof leaks during heavy rains impacting Class 4 room.',
      actionTaken: 'Temporary tarp installed; detailed estimate prepared.',
      expenditureDetails: '₹8,200 for waterproof coating.',
      villageId: 'vlg-002',
      submittedById: 'leader-001',
      reportedDate: '2026-07-25T12:00:00Z',
      createdAt: '2026-07-25T12:00:00Z',
      updatedAt: '2026-08-09T12:00:00Z',
    },
    {
      id: 'iss-004',
      title: 'Community Hall Drainage Clearance',
      category: 'SOCIETY',
      status: 'WAITING',
      problemDescription: 'Blocked stormwater drain causing waterlogging near Samaj Mandir.',
      actionTaken: 'Organized volunteer cleanup drive; requested GP suction truck.',
      expenditureDetails: '₹1,500 for tools & gloves.',
      villageId: 'vlg-003',
      submittedById: 'leader-001',
      reportedDate: '2026-07-28T09:00:00Z',
      adminReviewNote: null,
      createdAt: '2026-07-28T09:00:00Z',
      updatedAt: '2026-08-03T11:00:00Z',
    },
  ];

  meetings: MockMeeting[] = [
    {
      id: 'mtg-001',
      villageId: 'vlg-001',
      date: '2026-08-01T10:00:00Z',
      attendeesCount: 45,
      status: 'COMPLETED',
      notes: 'Approved monsoon road repairs and drinking water maintenance budget.',
      createdAt: '2026-08-01T10:00:00Z',
      updatedAt: '2026-08-01T12:00:00Z',
    },
    {
      id: 'mtg-002',
      villageId: 'vlg-001',
      date: '2026-08-10T14:00:00Z',
      attendeesCount: 28,
      status: 'SCHEDULED',
      notes: 'Discussion on SHG micro-loans and village skill development training.',
      createdAt: '2026-08-03T09:00:00Z',
      updatedAt: '2026-08-03T09:00:00Z',
    },
  ];

  media: MockMedia[] = [
    {
      id: 'med-001',
      url: 'https://images.unsplash.com/photo-1541888946425-d0fbb186a5b3?auto=format&fit=crop&w=600&q=80',
      type: 'INITIAL',
      issueId: 'iss-001',
      createdAt: '2026-07-20T08:30:00Z',
    },
    {
      id: 'med-002',
      url: 'https://images.unsplash.com/photo-1581094794329-c8112a89af12?auto=format&fit=crop&w=600&q=80',
      type: 'PROGRESS',
      issueId: 'iss-001',
      createdAt: '2026-08-04T16:00:00Z',
    },
  ];

  timeline: MockTimeline[] = [
    {
      id: 'tml-001',
      issueId: 'iss-001',
      status: 'REPORTED',
      date: '2026-07-20T08:30:00Z',
      note: 'Pipeline leakage identified and reported.',
      completed: true,
    },
    {
      id: 'tml-002',
      issueId: 'iss-001',
      status: 'ACTION_INITIATED',
      date: '2026-07-20T08:30:00Z',
      note: 'Discussed with Gram Panchayat and submitted repair request.',
      completed: true,
    },
    {
      id: 'tml-003',
      issueId: 'iss-001',
      status: 'COMPLETED',
      date: '2026-08-04T16:00:00Z',
      note: 'Repaired joint pipe and sealed leaks with GP approval.',
      completed: true,
    },
  ];

  progressUpdates: MockProgressUpdate[] = [
    {
      id: 'pu-001',
      issueId: 'iss-001',
      type: '15_DAY',
      status: 'WORK_IN_PROGRESS',
      description: 'PVC pipe replacement underway. GP sanctioned labor budget.',
      photoUrl: 'https://images.unsplash.com/photo-1504328345606-18bbc8c9d7d1?auto=format&fit=crop&w=600&q=80',
      expenditure: '₹2,000 advance for materials',
      date: '2026-08-04T10:00:00Z',
    },
    {
      id: 'pu-002',
      issueId: 'iss-001',
      type: '1_MONTH',
      status: 'COMPLETED',
      description: 'All repairs completed. Water supply restored to Ward 3.',
      photoUrl: 'https://images.unsplash.com/photo-1581094794329-c8112a89af12?auto=format&fit=crop&w=600&q=80',
      expenditure: '₹4,500 total (PVC pipes + labor)',
      date: '2026-08-04T16:00:00Z',
    },
    {
      id: 'pu-003',
      issueId: 'iss-003',
      type: '15_DAY',
      status: 'WORK_IN_PROGRESS',
      description: 'Tarp installed as temporary fix. Contractor visited for waterproof coating estimate.',
      expenditure: '₹1,200 for temporary tarp',
      date: '2026-08-09T12:00:00Z',
    },
  ];
}

export const mockDb = new MockDatabase();

