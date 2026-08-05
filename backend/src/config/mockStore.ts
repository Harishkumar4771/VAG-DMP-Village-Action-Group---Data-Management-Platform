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

export interface MockMeeting {
  id: string;
  villageId: string;
  date: string;
  attendeesCount: number;
  status: 'SCHEDULED' | 'COMPLETED' | 'CANCELLED';
  notes?: string | null;
  createdAt: string;
  updatedAt: string;
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
      title: 'Water pipeline repair near Primary School',
      category: 'WATER',
      status: 'VERIFIED',
      problemDescription: 'Leaking main water supply line causing water scarcity in Ward 3.',
      actionTaken: 'Repaired joint pipe and sealed leaks with GP approval.',
      expenditureDetails: '₹4,500 spent on replacement PVC pipes and labor.',
      villageId: 'vlg-001',
      submittedById: 'leader-001',
      reportedDate: '2026-07-20T08:30:00Z',
      resolvedDate: '2026-07-25T16:00:00Z',
      adminReviewNote: 'Verified with Gram Panchayat letter attached.',
      createdAt: '2026-07-20T08:30:00Z',
      updatedAt: '2026-07-25T16:00:00Z',
    },
    {
      id: 'iss-002',
      title: 'Solar Street Light Installation in Sector B',
      category: 'ROAD',
      status: 'SUBMITTED',
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
      status: 'PENDING_SYNC',
      problemDescription: 'Roof leaks during heavy rains impacting Class 4 room.',
      actionTaken: 'Temporary tarp installed; detailed estimate prepared.',
      expenditureDetails: '₹8,200 for waterproof coating.',
      villageId: 'vlg-002',
      submittedById: 'leader-001',
      reportedDate: '2026-08-04T12:00:00Z',
      createdAt: '2026-08-04T12:00:00Z',
      updatedAt: '2026-08-04T12:00:00Z',
    },
    {
      id: 'iss-004',
      title: 'Community Hall Drainage Clearance',
      category: 'SOCIETY',
      status: 'REVISION_REQUESTED',
      problemDescription: 'Blocked stormwater drain causing waterlogging near Samaj Mandir.',
      actionTaken: 'Organized volunteer cleanup drive; requested GP suction truck.',
      expenditureDetails: '₹1,500 for tools & gloves.',
      villageId: 'vlg-003',
      submittedById: 'leader-001',
      reportedDate: '2026-08-01T09:00:00Z',
      adminReviewNote: 'Please attach official Gram Panchayat receipt for expenditure.',
      createdAt: '2026-08-01T09:00:00Z',
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
      type: 'BEFORE',
      issueId: 'iss-001',
      createdAt: new Date().toISOString(),
    },
    {
      id: 'med-002',
      url: 'https://images.unsplash.com/photo-1581094794329-c8112a89af12?auto=format&fit=crop&w=600&q=80',
      type: 'AFTER',
      issueId: 'iss-001',
      createdAt: new Date().toISOString(),
    },
  ];

  timeline: MockTimeline[] = [
    {
      id: 'tml-001',
      issueId: 'iss-001',
      status: 'SUBMITTED',
      date: '2026-07-20T08:30:00Z',
      note: 'Issue reported by Leader',
      completed: true,
    },
    {
      id: 'tml-002',
      issueId: 'iss-001',
      status: 'VERIFIED',
      date: '2026-07-25T16:00:00Z',
      note: 'Verified and closed by Admin',
      completed: true,
    },
  ];
}

export const mockDb = new MockDatabase();
