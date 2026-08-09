// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'issue_model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetIssueModelCollection on Isar {
  IsarCollection<IssueModel> get issueModels => this.collection();
}

const IssueModelSchema = CollectionSchema(
  name: r'IssueModel',
  id: -49858367599285,
  properties: {
    r'actionTaken': PropertySchema(
      id: 0,
      name: r'actionTaken',
      type: IsarType.string,
    ),
    r'adminReviewNote': PropertySchema(
      id: 1,
      name: r'adminReviewNote',
      type: IsarType.string,
    ),
    r'afterPhotoPaths': PropertySchema(
      id: 2,
      name: r'afterPhotoPaths',
      type: IsarType.stringList,
    ),
    r'beforePhotoPaths': PropertySchema(
      id: 3,
      name: r'beforePhotoPaths',
      type: IsarType.stringList,
    ),
    r'category': PropertySchema(
      id: 4,
      name: r'category',
      type: IsarType.byte,
      enumMap: _IssueModelcategoryEnumValueMap,
    ),
    r'documentPaths': PropertySchema(
      id: 5,
      name: r'documentPaths',
      type: IsarType.stringList,
    ),
    r'expenditureDetails': PropertySchema(
      id: 6,
      name: r'expenditureDetails',
      type: IsarType.string,
    ),
    r'id': PropertySchema(
      id: 7,
      name: r'id',
      type: IsarType.string,
    ),
    r'problemDescription': PropertySchema(
      id: 8,
      name: r'problemDescription',
      type: IsarType.string,
    ),
    r'reportedDate': PropertySchema(
      id: 9,
      name: r'reportedDate',
      type: IsarType.dateTime,
    ),
    r'resolutionNotes': PropertySchema(
      id: 10,
      name: r'resolutionNotes',
      type: IsarType.string,
    ),
    r'resolvedDate': PropertySchema(
      id: 11,
      name: r'resolvedDate',
      type: IsarType.dateTime,
    ),
    r'status': PropertySchema(
      id: 12,
      name: r'status',
      type: IsarType.byte,
      enumMap: _IssueModelstatusEnumValueMap,
    ),
    r'submittedBy': PropertySchema(
      id: 13,
      name: r'submittedBy',
      type: IsarType.string,
    ),
    r'syncStatus': PropertySchema(
      id: 14,
      name: r'syncStatus',
      type: IsarType.byte,
      enumMap: _IssueModelsyncStatusEnumValueMap,
    ),
    r'timeline': PropertySchema(
      id: 15,
      name: r'timeline',
      type: IsarType.objectList,
      target: r'IssueTimelineEntryModel',
    ),
    r'title': PropertySchema(
      id: 16,
      name: r'title',
      type: IsarType.string,
    ),
    r'villageId': PropertySchema(
      id: 17,
      name: r'villageId',
      type: IsarType.string,
    ),
    r'villageName': PropertySchema(
      id: 18,
      name: r'villageName',
      type: IsarType.string,
    )
  },
  estimateSize: _issueModelEstimateSize,
  serialize: _issueModelSerialize,
  deserialize: _issueModelDeserialize,
  deserializeProp: _issueModelDeserializeProp,
  idName: r'isarId',
  indexes: {
    r'id': IndexSchema(
      id: -32684016739934,
      name: r'id',
      unique: true,
      replace: true,
      properties: [
        IndexPropertySchema(
          name: r'id',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    ),
    r'villageId': IndexSchema(
      id: -32233256718329,
      name: r'villageId',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'villageId',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    ),
    r'syncStatus': IndexSchema(
      id: 823953937504568,
      name: r'syncStatus',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'syncStatus',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    ),
    r'submittedBy': IndexSchema(
      id: -84170936743535,
      name: r'submittedBy',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'submittedBy',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {r'IssueTimelineEntryModel': IssueTimelineEntryModelSchema},
  getId: _issueModelGetId,
  getLinks: _issueModelGetLinks,
  attach: _issueModelAttach,
  version: '3.1.0+1',
);

int _issueModelEstimateSize(
  IssueModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.actionTaken.length * 3;
  {
    final value = object.adminReviewNote;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.afterPhotoPaths.length * 3;
  {
    for (var i = 0; i < object.afterPhotoPaths.length; i++) {
      final value = object.afterPhotoPaths[i];
      bytesCount += value.length * 3;
    }
  }
  bytesCount += 3 + object.beforePhotoPaths.length * 3;
  {
    for (var i = 0; i < object.beforePhotoPaths.length; i++) {
      final value = object.beforePhotoPaths[i];
      bytesCount += value.length * 3;
    }
  }
  bytesCount += 3 + object.documentPaths.length * 3;
  {
    for (var i = 0; i < object.documentPaths.length; i++) {
      final value = object.documentPaths[i];
      bytesCount += value.length * 3;
    }
  }
  {
    final value = object.expenditureDetails;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.id.length * 3;
  bytesCount += 3 + object.problemDescription.length * 3;
  {
    final value = object.resolutionNotes;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.submittedBy.length * 3;
  bytesCount += 3 + object.timeline.length * 3;
  {
    final offsets = allOffsets[IssueTimelineEntryModel]!;
    for (var i = 0; i < object.timeline.length; i++) {
      final value = object.timeline[i];
      bytesCount += IssueTimelineEntryModelSchema.estimateSize(
          value, offsets, allOffsets);
    }
  }
  bytesCount += 3 + object.title.length * 3;
  bytesCount += 3 + object.villageId.length * 3;
  bytesCount += 3 + object.villageName.length * 3;
  return bytesCount;
}

void _issueModelSerialize(
  IssueModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.actionTaken);
  writer.writeString(offsets[1], object.adminReviewNote);
  writer.writeStringList(offsets[2], object.afterPhotoPaths);
  writer.writeStringList(offsets[3], object.beforePhotoPaths);
  writer.writeByte(offsets[4], object.category.index);
  writer.writeStringList(offsets[5], object.documentPaths);
  writer.writeString(offsets[6], object.expenditureDetails);
  writer.writeString(offsets[7], object.id);
  writer.writeString(offsets[8], object.problemDescription);
  writer.writeDateTime(offsets[9], object.reportedDate);
  writer.writeString(offsets[10], object.resolutionNotes);
  writer.writeDateTime(offsets[11], object.resolvedDate);
  writer.writeByte(offsets[12], object.status.index);
  writer.writeString(offsets[13], object.submittedBy);
  writer.writeByte(offsets[14], object.syncStatus.index);
  writer.writeObjectList<IssueTimelineEntryModel>(
    offsets[15],
    allOffsets,
    IssueTimelineEntryModelSchema.serialize,
    object.timeline,
  );
  writer.writeString(offsets[16], object.title);
  writer.writeString(offsets[17], object.villageId);
  writer.writeString(offsets[18], object.villageName);
}

IssueModel _issueModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = IssueModel();
  object.actionTaken = reader.readString(offsets[0]);
  object.adminReviewNote = reader.readStringOrNull(offsets[1]);
  object.afterPhotoPaths = reader.readStringList(offsets[2]) ?? [];
  object.beforePhotoPaths = reader.readStringList(offsets[3]) ?? [];
  object.category =
      _IssueModelcategoryValueEnumMap[reader.readByteOrNull(offsets[4])] ??
          IssueCategory.road;
  object.documentPaths = reader.readStringList(offsets[5]) ?? [];
  object.expenditureDetails = reader.readStringOrNull(offsets[6]);
  object.id = reader.readString(offsets[7]);
  object.problemDescription = reader.readString(offsets[8]);
  object.reportedDate = reader.readDateTime(offsets[9]);
  object.resolutionNotes = reader.readStringOrNull(offsets[10]);
  object.resolvedDate = reader.readDateTimeOrNull(offsets[11]);
  object.status =
      _IssueModelstatusValueEnumMap[reader.readByteOrNull(offsets[12])] ??
          SubmissionStatus.draft;
  object.submittedBy = reader.readString(offsets[13]);
  object.syncStatus =
      _IssueModelsyncStatusValueEnumMap[reader.readByteOrNull(offsets[14])] ??
          SyncStatus.synced;
  object.timeline = reader.readObjectList<IssueTimelineEntryModel>(
        offsets[15],
        IssueTimelineEntryModelSchema.deserialize,
        allOffsets,
        IssueTimelineEntryModel(),
      ) ??
      [];
  object.title = reader.readString(offsets[16]);
  object.villageId = reader.readString(offsets[17]);
  object.villageName = reader.readString(offsets[18]);
  return object;
}

P _issueModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readStringOrNull(offset)) as P;
    case 2:
      return (reader.readStringList(offset) ?? []) as P;
    case 3:
      return (reader.readStringList(offset) ?? []) as P;
    case 4:
      return (_IssueModelcategoryValueEnumMap[reader.readByteOrNull(offset)] ??
          IssueCategory.road) as P;
    case 5:
      return (reader.readStringList(offset) ?? []) as P;
    case 6:
      return (reader.readStringOrNull(offset)) as P;
    case 7:
      return (reader.readString(offset)) as P;
    case 8:
      return (reader.readString(offset)) as P;
    case 9:
      return (reader.readDateTime(offset)) as P;
    case 10:
      return (reader.readStringOrNull(offset)) as P;
    case 11:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 12:
      return (_IssueModelstatusValueEnumMap[reader.readByteOrNull(offset)] ??
          SubmissionStatus.draft) as P;
    case 13:
      return (reader.readString(offset)) as P;
    case 14:
      return (_IssueModelsyncStatusValueEnumMap[
              reader.readByteOrNull(offset)] ??
          SyncStatus.synced) as P;
    case 15:
      return (reader.readObjectList<IssueTimelineEntryModel>(
            offset,
            IssueTimelineEntryModelSchema.deserialize,
            allOffsets,
            IssueTimelineEntryModel(),
          ) ??
          []) as P;
    case 16:
      return (reader.readString(offset)) as P;
    case 17:
      return (reader.readString(offset)) as P;
    case 18:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _IssueModelcategoryEnumValueMap = {
  'road': 0,
  'education': 1,
  'water': 2,
  'society': 3,
};
const _IssueModelcategoryValueEnumMap = {
  0: IssueCategory.road,
  1: IssueCategory.education,
  2: IssueCategory.water,
  3: IssueCategory.society,
};
const _IssueModelstatusEnumValueMap = {
  'draft': 0,
  'pendingSync': 1,
  'submitted': 2,
  'verified': 3,
  'revisionRequested': 4,
};
const _IssueModelstatusValueEnumMap = {
  0: SubmissionStatus.draft,
  1: SubmissionStatus.pendingSync,
  2: SubmissionStatus.submitted,
  3: SubmissionStatus.verified,
  4: SubmissionStatus.revisionRequested,
};
const _IssueModelsyncStatusEnumValueMap = {
  'synced': 0,
  'pendingCreate': 1,
  'pendingUpdate': 2,
  'pendingDelete': 3,
};
const _IssueModelsyncStatusValueEnumMap = {
  0: SyncStatus.synced,
  1: SyncStatus.pendingCreate,
  2: SyncStatus.pendingUpdate,
  3: SyncStatus.pendingDelete,
};

Id _issueModelGetId(IssueModel object) {
  return object.isarId;
}

List<IsarLinkBase<dynamic>> _issueModelGetLinks(IssueModel object) {
  return [];
}

void _issueModelAttach(IsarCollection<dynamic> col, Id id, IssueModel object) {}

extension IssueModelByIndex on IsarCollection<IssueModel> {
  Future<IssueModel?> getById(String id) {
    return getByIndex(r'id', [id]);
  }

  IssueModel? getByIdSync(String id) {
    return getByIndexSync(r'id', [id]);
  }

  Future<bool> deleteById(String id) {
    return deleteByIndex(r'id', [id]);
  }

  bool deleteByIdSync(String id) {
    return deleteByIndexSync(r'id', [id]);
  }

  Future<List<IssueModel?>> getAllById(List<String> idValues) {
    final values = idValues.map((e) => [e]).toList();
    return getAllByIndex(r'id', values);
  }

  List<IssueModel?> getAllByIdSync(List<String> idValues) {
    final values = idValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'id', values);
  }

  Future<int> deleteAllById(List<String> idValues) {
    final values = idValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'id', values);
  }

  int deleteAllByIdSync(List<String> idValues) {
    final values = idValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'id', values);
  }

  Future<Id> putById(IssueModel object) {
    return putByIndex(r'id', object);
  }

  Id putByIdSync(IssueModel object, {bool saveLinks = true}) {
    return putByIndexSync(r'id', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllById(List<IssueModel> objects) {
    return putAllByIndex(r'id', objects);
  }

  List<Id> putAllByIdSync(List<IssueModel> objects, {bool saveLinks = true}) {
    return putAllByIndexSync(r'id', objects, saveLinks: saveLinks);
  }
}

extension IssueModelQueryWhereSort
    on QueryBuilder<IssueModel, IssueModel, QWhere> {
  QueryBuilder<IssueModel, IssueModel, QAfterWhere> anyIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterWhere> anySyncStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'syncStatus'),
      );
    });
  }
}

extension IssueModelQueryWhere
    on QueryBuilder<IssueModel, IssueModel, QWhereClause> {
  QueryBuilder<IssueModel, IssueModel, QAfterWhereClause> isarIdEqualTo(
      Id isarId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: isarId,
        upper: isarId,
      ));
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterWhereClause> isarIdNotEqualTo(
      Id isarId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: isarId, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: isarId, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: isarId, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: isarId, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterWhereClause> isarIdGreaterThan(
      Id isarId,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: isarId, includeLower: include),
      );
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterWhereClause> isarIdLessThan(
      Id isarId,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: isarId, includeUpper: include),
      );
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterWhereClause> isarIdBetween(
    Id lowerIsarId,
    Id upperIsarId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerIsarId,
        includeLower: includeLower,
        upper: upperIsarId,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterWhereClause> idEqualTo(String id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'id',
        value: [id],
      ));
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterWhereClause> idNotEqualTo(
      String id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'id',
              lower: [],
              upper: [id],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'id',
              lower: [id],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'id',
              lower: [id],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'id',
              lower: [],
              upper: [id],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterWhereClause> villageIdEqualTo(
      String villageId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'villageId',
        value: [villageId],
      ));
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterWhereClause> villageIdNotEqualTo(
      String villageId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'villageId',
              lower: [],
              upper: [villageId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'villageId',
              lower: [villageId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'villageId',
              lower: [villageId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'villageId',
              lower: [],
              upper: [villageId],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterWhereClause> syncStatusEqualTo(
      SyncStatus syncStatus) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'syncStatus',
        value: [syncStatus],
      ));
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterWhereClause> syncStatusNotEqualTo(
      SyncStatus syncStatus) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'syncStatus',
              lower: [],
              upper: [syncStatus],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'syncStatus',
              lower: [syncStatus],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'syncStatus',
              lower: [syncStatus],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'syncStatus',
              lower: [],
              upper: [syncStatus],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterWhereClause> syncStatusGreaterThan(
    SyncStatus syncStatus, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'syncStatus',
        lower: [syncStatus],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterWhereClause> syncStatusLessThan(
    SyncStatus syncStatus, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'syncStatus',
        lower: [],
        upper: [syncStatus],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterWhereClause> syncStatusBetween(
    SyncStatus lowerSyncStatus,
    SyncStatus upperSyncStatus, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'syncStatus',
        lower: [lowerSyncStatus],
        includeLower: includeLower,
        upper: [upperSyncStatus],
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterWhereClause> submittedByEqualTo(
      String submittedBy) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'submittedBy',
        value: [submittedBy],
      ));
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterWhereClause> submittedByNotEqualTo(
      String submittedBy) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'submittedBy',
              lower: [],
              upper: [submittedBy],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'submittedBy',
              lower: [submittedBy],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'submittedBy',
              lower: [submittedBy],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'submittedBy',
              lower: [],
              upper: [submittedBy],
              includeUpper: false,
            ));
      }
    });
  }
}

extension IssueModelQueryFilter
    on QueryBuilder<IssueModel, IssueModel, QFilterCondition> {
  QueryBuilder<IssueModel, IssueModel, QAfterFilterCondition>
      actionTakenEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'actionTaken',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterFilterCondition>
      actionTakenGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'actionTaken',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterFilterCondition>
      actionTakenLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'actionTaken',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterFilterCondition>
      actionTakenBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'actionTaken',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterFilterCondition>
      actionTakenStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'actionTaken',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterFilterCondition>
      actionTakenEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'actionTaken',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterFilterCondition>
      actionTakenContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'actionTaken',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterFilterCondition>
      actionTakenMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'actionTaken',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterFilterCondition>
      actionTakenIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'actionTaken',
        value: '',
      ));
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterFilterCondition>
      actionTakenIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'actionTaken',
        value: '',
      ));
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterFilterCondition>
      adminReviewNoteIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'adminReviewNote',
      ));
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterFilterCondition>
      adminReviewNoteIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'adminReviewNote',
      ));
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterFilterCondition>
      adminReviewNoteEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'adminReviewNote',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterFilterCondition>
      adminReviewNoteGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'adminReviewNote',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterFilterCondition>
      adminReviewNoteLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'adminReviewNote',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterFilterCondition>
      adminReviewNoteBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'adminReviewNote',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterFilterCondition>
      adminReviewNoteStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'adminReviewNote',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterFilterCondition>
      adminReviewNoteEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'adminReviewNote',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterFilterCondition>
      adminReviewNoteContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'adminReviewNote',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterFilterCondition>
      adminReviewNoteMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'adminReviewNote',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterFilterCondition>
      adminReviewNoteIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'adminReviewNote',
        value: '',
      ));
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterFilterCondition>
      adminReviewNoteIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'adminReviewNote',
        value: '',
      ));
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterFilterCondition>
      afterPhotoPathsElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'afterPhotoPaths',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterFilterCondition>
      afterPhotoPathsElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'afterPhotoPaths',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterFilterCondition>
      afterPhotoPathsElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'afterPhotoPaths',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterFilterCondition>
      afterPhotoPathsElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'afterPhotoPaths',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterFilterCondition>
      afterPhotoPathsElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'afterPhotoPaths',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterFilterCondition>
      afterPhotoPathsElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'afterPhotoPaths',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterFilterCondition>
      afterPhotoPathsElementContains(String value,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'afterPhotoPaths',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterFilterCondition>
      afterPhotoPathsElementMatches(String pattern,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'afterPhotoPaths',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterFilterCondition>
      afterPhotoPathsElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'afterPhotoPaths',
        value: '',
      ));
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterFilterCondition>
      afterPhotoPathsElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'afterPhotoPaths',
        value: '',
      ));
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterFilterCondition>
      afterPhotoPathsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'afterPhotoPaths',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterFilterCondition>
      afterPhotoPathsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'afterPhotoPaths',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterFilterCondition>
      afterPhotoPathsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'afterPhotoPaths',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterFilterCondition>
      afterPhotoPathsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'afterPhotoPaths',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterFilterCondition>
      afterPhotoPathsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'afterPhotoPaths',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterFilterCondition>
      afterPhotoPathsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'afterPhotoPaths',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterFilterCondition>
      beforePhotoPathsElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'beforePhotoPaths',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterFilterCondition>
      beforePhotoPathsElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'beforePhotoPaths',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterFilterCondition>
      beforePhotoPathsElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'beforePhotoPaths',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterFilterCondition>
      beforePhotoPathsElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'beforePhotoPaths',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterFilterCondition>
      beforePhotoPathsElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'beforePhotoPaths',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterFilterCondition>
      beforePhotoPathsElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'beforePhotoPaths',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterFilterCondition>
      beforePhotoPathsElementContains(String value,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'beforePhotoPaths',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterFilterCondition>
      beforePhotoPathsElementMatches(String pattern,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'beforePhotoPaths',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterFilterCondition>
      beforePhotoPathsElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'beforePhotoPaths',
        value: '',
      ));
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterFilterCondition>
      beforePhotoPathsElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'beforePhotoPaths',
        value: '',
      ));
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterFilterCondition>
      beforePhotoPathsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'beforePhotoPaths',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterFilterCondition>
      beforePhotoPathsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'beforePhotoPaths',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterFilterCondition>
      beforePhotoPathsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'beforePhotoPaths',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterFilterCondition>
      beforePhotoPathsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'beforePhotoPaths',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterFilterCondition>
      beforePhotoPathsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'beforePhotoPaths',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterFilterCondition>
      beforePhotoPathsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'beforePhotoPaths',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterFilterCondition> categoryEqualTo(
      IssueCategory value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'category',
        value: value,
      ));
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterFilterCondition>
      categoryGreaterThan(
    IssueCategory value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'category',
        value: value,
      ));
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterFilterCondition> categoryLessThan(
    IssueCategory value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'category',
        value: value,
      ));
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterFilterCondition> categoryBetween(
    IssueCategory lower,
    IssueCategory upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'category',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterFilterCondition>
      documentPathsElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'documentPaths',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterFilterCondition>
      documentPathsElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'documentPaths',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterFilterCondition>
      documentPathsElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'documentPaths',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterFilterCondition>
      documentPathsElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'documentPaths',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterFilterCondition>
      documentPathsElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'documentPaths',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterFilterCondition>
      documentPathsElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'documentPaths',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterFilterCondition>
      documentPathsElementContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'documentPaths',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterFilterCondition>
      documentPathsElementMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'documentPaths',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterFilterCondition>
      documentPathsElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'documentPaths',
        value: '',
      ));
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterFilterCondition>
      documentPathsElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'documentPaths',
        value: '',
      ));
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterFilterCondition>
      documentPathsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'documentPaths',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterFilterCondition>
      documentPathsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'documentPaths',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterFilterCondition>
      documentPathsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'documentPaths',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterFilterCondition>
      documentPathsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'documentPaths',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterFilterCondition>
      documentPathsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'documentPaths',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterFilterCondition>
      documentPathsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'documentPaths',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterFilterCondition>
      expenditureDetailsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'expenditureDetails',
      ));
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterFilterCondition>
      expenditureDetailsIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'expenditureDetails',
      ));
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterFilterCondition>
      expenditureDetailsEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'expenditureDetails',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterFilterCondition>
      expenditureDetailsGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'expenditureDetails',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterFilterCondition>
      expenditureDetailsLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'expenditureDetails',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterFilterCondition>
      expenditureDetailsBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'expenditureDetails',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterFilterCondition>
      expenditureDetailsStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'expenditureDetails',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterFilterCondition>
      expenditureDetailsEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'expenditureDetails',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterFilterCondition>
      expenditureDetailsContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'expenditureDetails',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterFilterCondition>
      expenditureDetailsMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'expenditureDetails',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterFilterCondition>
      expenditureDetailsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'expenditureDetails',
        value: '',
      ));
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterFilterCondition>
      expenditureDetailsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'expenditureDetails',
        value: '',
      ));
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterFilterCondition> idEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterFilterCondition> idGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterFilterCondition> idLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterFilterCondition> idBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterFilterCondition> idStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterFilterCondition> idEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterFilterCondition> idContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterFilterCondition> idMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'id',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterFilterCondition> idIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: '',
      ));
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterFilterCondition> idIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'id',
        value: '',
      ));
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterFilterCondition> isarIdEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isarId',
        value: value,
      ));
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterFilterCondition> isarIdGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'isarId',
        value: value,
      ));
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterFilterCondition> isarIdLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'isarId',
        value: value,
      ));
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterFilterCondition> isarIdBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'isarId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterFilterCondition>
      problemDescriptionEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'problemDescription',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterFilterCondition>
      problemDescriptionGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'problemDescription',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterFilterCondition>
      problemDescriptionLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'problemDescription',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterFilterCondition>
      problemDescriptionBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'problemDescription',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterFilterCondition>
      problemDescriptionStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'problemDescription',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterFilterCondition>
      problemDescriptionEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'problemDescription',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterFilterCondition>
      problemDescriptionContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'problemDescription',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterFilterCondition>
      problemDescriptionMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'problemDescription',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterFilterCondition>
      problemDescriptionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'problemDescription',
        value: '',
      ));
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterFilterCondition>
      problemDescriptionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'problemDescription',
        value: '',
      ));
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterFilterCondition>
      reportedDateEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'reportedDate',
        value: value,
      ));
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterFilterCondition>
      reportedDateGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'reportedDate',
        value: value,
      ));
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterFilterCondition>
      reportedDateLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'reportedDate',
        value: value,
      ));
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterFilterCondition>
      reportedDateBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'reportedDate',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterFilterCondition>
      resolutionNotesIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'resolutionNotes',
      ));
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterFilterCondition>
      resolutionNotesIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'resolutionNotes',
      ));
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterFilterCondition>
      resolutionNotesEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'resolutionNotes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterFilterCondition>
      resolutionNotesGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'resolutionNotes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterFilterCondition>
      resolutionNotesLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'resolutionNotes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterFilterCondition>
      resolutionNotesBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'resolutionNotes',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterFilterCondition>
      resolutionNotesStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'resolutionNotes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterFilterCondition>
      resolutionNotesEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'resolutionNotes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterFilterCondition>
      resolutionNotesContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'resolutionNotes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterFilterCondition>
      resolutionNotesMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'resolutionNotes',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterFilterCondition>
      resolutionNotesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'resolutionNotes',
        value: '',
      ));
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterFilterCondition>
      resolutionNotesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'resolutionNotes',
        value: '',
      ));
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterFilterCondition>
      resolvedDateIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'resolvedDate',
      ));
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterFilterCondition>
      resolvedDateIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'resolvedDate',
      ));
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterFilterCondition>
      resolvedDateEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'resolvedDate',
        value: value,
      ));
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterFilterCondition>
      resolvedDateGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'resolvedDate',
        value: value,
      ));
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterFilterCondition>
      resolvedDateLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'resolvedDate',
        value: value,
      ));
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterFilterCondition>
      resolvedDateBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'resolvedDate',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterFilterCondition> statusEqualTo(
      SubmissionStatus value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'status',
        value: value,
      ));
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterFilterCondition> statusGreaterThan(
    SubmissionStatus value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'status',
        value: value,
      ));
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterFilterCondition> statusLessThan(
    SubmissionStatus value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'status',
        value: value,
      ));
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterFilterCondition> statusBetween(
    SubmissionStatus lower,
    SubmissionStatus upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'status',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterFilterCondition>
      submittedByEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'submittedBy',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterFilterCondition>
      submittedByGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'submittedBy',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterFilterCondition>
      submittedByLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'submittedBy',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterFilterCondition>
      submittedByBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'submittedBy',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterFilterCondition>
      submittedByStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'submittedBy',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterFilterCondition>
      submittedByEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'submittedBy',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterFilterCondition>
      submittedByContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'submittedBy',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterFilterCondition>
      submittedByMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'submittedBy',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterFilterCondition>
      submittedByIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'submittedBy',
        value: '',
      ));
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterFilterCondition>
      submittedByIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'submittedBy',
        value: '',
      ));
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterFilterCondition> syncStatusEqualTo(
      SyncStatus value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'syncStatus',
        value: value,
      ));
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterFilterCondition>
      syncStatusGreaterThan(
    SyncStatus value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'syncStatus',
        value: value,
      ));
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterFilterCondition>
      syncStatusLessThan(
    SyncStatus value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'syncStatus',
        value: value,
      ));
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterFilterCondition> syncStatusBetween(
    SyncStatus lower,
    SyncStatus upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'syncStatus',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterFilterCondition>
      timelineLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'timeline',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterFilterCondition>
      timelineIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'timeline',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterFilterCondition>
      timelineIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'timeline',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterFilterCondition>
      timelineLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'timeline',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterFilterCondition>
      timelineLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'timeline',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterFilterCondition>
      timelineLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'timeline',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterFilterCondition> titleEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterFilterCondition> titleGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterFilterCondition> titleLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterFilterCondition> titleBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'title',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterFilterCondition> titleStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterFilterCondition> titleEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterFilterCondition> titleContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterFilterCondition> titleMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'title',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterFilterCondition> titleIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'title',
        value: '',
      ));
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterFilterCondition>
      titleIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'title',
        value: '',
      ));
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterFilterCondition> villageIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'villageId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterFilterCondition>
      villageIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'villageId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterFilterCondition> villageIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'villageId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterFilterCondition> villageIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'villageId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterFilterCondition>
      villageIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'villageId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterFilterCondition> villageIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'villageId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterFilterCondition> villageIdContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'villageId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterFilterCondition> villageIdMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'villageId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterFilterCondition>
      villageIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'villageId',
        value: '',
      ));
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterFilterCondition>
      villageIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'villageId',
        value: '',
      ));
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterFilterCondition>
      villageNameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'villageName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterFilterCondition>
      villageNameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'villageName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterFilterCondition>
      villageNameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'villageName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterFilterCondition>
      villageNameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'villageName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterFilterCondition>
      villageNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'villageName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterFilterCondition>
      villageNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'villageName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterFilterCondition>
      villageNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'villageName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterFilterCondition>
      villageNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'villageName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterFilterCondition>
      villageNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'villageName',
        value: '',
      ));
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterFilterCondition>
      villageNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'villageName',
        value: '',
      ));
    });
  }
}

extension IssueModelQueryObject
    on QueryBuilder<IssueModel, IssueModel, QFilterCondition> {
  QueryBuilder<IssueModel, IssueModel, QAfterFilterCondition> timelineElement(
      FilterQuery<IssueTimelineEntryModel> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'timeline');
    });
  }
}

extension IssueModelQueryLinks
    on QueryBuilder<IssueModel, IssueModel, QFilterCondition> {}

extension IssueModelQuerySortBy
    on QueryBuilder<IssueModel, IssueModel, QSortBy> {
  QueryBuilder<IssueModel, IssueModel, QAfterSortBy> sortByActionTaken() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'actionTaken', Sort.asc);
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterSortBy> sortByActionTakenDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'actionTaken', Sort.desc);
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterSortBy> sortByAdminReviewNote() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'adminReviewNote', Sort.asc);
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterSortBy>
      sortByAdminReviewNoteDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'adminReviewNote', Sort.desc);
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterSortBy> sortByCategory() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'category', Sort.asc);
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterSortBy> sortByCategoryDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'category', Sort.desc);
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterSortBy>
      sortByExpenditureDetails() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'expenditureDetails', Sort.asc);
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterSortBy>
      sortByExpenditureDetailsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'expenditureDetails', Sort.desc);
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterSortBy> sortById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterSortBy> sortByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterSortBy>
      sortByProblemDescription() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'problemDescription', Sort.asc);
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterSortBy>
      sortByProblemDescriptionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'problemDescription', Sort.desc);
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterSortBy> sortByReportedDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'reportedDate', Sort.asc);
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterSortBy> sortByReportedDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'reportedDate', Sort.desc);
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterSortBy> sortByResolutionNotes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'resolutionNotes', Sort.asc);
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterSortBy>
      sortByResolutionNotesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'resolutionNotes', Sort.desc);
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterSortBy> sortByResolvedDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'resolvedDate', Sort.asc);
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterSortBy> sortByResolvedDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'resolvedDate', Sort.desc);
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterSortBy> sortByStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.asc);
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterSortBy> sortByStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.desc);
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterSortBy> sortBySubmittedBy() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'submittedBy', Sort.asc);
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterSortBy> sortBySubmittedByDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'submittedBy', Sort.desc);
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterSortBy> sortBySyncStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'syncStatus', Sort.asc);
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterSortBy> sortBySyncStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'syncStatus', Sort.desc);
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterSortBy> sortByTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.asc);
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterSortBy> sortByTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.desc);
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterSortBy> sortByVillageId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'villageId', Sort.asc);
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterSortBy> sortByVillageIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'villageId', Sort.desc);
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterSortBy> sortByVillageName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'villageName', Sort.asc);
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterSortBy> sortByVillageNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'villageName', Sort.desc);
    });
  }
}

extension IssueModelQuerySortThenBy
    on QueryBuilder<IssueModel, IssueModel, QSortThenBy> {
  QueryBuilder<IssueModel, IssueModel, QAfterSortBy> thenByActionTaken() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'actionTaken', Sort.asc);
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterSortBy> thenByActionTakenDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'actionTaken', Sort.desc);
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterSortBy> thenByAdminReviewNote() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'adminReviewNote', Sort.asc);
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterSortBy>
      thenByAdminReviewNoteDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'adminReviewNote', Sort.desc);
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterSortBy> thenByCategory() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'category', Sort.asc);
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterSortBy> thenByCategoryDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'category', Sort.desc);
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterSortBy>
      thenByExpenditureDetails() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'expenditureDetails', Sort.asc);
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterSortBy>
      thenByExpenditureDetailsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'expenditureDetails', Sort.desc);
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterSortBy> thenByIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.asc);
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterSortBy> thenByIsarIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.desc);
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterSortBy>
      thenByProblemDescription() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'problemDescription', Sort.asc);
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterSortBy>
      thenByProblemDescriptionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'problemDescription', Sort.desc);
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterSortBy> thenByReportedDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'reportedDate', Sort.asc);
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterSortBy> thenByReportedDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'reportedDate', Sort.desc);
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterSortBy> thenByResolutionNotes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'resolutionNotes', Sort.asc);
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterSortBy>
      thenByResolutionNotesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'resolutionNotes', Sort.desc);
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterSortBy> thenByResolvedDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'resolvedDate', Sort.asc);
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterSortBy> thenByResolvedDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'resolvedDate', Sort.desc);
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterSortBy> thenByStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.asc);
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterSortBy> thenByStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.desc);
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterSortBy> thenBySubmittedBy() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'submittedBy', Sort.asc);
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterSortBy> thenBySubmittedByDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'submittedBy', Sort.desc);
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterSortBy> thenBySyncStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'syncStatus', Sort.asc);
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterSortBy> thenBySyncStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'syncStatus', Sort.desc);
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterSortBy> thenByTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.asc);
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterSortBy> thenByTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.desc);
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterSortBy> thenByVillageId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'villageId', Sort.asc);
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterSortBy> thenByVillageIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'villageId', Sort.desc);
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterSortBy> thenByVillageName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'villageName', Sort.asc);
    });
  }

  QueryBuilder<IssueModel, IssueModel, QAfterSortBy> thenByVillageNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'villageName', Sort.desc);
    });
  }
}

extension IssueModelQueryWhereDistinct
    on QueryBuilder<IssueModel, IssueModel, QDistinct> {
  QueryBuilder<IssueModel, IssueModel, QDistinct> distinctByActionTaken(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'actionTaken', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<IssueModel, IssueModel, QDistinct> distinctByAdminReviewNote(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'adminReviewNote',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<IssueModel, IssueModel, QDistinct> distinctByAfterPhotoPaths() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'afterPhotoPaths');
    });
  }

  QueryBuilder<IssueModel, IssueModel, QDistinct> distinctByBeforePhotoPaths() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'beforePhotoPaths');
    });
  }

  QueryBuilder<IssueModel, IssueModel, QDistinct> distinctByCategory() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'category');
    });
  }

  QueryBuilder<IssueModel, IssueModel, QDistinct> distinctByDocumentPaths() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'documentPaths');
    });
  }

  QueryBuilder<IssueModel, IssueModel, QDistinct> distinctByExpenditureDetails(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'expenditureDetails',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<IssueModel, IssueModel, QDistinct> distinctById(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'id', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<IssueModel, IssueModel, QDistinct> distinctByProblemDescription(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'problemDescription',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<IssueModel, IssueModel, QDistinct> distinctByReportedDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'reportedDate');
    });
  }

  QueryBuilder<IssueModel, IssueModel, QDistinct> distinctByResolutionNotes(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'resolutionNotes',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<IssueModel, IssueModel, QDistinct> distinctByResolvedDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'resolvedDate');
    });
  }

  QueryBuilder<IssueModel, IssueModel, QDistinct> distinctByStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'status');
    });
  }

  QueryBuilder<IssueModel, IssueModel, QDistinct> distinctBySubmittedBy(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'submittedBy', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<IssueModel, IssueModel, QDistinct> distinctBySyncStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'syncStatus');
    });
  }

  QueryBuilder<IssueModel, IssueModel, QDistinct> distinctByTitle(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'title', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<IssueModel, IssueModel, QDistinct> distinctByVillageId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'villageId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<IssueModel, IssueModel, QDistinct> distinctByVillageName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'villageName', caseSensitive: caseSensitive);
    });
  }
}

extension IssueModelQueryProperty
    on QueryBuilder<IssueModel, IssueModel, QQueryProperty> {
  QueryBuilder<IssueModel, int, QQueryOperations> isarIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isarId');
    });
  }

  QueryBuilder<IssueModel, String, QQueryOperations> actionTakenProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'actionTaken');
    });
  }

  QueryBuilder<IssueModel, String?, QQueryOperations>
      adminReviewNoteProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'adminReviewNote');
    });
  }

  QueryBuilder<IssueModel, List<String>, QQueryOperations>
      afterPhotoPathsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'afterPhotoPaths');
    });
  }

  QueryBuilder<IssueModel, List<String>, QQueryOperations>
      beforePhotoPathsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'beforePhotoPaths');
    });
  }

  QueryBuilder<IssueModel, IssueCategory, QQueryOperations> categoryProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'category');
    });
  }

  QueryBuilder<IssueModel, List<String>, QQueryOperations>
      documentPathsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'documentPaths');
    });
  }

  QueryBuilder<IssueModel, String?, QQueryOperations>
      expenditureDetailsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'expenditureDetails');
    });
  }

  QueryBuilder<IssueModel, String, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<IssueModel, String, QQueryOperations>
      problemDescriptionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'problemDescription');
    });
  }

  QueryBuilder<IssueModel, DateTime, QQueryOperations> reportedDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'reportedDate');
    });
  }

  QueryBuilder<IssueModel, String?, QQueryOperations>
      resolutionNotesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'resolutionNotes');
    });
  }

  QueryBuilder<IssueModel, DateTime?, QQueryOperations> resolvedDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'resolvedDate');
    });
  }

  QueryBuilder<IssueModel, SubmissionStatus, QQueryOperations>
      statusProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'status');
    });
  }

  QueryBuilder<IssueModel, String, QQueryOperations> submittedByProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'submittedBy');
    });
  }

  QueryBuilder<IssueModel, SyncStatus, QQueryOperations> syncStatusProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'syncStatus');
    });
  }

  QueryBuilder<IssueModel, List<IssueTimelineEntryModel>, QQueryOperations>
      timelineProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'timeline');
    });
  }

  QueryBuilder<IssueModel, String, QQueryOperations> titleProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'title');
    });
  }

  QueryBuilder<IssueModel, String, QQueryOperations> villageIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'villageId');
    });
  }

  QueryBuilder<IssueModel, String, QQueryOperations> villageNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'villageName');
    });
  }
}

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const IssueTimelineEntryModelSchema = Schema(
  name: r'IssueTimelineEntryModel',
  id: -23300007122067,
  properties: {
    r'completed': PropertySchema(
      id: 0,
      name: r'completed',
      type: IsarType.bool,
    ),
    r'date': PropertySchema(
      id: 1,
      name: r'date',
      type: IsarType.dateTime,
    ),
    r'note': PropertySchema(
      id: 2,
      name: r'note',
      type: IsarType.string,
    ),
    r'status': PropertySchema(
      id: 3,
      name: r'status',
      type: IsarType.byte,
      enumMap: _IssueTimelineEntryModelstatusEnumValueMap,
    )
  },
  estimateSize: _issueTimelineEntryModelEstimateSize,
  serialize: _issueTimelineEntryModelSerialize,
  deserialize: _issueTimelineEntryModelDeserialize,
  deserializeProp: _issueTimelineEntryModelDeserializeProp,
);

int _issueTimelineEntryModelEstimateSize(
  IssueTimelineEntryModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.note.length * 3;
  return bytesCount;
}

void _issueTimelineEntryModelSerialize(
  IssueTimelineEntryModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeBool(offsets[0], object.completed);
  writer.writeDateTime(offsets[1], object.date);
  writer.writeString(offsets[2], object.note);
  writer.writeByte(offsets[3], object.status.index);
}

IssueTimelineEntryModel _issueTimelineEntryModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = IssueTimelineEntryModel();
  object.completed = reader.readBool(offsets[0]);
  object.date = reader.readDateTime(offsets[1]);
  object.note = reader.readString(offsets[2]);
  object.status = _IssueTimelineEntryModelstatusValueEnumMap[
          reader.readByteOrNull(offsets[3])] ??
      SubmissionStatus.draft;
  return object;
}

P _issueTimelineEntryModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readBool(offset)) as P;
    case 1:
      return (reader.readDateTime(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    case 3:
      return (_IssueTimelineEntryModelstatusValueEnumMap[
              reader.readByteOrNull(offset)] ??
          SubmissionStatus.draft) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _IssueTimelineEntryModelstatusEnumValueMap = {
  'draft': 0,
  'pendingSync': 1,
  'submitted': 2,
  'verified': 3,
  'revisionRequested': 4,
};
const _IssueTimelineEntryModelstatusValueEnumMap = {
  0: SubmissionStatus.draft,
  1: SubmissionStatus.pendingSync,
  2: SubmissionStatus.submitted,
  3: SubmissionStatus.verified,
  4: SubmissionStatus.revisionRequested,
};

extension IssueTimelineEntryModelQueryFilter on QueryBuilder<
    IssueTimelineEntryModel, IssueTimelineEntryModel, QFilterCondition> {
  QueryBuilder<IssueTimelineEntryModel, IssueTimelineEntryModel,
      QAfterFilterCondition> completedEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'completed',
        value: value,
      ));
    });
  }

  QueryBuilder<IssueTimelineEntryModel, IssueTimelineEntryModel,
      QAfterFilterCondition> dateEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'date',
        value: value,
      ));
    });
  }

  QueryBuilder<IssueTimelineEntryModel, IssueTimelineEntryModel,
      QAfterFilterCondition> dateGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'date',
        value: value,
      ));
    });
  }

  QueryBuilder<IssueTimelineEntryModel, IssueTimelineEntryModel,
      QAfterFilterCondition> dateLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'date',
        value: value,
      ));
    });
  }

  QueryBuilder<IssueTimelineEntryModel, IssueTimelineEntryModel,
      QAfterFilterCondition> dateBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'date',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<IssueTimelineEntryModel, IssueTimelineEntryModel,
      QAfterFilterCondition> noteEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'note',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IssueTimelineEntryModel, IssueTimelineEntryModel,
      QAfterFilterCondition> noteGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'note',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IssueTimelineEntryModel, IssueTimelineEntryModel,
      QAfterFilterCondition> noteLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'note',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IssueTimelineEntryModel, IssueTimelineEntryModel,
      QAfterFilterCondition> noteBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'note',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IssueTimelineEntryModel, IssueTimelineEntryModel,
      QAfterFilterCondition> noteStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'note',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IssueTimelineEntryModel, IssueTimelineEntryModel,
      QAfterFilterCondition> noteEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'note',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IssueTimelineEntryModel, IssueTimelineEntryModel,
          QAfterFilterCondition>
      noteContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'note',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IssueTimelineEntryModel, IssueTimelineEntryModel,
          QAfterFilterCondition>
      noteMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'note',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IssueTimelineEntryModel, IssueTimelineEntryModel,
      QAfterFilterCondition> noteIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'note',
        value: '',
      ));
    });
  }

  QueryBuilder<IssueTimelineEntryModel, IssueTimelineEntryModel,
      QAfterFilterCondition> noteIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'note',
        value: '',
      ));
    });
  }

  QueryBuilder<IssueTimelineEntryModel, IssueTimelineEntryModel,
      QAfterFilterCondition> statusEqualTo(SubmissionStatus value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'status',
        value: value,
      ));
    });
  }

  QueryBuilder<IssueTimelineEntryModel, IssueTimelineEntryModel,
      QAfterFilterCondition> statusGreaterThan(
    SubmissionStatus value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'status',
        value: value,
      ));
    });
  }

  QueryBuilder<IssueTimelineEntryModel, IssueTimelineEntryModel,
      QAfterFilterCondition> statusLessThan(
    SubmissionStatus value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'status',
        value: value,
      ));
    });
  }

  QueryBuilder<IssueTimelineEntryModel, IssueTimelineEntryModel,
      QAfterFilterCondition> statusBetween(
    SubmissionStatus lower,
    SubmissionStatus upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'status',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension IssueTimelineEntryModelQueryObject on QueryBuilder<
    IssueTimelineEntryModel, IssueTimelineEntryModel, QFilterCondition> {}
