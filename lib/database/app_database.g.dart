// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $ExerciseCategoriesTable extends ExerciseCategories
    with TableInfo<$ExerciseCategoriesTable, ExerciseCategory> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ExerciseCategoriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _slugMeta = const VerificationMeta('slug');
  @override
  late final GeneratedColumn<String> slug = GeneratedColumn<String>(
    'slug',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _iconMeta = const VerificationMeta('icon');
  @override
  late final GeneratedColumn<String> icon = GeneratedColumn<String>(
    'icon',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('fitness_center'),
  );
  static const VerificationMeta _sortOrderMeta = const VerificationMeta(
    'sortOrder',
  );
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
    'sort_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [id, slug, name, icon, sortOrder];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'exercise_categories';
  @override
  VerificationContext validateIntegrity(
    Insertable<ExerciseCategory> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('slug')) {
      context.handle(
        _slugMeta,
        slug.isAcceptableOrUnknown(data['slug']!, _slugMeta),
      );
    } else if (isInserting) {
      context.missing(_slugMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('icon')) {
      context.handle(
        _iconMeta,
        icon.isAcceptableOrUnknown(data['icon']!, _iconMeta),
      );
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ExerciseCategory map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ExerciseCategory(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      slug: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}slug'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      icon: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}icon'],
      )!,
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
    );
  }

  @override
  $ExerciseCategoriesTable createAlias(String alias) {
    return $ExerciseCategoriesTable(attachedDatabase, alias);
  }
}

class ExerciseCategory extends DataClass
    implements Insertable<ExerciseCategory> {
  final int id;
  final String slug;
  final String name;
  final String icon;
  final int sortOrder;
  const ExerciseCategory({
    required this.id,
    required this.slug,
    required this.name,
    required this.icon,
    required this.sortOrder,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['slug'] = Variable<String>(slug);
    map['name'] = Variable<String>(name);
    map['icon'] = Variable<String>(icon);
    map['sort_order'] = Variable<int>(sortOrder);
    return map;
  }

  ExerciseCategoriesCompanion toCompanion(bool nullToAbsent) {
    return ExerciseCategoriesCompanion(
      id: Value(id),
      slug: Value(slug),
      name: Value(name),
      icon: Value(icon),
      sortOrder: Value(sortOrder),
    );
  }

  factory ExerciseCategory.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ExerciseCategory(
      id: serializer.fromJson<int>(json['id']),
      slug: serializer.fromJson<String>(json['slug']),
      name: serializer.fromJson<String>(json['name']),
      icon: serializer.fromJson<String>(json['icon']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'slug': serializer.toJson<String>(slug),
      'name': serializer.toJson<String>(name),
      'icon': serializer.toJson<String>(icon),
      'sortOrder': serializer.toJson<int>(sortOrder),
    };
  }

  ExerciseCategory copyWith({
    int? id,
    String? slug,
    String? name,
    String? icon,
    int? sortOrder,
  }) => ExerciseCategory(
    id: id ?? this.id,
    slug: slug ?? this.slug,
    name: name ?? this.name,
    icon: icon ?? this.icon,
    sortOrder: sortOrder ?? this.sortOrder,
  );
  ExerciseCategory copyWithCompanion(ExerciseCategoriesCompanion data) {
    return ExerciseCategory(
      id: data.id.present ? data.id.value : this.id,
      slug: data.slug.present ? data.slug.value : this.slug,
      name: data.name.present ? data.name.value : this.name,
      icon: data.icon.present ? data.icon.value : this.icon,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ExerciseCategory(')
          ..write('id: $id, ')
          ..write('slug: $slug, ')
          ..write('name: $name, ')
          ..write('icon: $icon, ')
          ..write('sortOrder: $sortOrder')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, slug, name, icon, sortOrder);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ExerciseCategory &&
          other.id == this.id &&
          other.slug == this.slug &&
          other.name == this.name &&
          other.icon == this.icon &&
          other.sortOrder == this.sortOrder);
}

class ExerciseCategoriesCompanion extends UpdateCompanion<ExerciseCategory> {
  final Value<int> id;
  final Value<String> slug;
  final Value<String> name;
  final Value<String> icon;
  final Value<int> sortOrder;
  const ExerciseCategoriesCompanion({
    this.id = const Value.absent(),
    this.slug = const Value.absent(),
    this.name = const Value.absent(),
    this.icon = const Value.absent(),
    this.sortOrder = const Value.absent(),
  });
  ExerciseCategoriesCompanion.insert({
    this.id = const Value.absent(),
    required String slug,
    required String name,
    this.icon = const Value.absent(),
    this.sortOrder = const Value.absent(),
  }) : slug = Value(slug),
       name = Value(name);
  static Insertable<ExerciseCategory> custom({
    Expression<int>? id,
    Expression<String>? slug,
    Expression<String>? name,
    Expression<String>? icon,
    Expression<int>? sortOrder,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (slug != null) 'slug': slug,
      if (name != null) 'name': name,
      if (icon != null) 'icon': icon,
      if (sortOrder != null) 'sort_order': sortOrder,
    });
  }

  ExerciseCategoriesCompanion copyWith({
    Value<int>? id,
    Value<String>? slug,
    Value<String>? name,
    Value<String>? icon,
    Value<int>? sortOrder,
  }) {
    return ExerciseCategoriesCompanion(
      id: id ?? this.id,
      slug: slug ?? this.slug,
      name: name ?? this.name,
      icon: icon ?? this.icon,
      sortOrder: sortOrder ?? this.sortOrder,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (slug.present) {
      map['slug'] = Variable<String>(slug.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (icon.present) {
      map['icon'] = Variable<String>(icon.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ExerciseCategoriesCompanion(')
          ..write('id: $id, ')
          ..write('slug: $slug, ')
          ..write('name: $name, ')
          ..write('icon: $icon, ')
          ..write('sortOrder: $sortOrder')
          ..write(')'))
        .toString();
  }
}

class $ExercisesTable extends Exercises
    with TableInfo<$ExercisesTable, Exercise> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ExercisesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _slugMeta = const VerificationMeta('slug');
  @override
  late final GeneratedColumn<String> slug = GeneratedColumn<String>(
    'slug',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _categoryIdMeta = const VerificationMeta(
    'categoryId',
  );
  @override
  late final GeneratedColumn<int> categoryId = GeneratedColumn<int>(
    'category_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES exercise_categories (id)',
    ),
  );
  static const VerificationMeta _durationSecondsMeta = const VerificationMeta(
    'durationSeconds',
  );
  @override
  late final GeneratedColumn<int> durationSeconds = GeneratedColumn<int>(
    'duration_seconds',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _difficultyMeta = const VerificationMeta(
    'difficulty',
  );
  @override
  late final GeneratedColumn<String> difficulty = GeneratedColumn<String>(
    'difficulty',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _animationAssetMeta = const VerificationMeta(
    'animationAsset',
  );
  @override
  late final GeneratedColumn<String> animationAsset = GeneratedColumn<String>(
    'animation_asset',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _instructionsMeta = const VerificationMeta(
    'instructions',
  );
  @override
  late final GeneratedColumn<String> instructions = GeneratedColumn<String>(
    'instructions',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _benefitsMeta = const VerificationMeta(
    'benefits',
  );
  @override
  late final GeneratedColumn<String> benefits = GeneratedColumn<String>(
    'benefits',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _targetMusclesMeta = const VerificationMeta(
    'targetMuscles',
  );
  @override
  late final GeneratedColumn<String> targetMuscles = GeneratedColumn<String>(
    'target_muscles',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _caloriesEstimateMeta = const VerificationMeta(
    'caloriesEstimate',
  );
  @override
  late final GeneratedColumn<int> caloriesEstimate = GeneratedColumn<int>(
    'calories_estimate',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(5),
  );
  static const VerificationMeta _isFavoriteMeta = const VerificationMeta(
    'isFavorite',
  );
  @override
  late final GeneratedColumn<bool> isFavorite = GeneratedColumn<bool>(
    'is_favorite',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_favorite" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    slug,
    title,
    categoryId,
    durationSeconds,
    difficulty,
    animationAsset,
    description,
    instructions,
    benefits,
    targetMuscles,
    caloriesEstimate,
    isFavorite,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'exercises';
  @override
  VerificationContext validateIntegrity(
    Insertable<Exercise> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('slug')) {
      context.handle(
        _slugMeta,
        slug.isAcceptableOrUnknown(data['slug']!, _slugMeta),
      );
    } else if (isInserting) {
      context.missing(_slugMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('category_id')) {
      context.handle(
        _categoryIdMeta,
        categoryId.isAcceptableOrUnknown(data['category_id']!, _categoryIdMeta),
      );
    } else if (isInserting) {
      context.missing(_categoryIdMeta);
    }
    if (data.containsKey('duration_seconds')) {
      context.handle(
        _durationSecondsMeta,
        durationSeconds.isAcceptableOrUnknown(
          data['duration_seconds']!,
          _durationSecondsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_durationSecondsMeta);
    }
    if (data.containsKey('difficulty')) {
      context.handle(
        _difficultyMeta,
        difficulty.isAcceptableOrUnknown(data['difficulty']!, _difficultyMeta),
      );
    } else if (isInserting) {
      context.missing(_difficultyMeta);
    }
    if (data.containsKey('animation_asset')) {
      context.handle(
        _animationAssetMeta,
        animationAsset.isAcceptableOrUnknown(
          data['animation_asset']!,
          _animationAssetMeta,
        ),
      );
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('instructions')) {
      context.handle(
        _instructionsMeta,
        instructions.isAcceptableOrUnknown(
          data['instructions']!,
          _instructionsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_instructionsMeta);
    }
    if (data.containsKey('benefits')) {
      context.handle(
        _benefitsMeta,
        benefits.isAcceptableOrUnknown(data['benefits']!, _benefitsMeta),
      );
    } else if (isInserting) {
      context.missing(_benefitsMeta);
    }
    if (data.containsKey('target_muscles')) {
      context.handle(
        _targetMusclesMeta,
        targetMuscles.isAcceptableOrUnknown(
          data['target_muscles']!,
          _targetMusclesMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_targetMusclesMeta);
    }
    if (data.containsKey('calories_estimate')) {
      context.handle(
        _caloriesEstimateMeta,
        caloriesEstimate.isAcceptableOrUnknown(
          data['calories_estimate']!,
          _caloriesEstimateMeta,
        ),
      );
    }
    if (data.containsKey('is_favorite')) {
      context.handle(
        _isFavoriteMeta,
        isFavorite.isAcceptableOrUnknown(data['is_favorite']!, _isFavoriteMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Exercise map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Exercise(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      slug: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}slug'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      categoryId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}category_id'],
      )!,
      durationSeconds: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}duration_seconds'],
      )!,
      difficulty: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}difficulty'],
      )!,
      animationAsset: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}animation_asset'],
      ),
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      )!,
      instructions: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}instructions'],
      )!,
      benefits: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}benefits'],
      )!,
      targetMuscles: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}target_muscles'],
      )!,
      caloriesEstimate: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}calories_estimate'],
      )!,
      isFavorite: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_favorite'],
      )!,
    );
  }

  @override
  $ExercisesTable createAlias(String alias) {
    return $ExercisesTable(attachedDatabase, alias);
  }
}

class Exercise extends DataClass implements Insertable<Exercise> {
  final int id;
  final String slug;
  final String title;
  final int categoryId;
  final int durationSeconds;
  final String difficulty;
  final String? animationAsset;
  final String description;
  final String instructions;
  final String benefits;
  final String targetMuscles;
  final int caloriesEstimate;
  final bool isFavorite;
  const Exercise({
    required this.id,
    required this.slug,
    required this.title,
    required this.categoryId,
    required this.durationSeconds,
    required this.difficulty,
    this.animationAsset,
    required this.description,
    required this.instructions,
    required this.benefits,
    required this.targetMuscles,
    required this.caloriesEstimate,
    required this.isFavorite,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['slug'] = Variable<String>(slug);
    map['title'] = Variable<String>(title);
    map['category_id'] = Variable<int>(categoryId);
    map['duration_seconds'] = Variable<int>(durationSeconds);
    map['difficulty'] = Variable<String>(difficulty);
    if (!nullToAbsent || animationAsset != null) {
      map['animation_asset'] = Variable<String>(animationAsset);
    }
    map['description'] = Variable<String>(description);
    map['instructions'] = Variable<String>(instructions);
    map['benefits'] = Variable<String>(benefits);
    map['target_muscles'] = Variable<String>(targetMuscles);
    map['calories_estimate'] = Variable<int>(caloriesEstimate);
    map['is_favorite'] = Variable<bool>(isFavorite);
    return map;
  }

  ExercisesCompanion toCompanion(bool nullToAbsent) {
    return ExercisesCompanion(
      id: Value(id),
      slug: Value(slug),
      title: Value(title),
      categoryId: Value(categoryId),
      durationSeconds: Value(durationSeconds),
      difficulty: Value(difficulty),
      animationAsset: animationAsset == null && nullToAbsent
          ? const Value.absent()
          : Value(animationAsset),
      description: Value(description),
      instructions: Value(instructions),
      benefits: Value(benefits),
      targetMuscles: Value(targetMuscles),
      caloriesEstimate: Value(caloriesEstimate),
      isFavorite: Value(isFavorite),
    );
  }

  factory Exercise.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Exercise(
      id: serializer.fromJson<int>(json['id']),
      slug: serializer.fromJson<String>(json['slug']),
      title: serializer.fromJson<String>(json['title']),
      categoryId: serializer.fromJson<int>(json['categoryId']),
      durationSeconds: serializer.fromJson<int>(json['durationSeconds']),
      difficulty: serializer.fromJson<String>(json['difficulty']),
      animationAsset: serializer.fromJson<String?>(json['animationAsset']),
      description: serializer.fromJson<String>(json['description']),
      instructions: serializer.fromJson<String>(json['instructions']),
      benefits: serializer.fromJson<String>(json['benefits']),
      targetMuscles: serializer.fromJson<String>(json['targetMuscles']),
      caloriesEstimate: serializer.fromJson<int>(json['caloriesEstimate']),
      isFavorite: serializer.fromJson<bool>(json['isFavorite']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'slug': serializer.toJson<String>(slug),
      'title': serializer.toJson<String>(title),
      'categoryId': serializer.toJson<int>(categoryId),
      'durationSeconds': serializer.toJson<int>(durationSeconds),
      'difficulty': serializer.toJson<String>(difficulty),
      'animationAsset': serializer.toJson<String?>(animationAsset),
      'description': serializer.toJson<String>(description),
      'instructions': serializer.toJson<String>(instructions),
      'benefits': serializer.toJson<String>(benefits),
      'targetMuscles': serializer.toJson<String>(targetMuscles),
      'caloriesEstimate': serializer.toJson<int>(caloriesEstimate),
      'isFavorite': serializer.toJson<bool>(isFavorite),
    };
  }

  Exercise copyWith({
    int? id,
    String? slug,
    String? title,
    int? categoryId,
    int? durationSeconds,
    String? difficulty,
    Value<String?> animationAsset = const Value.absent(),
    String? description,
    String? instructions,
    String? benefits,
    String? targetMuscles,
    int? caloriesEstimate,
    bool? isFavorite,
  }) => Exercise(
    id: id ?? this.id,
    slug: slug ?? this.slug,
    title: title ?? this.title,
    categoryId: categoryId ?? this.categoryId,
    durationSeconds: durationSeconds ?? this.durationSeconds,
    difficulty: difficulty ?? this.difficulty,
    animationAsset: animationAsset.present
        ? animationAsset.value
        : this.animationAsset,
    description: description ?? this.description,
    instructions: instructions ?? this.instructions,
    benefits: benefits ?? this.benefits,
    targetMuscles: targetMuscles ?? this.targetMuscles,
    caloriesEstimate: caloriesEstimate ?? this.caloriesEstimate,
    isFavorite: isFavorite ?? this.isFavorite,
  );
  Exercise copyWithCompanion(ExercisesCompanion data) {
    return Exercise(
      id: data.id.present ? data.id.value : this.id,
      slug: data.slug.present ? data.slug.value : this.slug,
      title: data.title.present ? data.title.value : this.title,
      categoryId: data.categoryId.present
          ? data.categoryId.value
          : this.categoryId,
      durationSeconds: data.durationSeconds.present
          ? data.durationSeconds.value
          : this.durationSeconds,
      difficulty: data.difficulty.present
          ? data.difficulty.value
          : this.difficulty,
      animationAsset: data.animationAsset.present
          ? data.animationAsset.value
          : this.animationAsset,
      description: data.description.present
          ? data.description.value
          : this.description,
      instructions: data.instructions.present
          ? data.instructions.value
          : this.instructions,
      benefits: data.benefits.present ? data.benefits.value : this.benefits,
      targetMuscles: data.targetMuscles.present
          ? data.targetMuscles.value
          : this.targetMuscles,
      caloriesEstimate: data.caloriesEstimate.present
          ? data.caloriesEstimate.value
          : this.caloriesEstimate,
      isFavorite: data.isFavorite.present
          ? data.isFavorite.value
          : this.isFavorite,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Exercise(')
          ..write('id: $id, ')
          ..write('slug: $slug, ')
          ..write('title: $title, ')
          ..write('categoryId: $categoryId, ')
          ..write('durationSeconds: $durationSeconds, ')
          ..write('difficulty: $difficulty, ')
          ..write('animationAsset: $animationAsset, ')
          ..write('description: $description, ')
          ..write('instructions: $instructions, ')
          ..write('benefits: $benefits, ')
          ..write('targetMuscles: $targetMuscles, ')
          ..write('caloriesEstimate: $caloriesEstimate, ')
          ..write('isFavorite: $isFavorite')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    slug,
    title,
    categoryId,
    durationSeconds,
    difficulty,
    animationAsset,
    description,
    instructions,
    benefits,
    targetMuscles,
    caloriesEstimate,
    isFavorite,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Exercise &&
          other.id == this.id &&
          other.slug == this.slug &&
          other.title == this.title &&
          other.categoryId == this.categoryId &&
          other.durationSeconds == this.durationSeconds &&
          other.difficulty == this.difficulty &&
          other.animationAsset == this.animationAsset &&
          other.description == this.description &&
          other.instructions == this.instructions &&
          other.benefits == this.benefits &&
          other.targetMuscles == this.targetMuscles &&
          other.caloriesEstimate == this.caloriesEstimate &&
          other.isFavorite == this.isFavorite);
}

class ExercisesCompanion extends UpdateCompanion<Exercise> {
  final Value<int> id;
  final Value<String> slug;
  final Value<String> title;
  final Value<int> categoryId;
  final Value<int> durationSeconds;
  final Value<String> difficulty;
  final Value<String?> animationAsset;
  final Value<String> description;
  final Value<String> instructions;
  final Value<String> benefits;
  final Value<String> targetMuscles;
  final Value<int> caloriesEstimate;
  final Value<bool> isFavorite;
  const ExercisesCompanion({
    this.id = const Value.absent(),
    this.slug = const Value.absent(),
    this.title = const Value.absent(),
    this.categoryId = const Value.absent(),
    this.durationSeconds = const Value.absent(),
    this.difficulty = const Value.absent(),
    this.animationAsset = const Value.absent(),
    this.description = const Value.absent(),
    this.instructions = const Value.absent(),
    this.benefits = const Value.absent(),
    this.targetMuscles = const Value.absent(),
    this.caloriesEstimate = const Value.absent(),
    this.isFavorite = const Value.absent(),
  });
  ExercisesCompanion.insert({
    this.id = const Value.absent(),
    required String slug,
    required String title,
    required int categoryId,
    required int durationSeconds,
    required String difficulty,
    this.animationAsset = const Value.absent(),
    required String description,
    required String instructions,
    required String benefits,
    required String targetMuscles,
    this.caloriesEstimate = const Value.absent(),
    this.isFavorite = const Value.absent(),
  }) : slug = Value(slug),
       title = Value(title),
       categoryId = Value(categoryId),
       durationSeconds = Value(durationSeconds),
       difficulty = Value(difficulty),
       description = Value(description),
       instructions = Value(instructions),
       benefits = Value(benefits),
       targetMuscles = Value(targetMuscles);
  static Insertable<Exercise> custom({
    Expression<int>? id,
    Expression<String>? slug,
    Expression<String>? title,
    Expression<int>? categoryId,
    Expression<int>? durationSeconds,
    Expression<String>? difficulty,
    Expression<String>? animationAsset,
    Expression<String>? description,
    Expression<String>? instructions,
    Expression<String>? benefits,
    Expression<String>? targetMuscles,
    Expression<int>? caloriesEstimate,
    Expression<bool>? isFavorite,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (slug != null) 'slug': slug,
      if (title != null) 'title': title,
      if (categoryId != null) 'category_id': categoryId,
      if (durationSeconds != null) 'duration_seconds': durationSeconds,
      if (difficulty != null) 'difficulty': difficulty,
      if (animationAsset != null) 'animation_asset': animationAsset,
      if (description != null) 'description': description,
      if (instructions != null) 'instructions': instructions,
      if (benefits != null) 'benefits': benefits,
      if (targetMuscles != null) 'target_muscles': targetMuscles,
      if (caloriesEstimate != null) 'calories_estimate': caloriesEstimate,
      if (isFavorite != null) 'is_favorite': isFavorite,
    });
  }

  ExercisesCompanion copyWith({
    Value<int>? id,
    Value<String>? slug,
    Value<String>? title,
    Value<int>? categoryId,
    Value<int>? durationSeconds,
    Value<String>? difficulty,
    Value<String?>? animationAsset,
    Value<String>? description,
    Value<String>? instructions,
    Value<String>? benefits,
    Value<String>? targetMuscles,
    Value<int>? caloriesEstimate,
    Value<bool>? isFavorite,
  }) {
    return ExercisesCompanion(
      id: id ?? this.id,
      slug: slug ?? this.slug,
      title: title ?? this.title,
      categoryId: categoryId ?? this.categoryId,
      durationSeconds: durationSeconds ?? this.durationSeconds,
      difficulty: difficulty ?? this.difficulty,
      animationAsset: animationAsset ?? this.animationAsset,
      description: description ?? this.description,
      instructions: instructions ?? this.instructions,
      benefits: benefits ?? this.benefits,
      targetMuscles: targetMuscles ?? this.targetMuscles,
      caloriesEstimate: caloriesEstimate ?? this.caloriesEstimate,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (slug.present) {
      map['slug'] = Variable<String>(slug.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (categoryId.present) {
      map['category_id'] = Variable<int>(categoryId.value);
    }
    if (durationSeconds.present) {
      map['duration_seconds'] = Variable<int>(durationSeconds.value);
    }
    if (difficulty.present) {
      map['difficulty'] = Variable<String>(difficulty.value);
    }
    if (animationAsset.present) {
      map['animation_asset'] = Variable<String>(animationAsset.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (instructions.present) {
      map['instructions'] = Variable<String>(instructions.value);
    }
    if (benefits.present) {
      map['benefits'] = Variable<String>(benefits.value);
    }
    if (targetMuscles.present) {
      map['target_muscles'] = Variable<String>(targetMuscles.value);
    }
    if (caloriesEstimate.present) {
      map['calories_estimate'] = Variable<int>(caloriesEstimate.value);
    }
    if (isFavorite.present) {
      map['is_favorite'] = Variable<bool>(isFavorite.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ExercisesCompanion(')
          ..write('id: $id, ')
          ..write('slug: $slug, ')
          ..write('title: $title, ')
          ..write('categoryId: $categoryId, ')
          ..write('durationSeconds: $durationSeconds, ')
          ..write('difficulty: $difficulty, ')
          ..write('animationAsset: $animationAsset, ')
          ..write('description: $description, ')
          ..write('instructions: $instructions, ')
          ..write('benefits: $benefits, ')
          ..write('targetMuscles: $targetMuscles, ')
          ..write('caloriesEstimate: $caloriesEstimate, ')
          ..write('isFavorite: $isFavorite')
          ..write(')'))
        .toString();
  }
}

class $ExerciseHistoriesTable extends ExerciseHistories
    with TableInfo<$ExerciseHistoriesTable, ExerciseHistory> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ExerciseHistoriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _exerciseIdMeta = const VerificationMeta(
    'exerciseId',
  );
  @override
  late final GeneratedColumn<int> exerciseId = GeneratedColumn<int>(
    'exercise_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES exercises (id)',
    ),
  );
  static const VerificationMeta _completedAtMeta = const VerificationMeta(
    'completedAt',
  );
  @override
  late final GeneratedColumn<DateTime> completedAt = GeneratedColumn<DateTime>(
    'completed_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _durationSecondsMeta = const VerificationMeta(
    'durationSeconds',
  );
  @override
  late final GeneratedColumn<int> durationSeconds = GeneratedColumn<int>(
    'duration_seconds',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    exerciseId,
    completedAt,
    durationSeconds,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'exercise_histories';
  @override
  VerificationContext validateIntegrity(
    Insertable<ExerciseHistory> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('exercise_id')) {
      context.handle(
        _exerciseIdMeta,
        exerciseId.isAcceptableOrUnknown(data['exercise_id']!, _exerciseIdMeta),
      );
    } else if (isInserting) {
      context.missing(_exerciseIdMeta);
    }
    if (data.containsKey('completed_at')) {
      context.handle(
        _completedAtMeta,
        completedAt.isAcceptableOrUnknown(
          data['completed_at']!,
          _completedAtMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_completedAtMeta);
    }
    if (data.containsKey('duration_seconds')) {
      context.handle(
        _durationSecondsMeta,
        durationSeconds.isAcceptableOrUnknown(
          data['duration_seconds']!,
          _durationSecondsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_durationSecondsMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ExerciseHistory map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ExerciseHistory(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      exerciseId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}exercise_id'],
      )!,
      completedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}completed_at'],
      )!,
      durationSeconds: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}duration_seconds'],
      )!,
    );
  }

  @override
  $ExerciseHistoriesTable createAlias(String alias) {
    return $ExerciseHistoriesTable(attachedDatabase, alias);
  }
}

class ExerciseHistory extends DataClass implements Insertable<ExerciseHistory> {
  final int id;
  final int exerciseId;
  final DateTime completedAt;
  final int durationSeconds;
  const ExerciseHistory({
    required this.id,
    required this.exerciseId,
    required this.completedAt,
    required this.durationSeconds,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['exercise_id'] = Variable<int>(exerciseId);
    map['completed_at'] = Variable<DateTime>(completedAt);
    map['duration_seconds'] = Variable<int>(durationSeconds);
    return map;
  }

  ExerciseHistoriesCompanion toCompanion(bool nullToAbsent) {
    return ExerciseHistoriesCompanion(
      id: Value(id),
      exerciseId: Value(exerciseId),
      completedAt: Value(completedAt),
      durationSeconds: Value(durationSeconds),
    );
  }

  factory ExerciseHistory.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ExerciseHistory(
      id: serializer.fromJson<int>(json['id']),
      exerciseId: serializer.fromJson<int>(json['exerciseId']),
      completedAt: serializer.fromJson<DateTime>(json['completedAt']),
      durationSeconds: serializer.fromJson<int>(json['durationSeconds']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'exerciseId': serializer.toJson<int>(exerciseId),
      'completedAt': serializer.toJson<DateTime>(completedAt),
      'durationSeconds': serializer.toJson<int>(durationSeconds),
    };
  }

  ExerciseHistory copyWith({
    int? id,
    int? exerciseId,
    DateTime? completedAt,
    int? durationSeconds,
  }) => ExerciseHistory(
    id: id ?? this.id,
    exerciseId: exerciseId ?? this.exerciseId,
    completedAt: completedAt ?? this.completedAt,
    durationSeconds: durationSeconds ?? this.durationSeconds,
  );
  ExerciseHistory copyWithCompanion(ExerciseHistoriesCompanion data) {
    return ExerciseHistory(
      id: data.id.present ? data.id.value : this.id,
      exerciseId: data.exerciseId.present
          ? data.exerciseId.value
          : this.exerciseId,
      completedAt: data.completedAt.present
          ? data.completedAt.value
          : this.completedAt,
      durationSeconds: data.durationSeconds.present
          ? data.durationSeconds.value
          : this.durationSeconds,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ExerciseHistory(')
          ..write('id: $id, ')
          ..write('exerciseId: $exerciseId, ')
          ..write('completedAt: $completedAt, ')
          ..write('durationSeconds: $durationSeconds')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, exerciseId, completedAt, durationSeconds);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ExerciseHistory &&
          other.id == this.id &&
          other.exerciseId == this.exerciseId &&
          other.completedAt == this.completedAt &&
          other.durationSeconds == this.durationSeconds);
}

class ExerciseHistoriesCompanion extends UpdateCompanion<ExerciseHistory> {
  final Value<int> id;
  final Value<int> exerciseId;
  final Value<DateTime> completedAt;
  final Value<int> durationSeconds;
  const ExerciseHistoriesCompanion({
    this.id = const Value.absent(),
    this.exerciseId = const Value.absent(),
    this.completedAt = const Value.absent(),
    this.durationSeconds = const Value.absent(),
  });
  ExerciseHistoriesCompanion.insert({
    this.id = const Value.absent(),
    required int exerciseId,
    required DateTime completedAt,
    required int durationSeconds,
  }) : exerciseId = Value(exerciseId),
       completedAt = Value(completedAt),
       durationSeconds = Value(durationSeconds);
  static Insertable<ExerciseHistory> custom({
    Expression<int>? id,
    Expression<int>? exerciseId,
    Expression<DateTime>? completedAt,
    Expression<int>? durationSeconds,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (exerciseId != null) 'exercise_id': exerciseId,
      if (completedAt != null) 'completed_at': completedAt,
      if (durationSeconds != null) 'duration_seconds': durationSeconds,
    });
  }

  ExerciseHistoriesCompanion copyWith({
    Value<int>? id,
    Value<int>? exerciseId,
    Value<DateTime>? completedAt,
    Value<int>? durationSeconds,
  }) {
    return ExerciseHistoriesCompanion(
      id: id ?? this.id,
      exerciseId: exerciseId ?? this.exerciseId,
      completedAt: completedAt ?? this.completedAt,
      durationSeconds: durationSeconds ?? this.durationSeconds,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (exerciseId.present) {
      map['exercise_id'] = Variable<int>(exerciseId.value);
    }
    if (completedAt.present) {
      map['completed_at'] = Variable<DateTime>(completedAt.value);
    }
    if (durationSeconds.present) {
      map['duration_seconds'] = Variable<int>(durationSeconds.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ExerciseHistoriesCompanion(')
          ..write('id: $id, ')
          ..write('exerciseId: $exerciseId, ')
          ..write('completedAt: $completedAt, ')
          ..write('durationSeconds: $durationSeconds')
          ..write(')'))
        .toString();
  }
}

class $AffirmationsTable extends Affirmations
    with TableInfo<$AffirmationsTable, Affirmation> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AffirmationsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _contentMeta = const VerificationMeta(
    'content',
  );
  @override
  late final GeneratedColumn<String> content = GeneratedColumn<String>(
    'content',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _categoryMeta = const VerificationMeta(
    'category',
  );
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
    'category',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isFavoriteMeta = const VerificationMeta(
    'isFavorite',
  );
  @override
  late final GeneratedColumn<bool> isFavorite = GeneratedColumn<bool>(
    'is_favorite',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_favorite" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _isCustomMeta = const VerificationMeta(
    'isCustom',
  );
  @override
  late final GeneratedColumn<bool> isCustom = GeneratedColumn<bool>(
    'is_custom',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_custom" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    content,
    category,
    isFavorite,
    isCustom,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'affirmations';
  @override
  VerificationContext validateIntegrity(
    Insertable<Affirmation> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('content')) {
      context.handle(
        _contentMeta,
        content.isAcceptableOrUnknown(data['content']!, _contentMeta),
      );
    } else if (isInserting) {
      context.missing(_contentMeta);
    }
    if (data.containsKey('category')) {
      context.handle(
        _categoryMeta,
        category.isAcceptableOrUnknown(data['category']!, _categoryMeta),
      );
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    if (data.containsKey('is_favorite')) {
      context.handle(
        _isFavoriteMeta,
        isFavorite.isAcceptableOrUnknown(data['is_favorite']!, _isFavoriteMeta),
      );
    }
    if (data.containsKey('is_custom')) {
      context.handle(
        _isCustomMeta,
        isCustom.isAcceptableOrUnknown(data['is_custom']!, _isCustomMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Affirmation map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Affirmation(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      content: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}content'],
      )!,
      category: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category'],
      )!,
      isFavorite: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_favorite'],
      )!,
      isCustom: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_custom'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $AffirmationsTable createAlias(String alias) {
    return $AffirmationsTable(attachedDatabase, alias);
  }
}

class Affirmation extends DataClass implements Insertable<Affirmation> {
  final int id;
  final String content;
  final String category;
  final bool isFavorite;
  final bool isCustom;
  final DateTime createdAt;
  const Affirmation({
    required this.id,
    required this.content,
    required this.category,
    required this.isFavorite,
    required this.isCustom,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['content'] = Variable<String>(content);
    map['category'] = Variable<String>(category);
    map['is_favorite'] = Variable<bool>(isFavorite);
    map['is_custom'] = Variable<bool>(isCustom);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  AffirmationsCompanion toCompanion(bool nullToAbsent) {
    return AffirmationsCompanion(
      id: Value(id),
      content: Value(content),
      category: Value(category),
      isFavorite: Value(isFavorite),
      isCustom: Value(isCustom),
      createdAt: Value(createdAt),
    );
  }

  factory Affirmation.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Affirmation(
      id: serializer.fromJson<int>(json['id']),
      content: serializer.fromJson<String>(json['content']),
      category: serializer.fromJson<String>(json['category']),
      isFavorite: serializer.fromJson<bool>(json['isFavorite']),
      isCustom: serializer.fromJson<bool>(json['isCustom']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'content': serializer.toJson<String>(content),
      'category': serializer.toJson<String>(category),
      'isFavorite': serializer.toJson<bool>(isFavorite),
      'isCustom': serializer.toJson<bool>(isCustom),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Affirmation copyWith({
    int? id,
    String? content,
    String? category,
    bool? isFavorite,
    bool? isCustom,
    DateTime? createdAt,
  }) => Affirmation(
    id: id ?? this.id,
    content: content ?? this.content,
    category: category ?? this.category,
    isFavorite: isFavorite ?? this.isFavorite,
    isCustom: isCustom ?? this.isCustom,
    createdAt: createdAt ?? this.createdAt,
  );
  Affirmation copyWithCompanion(AffirmationsCompanion data) {
    return Affirmation(
      id: data.id.present ? data.id.value : this.id,
      content: data.content.present ? data.content.value : this.content,
      category: data.category.present ? data.category.value : this.category,
      isFavorite: data.isFavorite.present
          ? data.isFavorite.value
          : this.isFavorite,
      isCustom: data.isCustom.present ? data.isCustom.value : this.isCustom,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Affirmation(')
          ..write('id: $id, ')
          ..write('content: $content, ')
          ..write('category: $category, ')
          ..write('isFavorite: $isFavorite, ')
          ..write('isCustom: $isCustom, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, content, category, isFavorite, isCustom, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Affirmation &&
          other.id == this.id &&
          other.content == this.content &&
          other.category == this.category &&
          other.isFavorite == this.isFavorite &&
          other.isCustom == this.isCustom &&
          other.createdAt == this.createdAt);
}

class AffirmationsCompanion extends UpdateCompanion<Affirmation> {
  final Value<int> id;
  final Value<String> content;
  final Value<String> category;
  final Value<bool> isFavorite;
  final Value<bool> isCustom;
  final Value<DateTime> createdAt;
  const AffirmationsCompanion({
    this.id = const Value.absent(),
    this.content = const Value.absent(),
    this.category = const Value.absent(),
    this.isFavorite = const Value.absent(),
    this.isCustom = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  AffirmationsCompanion.insert({
    this.id = const Value.absent(),
    required String content,
    required String category,
    this.isFavorite = const Value.absent(),
    this.isCustom = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : content = Value(content),
       category = Value(category);
  static Insertable<Affirmation> custom({
    Expression<int>? id,
    Expression<String>? content,
    Expression<String>? category,
    Expression<bool>? isFavorite,
    Expression<bool>? isCustom,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (content != null) 'content': content,
      if (category != null) 'category': category,
      if (isFavorite != null) 'is_favorite': isFavorite,
      if (isCustom != null) 'is_custom': isCustom,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  AffirmationsCompanion copyWith({
    Value<int>? id,
    Value<String>? content,
    Value<String>? category,
    Value<bool>? isFavorite,
    Value<bool>? isCustom,
    Value<DateTime>? createdAt,
  }) {
    return AffirmationsCompanion(
      id: id ?? this.id,
      content: content ?? this.content,
      category: category ?? this.category,
      isFavorite: isFavorite ?? this.isFavorite,
      isCustom: isCustom ?? this.isCustom,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (content.present) {
      map['content'] = Variable<String>(content.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (isFavorite.present) {
      map['is_favorite'] = Variable<bool>(isFavorite.value);
    }
    if (isCustom.present) {
      map['is_custom'] = Variable<bool>(isCustom.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AffirmationsCompanion(')
          ..write('id: $id, ')
          ..write('content: $content, ')
          ..write('category: $category, ')
          ..write('isFavorite: $isFavorite, ')
          ..write('isCustom: $isCustom, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $MoodsTable extends Moods with TableInfo<$MoodsTable, Mood> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MoodsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _moodLevelMeta = const VerificationMeta(
    'moodLevel',
  );
  @override
  late final GeneratedColumn<int> moodLevel = GeneratedColumn<int>(
    'mood_level',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _stressLevelMeta = const VerificationMeta(
    'stressLevel',
  );
  @override
  late final GeneratedColumn<int> stressLevel = GeneratedColumn<int>(
    'stress_level',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _energyLevelMeta = const VerificationMeta(
    'energyLevel',
  );
  @override
  late final GeneratedColumn<int> energyLevel = GeneratedColumn<int>(
    'energy_level',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sleepQualityMeta = const VerificationMeta(
    'sleepQuality',
  );
  @override
  late final GeneratedColumn<int> sleepQuality = GeneratedColumn<int>(
    'sleep_quality',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _recordedAtMeta = const VerificationMeta(
    'recordedAt',
  );
  @override
  late final GeneratedColumn<DateTime> recordedAt = GeneratedColumn<DateTime>(
    'recorded_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    moodLevel,
    stressLevel,
    energyLevel,
    sleepQuality,
    notes,
    recordedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'moods';
  @override
  VerificationContext validateIntegrity(
    Insertable<Mood> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('mood_level')) {
      context.handle(
        _moodLevelMeta,
        moodLevel.isAcceptableOrUnknown(data['mood_level']!, _moodLevelMeta),
      );
    } else if (isInserting) {
      context.missing(_moodLevelMeta);
    }
    if (data.containsKey('stress_level')) {
      context.handle(
        _stressLevelMeta,
        stressLevel.isAcceptableOrUnknown(
          data['stress_level']!,
          _stressLevelMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_stressLevelMeta);
    }
    if (data.containsKey('energy_level')) {
      context.handle(
        _energyLevelMeta,
        energyLevel.isAcceptableOrUnknown(
          data['energy_level']!,
          _energyLevelMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_energyLevelMeta);
    }
    if (data.containsKey('sleep_quality')) {
      context.handle(
        _sleepQualityMeta,
        sleepQuality.isAcceptableOrUnknown(
          data['sleep_quality']!,
          _sleepQualityMeta,
        ),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('recorded_at')) {
      context.handle(
        _recordedAtMeta,
        recordedAt.isAcceptableOrUnknown(data['recorded_at']!, _recordedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Mood map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Mood(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      moodLevel: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}mood_level'],
      )!,
      stressLevel: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}stress_level'],
      )!,
      energyLevel: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}energy_level'],
      )!,
      sleepQuality: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sleep_quality'],
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      )!,
      recordedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}recorded_at'],
      )!,
    );
  }

  @override
  $MoodsTable createAlias(String alias) {
    return $MoodsTable(attachedDatabase, alias);
  }
}

class Mood extends DataClass implements Insertable<Mood> {
  final int id;
  final int moodLevel;
  final int stressLevel;
  final int energyLevel;
  final int? sleepQuality;
  final String notes;
  final DateTime recordedAt;
  const Mood({
    required this.id,
    required this.moodLevel,
    required this.stressLevel,
    required this.energyLevel,
    this.sleepQuality,
    required this.notes,
    required this.recordedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['mood_level'] = Variable<int>(moodLevel);
    map['stress_level'] = Variable<int>(stressLevel);
    map['energy_level'] = Variable<int>(energyLevel);
    if (!nullToAbsent || sleepQuality != null) {
      map['sleep_quality'] = Variable<int>(sleepQuality);
    }
    map['notes'] = Variable<String>(notes);
    map['recorded_at'] = Variable<DateTime>(recordedAt);
    return map;
  }

  MoodsCompanion toCompanion(bool nullToAbsent) {
    return MoodsCompanion(
      id: Value(id),
      moodLevel: Value(moodLevel),
      stressLevel: Value(stressLevel),
      energyLevel: Value(energyLevel),
      sleepQuality: sleepQuality == null && nullToAbsent
          ? const Value.absent()
          : Value(sleepQuality),
      notes: Value(notes),
      recordedAt: Value(recordedAt),
    );
  }

  factory Mood.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Mood(
      id: serializer.fromJson<int>(json['id']),
      moodLevel: serializer.fromJson<int>(json['moodLevel']),
      stressLevel: serializer.fromJson<int>(json['stressLevel']),
      energyLevel: serializer.fromJson<int>(json['energyLevel']),
      sleepQuality: serializer.fromJson<int?>(json['sleepQuality']),
      notes: serializer.fromJson<String>(json['notes']),
      recordedAt: serializer.fromJson<DateTime>(json['recordedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'moodLevel': serializer.toJson<int>(moodLevel),
      'stressLevel': serializer.toJson<int>(stressLevel),
      'energyLevel': serializer.toJson<int>(energyLevel),
      'sleepQuality': serializer.toJson<int?>(sleepQuality),
      'notes': serializer.toJson<String>(notes),
      'recordedAt': serializer.toJson<DateTime>(recordedAt),
    };
  }

  Mood copyWith({
    int? id,
    int? moodLevel,
    int? stressLevel,
    int? energyLevel,
    Value<int?> sleepQuality = const Value.absent(),
    String? notes,
    DateTime? recordedAt,
  }) => Mood(
    id: id ?? this.id,
    moodLevel: moodLevel ?? this.moodLevel,
    stressLevel: stressLevel ?? this.stressLevel,
    energyLevel: energyLevel ?? this.energyLevel,
    sleepQuality: sleepQuality.present ? sleepQuality.value : this.sleepQuality,
    notes: notes ?? this.notes,
    recordedAt: recordedAt ?? this.recordedAt,
  );
  Mood copyWithCompanion(MoodsCompanion data) {
    return Mood(
      id: data.id.present ? data.id.value : this.id,
      moodLevel: data.moodLevel.present ? data.moodLevel.value : this.moodLevel,
      stressLevel: data.stressLevel.present
          ? data.stressLevel.value
          : this.stressLevel,
      energyLevel: data.energyLevel.present
          ? data.energyLevel.value
          : this.energyLevel,
      sleepQuality: data.sleepQuality.present
          ? data.sleepQuality.value
          : this.sleepQuality,
      notes: data.notes.present ? data.notes.value : this.notes,
      recordedAt: data.recordedAt.present
          ? data.recordedAt.value
          : this.recordedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Mood(')
          ..write('id: $id, ')
          ..write('moodLevel: $moodLevel, ')
          ..write('stressLevel: $stressLevel, ')
          ..write('energyLevel: $energyLevel, ')
          ..write('sleepQuality: $sleepQuality, ')
          ..write('notes: $notes, ')
          ..write('recordedAt: $recordedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    moodLevel,
    stressLevel,
    energyLevel,
    sleepQuality,
    notes,
    recordedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Mood &&
          other.id == this.id &&
          other.moodLevel == this.moodLevel &&
          other.stressLevel == this.stressLevel &&
          other.energyLevel == this.energyLevel &&
          other.sleepQuality == this.sleepQuality &&
          other.notes == this.notes &&
          other.recordedAt == this.recordedAt);
}

class MoodsCompanion extends UpdateCompanion<Mood> {
  final Value<int> id;
  final Value<int> moodLevel;
  final Value<int> stressLevel;
  final Value<int> energyLevel;
  final Value<int?> sleepQuality;
  final Value<String> notes;
  final Value<DateTime> recordedAt;
  const MoodsCompanion({
    this.id = const Value.absent(),
    this.moodLevel = const Value.absent(),
    this.stressLevel = const Value.absent(),
    this.energyLevel = const Value.absent(),
    this.sleepQuality = const Value.absent(),
    this.notes = const Value.absent(),
    this.recordedAt = const Value.absent(),
  });
  MoodsCompanion.insert({
    this.id = const Value.absent(),
    required int moodLevel,
    required int stressLevel,
    required int energyLevel,
    this.sleepQuality = const Value.absent(),
    this.notes = const Value.absent(),
    this.recordedAt = const Value.absent(),
  }) : moodLevel = Value(moodLevel),
       stressLevel = Value(stressLevel),
       energyLevel = Value(energyLevel);
  static Insertable<Mood> custom({
    Expression<int>? id,
    Expression<int>? moodLevel,
    Expression<int>? stressLevel,
    Expression<int>? energyLevel,
    Expression<int>? sleepQuality,
    Expression<String>? notes,
    Expression<DateTime>? recordedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (moodLevel != null) 'mood_level': moodLevel,
      if (stressLevel != null) 'stress_level': stressLevel,
      if (energyLevel != null) 'energy_level': energyLevel,
      if (sleepQuality != null) 'sleep_quality': sleepQuality,
      if (notes != null) 'notes': notes,
      if (recordedAt != null) 'recorded_at': recordedAt,
    });
  }

  MoodsCompanion copyWith({
    Value<int>? id,
    Value<int>? moodLevel,
    Value<int>? stressLevel,
    Value<int>? energyLevel,
    Value<int?>? sleepQuality,
    Value<String>? notes,
    Value<DateTime>? recordedAt,
  }) {
    return MoodsCompanion(
      id: id ?? this.id,
      moodLevel: moodLevel ?? this.moodLevel,
      stressLevel: stressLevel ?? this.stressLevel,
      energyLevel: energyLevel ?? this.energyLevel,
      sleepQuality: sleepQuality ?? this.sleepQuality,
      notes: notes ?? this.notes,
      recordedAt: recordedAt ?? this.recordedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (moodLevel.present) {
      map['mood_level'] = Variable<int>(moodLevel.value);
    }
    if (stressLevel.present) {
      map['stress_level'] = Variable<int>(stressLevel.value);
    }
    if (energyLevel.present) {
      map['energy_level'] = Variable<int>(energyLevel.value);
    }
    if (sleepQuality.present) {
      map['sleep_quality'] = Variable<int>(sleepQuality.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (recordedAt.present) {
      map['recorded_at'] = Variable<DateTime>(recordedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MoodsCompanion(')
          ..write('id: $id, ')
          ..write('moodLevel: $moodLevel, ')
          ..write('stressLevel: $stressLevel, ')
          ..write('energyLevel: $energyLevel, ')
          ..write('sleepQuality: $sleepQuality, ')
          ..write('notes: $notes, ')
          ..write('recordedAt: $recordedAt')
          ..write(')'))
        .toString();
  }
}

class $JournalEntriesTable extends JournalEntries
    with TableInfo<$JournalEntriesTable, JournalEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $JournalEntriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _bodyMeta = const VerificationMeta('body');
  @override
  late final GeneratedColumn<String> body = GeneratedColumn<String>(
    'body',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _tagsMeta = const VerificationMeta('tags');
  @override
  late final GeneratedColumn<String> tags = GeneratedColumn<String>(
    'tags',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _moodIdMeta = const VerificationMeta('moodId');
  @override
  late final GeneratedColumn<int> moodId = GeneratedColumn<int>(
    'mood_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES moods (id)',
    ),
  );
  static const VerificationMeta _isFavoriteMeta = const VerificationMeta(
    'isFavorite',
  );
  @override
  late final GeneratedColumn<bool> isFavorite = GeneratedColumn<bool>(
    'is_favorite',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_favorite" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    title,
    body,
    tags,
    moodId,
    isFavorite,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'journal_entries';
  @override
  VerificationContext validateIntegrity(
    Insertable<JournalEntry> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    }
    if (data.containsKey('body')) {
      context.handle(
        _bodyMeta,
        body.isAcceptableOrUnknown(data['body']!, _bodyMeta),
      );
    } else if (isInserting) {
      context.missing(_bodyMeta);
    }
    if (data.containsKey('tags')) {
      context.handle(
        _tagsMeta,
        tags.isAcceptableOrUnknown(data['tags']!, _tagsMeta),
      );
    }
    if (data.containsKey('mood_id')) {
      context.handle(
        _moodIdMeta,
        moodId.isAcceptableOrUnknown(data['mood_id']!, _moodIdMeta),
      );
    }
    if (data.containsKey('is_favorite')) {
      context.handle(
        _isFavoriteMeta,
        isFavorite.isAcceptableOrUnknown(data['is_favorite']!, _isFavoriteMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  JournalEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return JournalEntry(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      body: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}body'],
      )!,
      tags: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tags'],
      )!,
      moodId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}mood_id'],
      ),
      isFavorite: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_favorite'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $JournalEntriesTable createAlias(String alias) {
    return $JournalEntriesTable(attachedDatabase, alias);
  }
}

class JournalEntry extends DataClass implements Insertable<JournalEntry> {
  final int id;
  final String title;
  final String body;
  final String tags;
  final int? moodId;
  final bool isFavorite;
  final DateTime createdAt;
  final DateTime updatedAt;
  const JournalEntry({
    required this.id,
    required this.title,
    required this.body,
    required this.tags,
    this.moodId,
    required this.isFavorite,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['title'] = Variable<String>(title);
    map['body'] = Variable<String>(body);
    map['tags'] = Variable<String>(tags);
    if (!nullToAbsent || moodId != null) {
      map['mood_id'] = Variable<int>(moodId);
    }
    map['is_favorite'] = Variable<bool>(isFavorite);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  JournalEntriesCompanion toCompanion(bool nullToAbsent) {
    return JournalEntriesCompanion(
      id: Value(id),
      title: Value(title),
      body: Value(body),
      tags: Value(tags),
      moodId: moodId == null && nullToAbsent
          ? const Value.absent()
          : Value(moodId),
      isFavorite: Value(isFavorite),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory JournalEntry.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return JournalEntry(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      body: serializer.fromJson<String>(json['body']),
      tags: serializer.fromJson<String>(json['tags']),
      moodId: serializer.fromJson<int?>(json['moodId']),
      isFavorite: serializer.fromJson<bool>(json['isFavorite']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'body': serializer.toJson<String>(body),
      'tags': serializer.toJson<String>(tags),
      'moodId': serializer.toJson<int?>(moodId),
      'isFavorite': serializer.toJson<bool>(isFavorite),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  JournalEntry copyWith({
    int? id,
    String? title,
    String? body,
    String? tags,
    Value<int?> moodId = const Value.absent(),
    bool? isFavorite,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => JournalEntry(
    id: id ?? this.id,
    title: title ?? this.title,
    body: body ?? this.body,
    tags: tags ?? this.tags,
    moodId: moodId.present ? moodId.value : this.moodId,
    isFavorite: isFavorite ?? this.isFavorite,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  JournalEntry copyWithCompanion(JournalEntriesCompanion data) {
    return JournalEntry(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      body: data.body.present ? data.body.value : this.body,
      tags: data.tags.present ? data.tags.value : this.tags,
      moodId: data.moodId.present ? data.moodId.value : this.moodId,
      isFavorite: data.isFavorite.present
          ? data.isFavorite.value
          : this.isFavorite,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('JournalEntry(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('body: $body, ')
          ..write('tags: $tags, ')
          ..write('moodId: $moodId, ')
          ..write('isFavorite: $isFavorite, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    title,
    body,
    tags,
    moodId,
    isFavorite,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is JournalEntry &&
          other.id == this.id &&
          other.title == this.title &&
          other.body == this.body &&
          other.tags == this.tags &&
          other.moodId == this.moodId &&
          other.isFavorite == this.isFavorite &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class JournalEntriesCompanion extends UpdateCompanion<JournalEntry> {
  final Value<int> id;
  final Value<String> title;
  final Value<String> body;
  final Value<String> tags;
  final Value<int?> moodId;
  final Value<bool> isFavorite;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const JournalEntriesCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.body = const Value.absent(),
    this.tags = const Value.absent(),
    this.moodId = const Value.absent(),
    this.isFavorite = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  JournalEntriesCompanion.insert({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    required String body,
    this.tags = const Value.absent(),
    this.moodId = const Value.absent(),
    this.isFavorite = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : body = Value(body);
  static Insertable<JournalEntry> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<String>? body,
    Expression<String>? tags,
    Expression<int>? moodId,
    Expression<bool>? isFavorite,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (body != null) 'body': body,
      if (tags != null) 'tags': tags,
      if (moodId != null) 'mood_id': moodId,
      if (isFavorite != null) 'is_favorite': isFavorite,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  JournalEntriesCompanion copyWith({
    Value<int>? id,
    Value<String>? title,
    Value<String>? body,
    Value<String>? tags,
    Value<int?>? moodId,
    Value<bool>? isFavorite,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return JournalEntriesCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      body: body ?? this.body,
      tags: tags ?? this.tags,
      moodId: moodId ?? this.moodId,
      isFavorite: isFavorite ?? this.isFavorite,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (body.present) {
      map['body'] = Variable<String>(body.value);
    }
    if (tags.present) {
      map['tags'] = Variable<String>(tags.value);
    }
    if (moodId.present) {
      map['mood_id'] = Variable<int>(moodId.value);
    }
    if (isFavorite.present) {
      map['is_favorite'] = Variable<bool>(isFavorite.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('JournalEntriesCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('body: $body, ')
          ..write('tags: $tags, ')
          ..write('moodId: $moodId, ')
          ..write('isFavorite: $isFavorite, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $RemindersTable extends Reminders
    with TableInfo<$RemindersTable, Reminder> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RemindersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _timeOfDayMeta = const VerificationMeta(
    'timeOfDay',
  );
  @override
  late final GeneratedColumn<String> timeOfDay = GeneratedColumn<String>(
    'time_of_day',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _enabledMeta = const VerificationMeta(
    'enabled',
  );
  @override
  late final GeneratedColumn<bool> enabled = GeneratedColumn<bool>(
    'enabled',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("enabled" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _daysOfWeekMeta = const VerificationMeta(
    'daysOfWeek',
  );
  @override
  late final GeneratedColumn<String> daysOfWeek = GeneratedColumn<String>(
    'days_of_week',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('1,2,3,4,5'),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    type,
    title,
    timeOfDay,
    enabled,
    daysOfWeek,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'reminders';
  @override
  VerificationContext validateIntegrity(
    Insertable<Reminder> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('time_of_day')) {
      context.handle(
        _timeOfDayMeta,
        timeOfDay.isAcceptableOrUnknown(data['time_of_day']!, _timeOfDayMeta),
      );
    } else if (isInserting) {
      context.missing(_timeOfDayMeta);
    }
    if (data.containsKey('enabled')) {
      context.handle(
        _enabledMeta,
        enabled.isAcceptableOrUnknown(data['enabled']!, _enabledMeta),
      );
    }
    if (data.containsKey('days_of_week')) {
      context.handle(
        _daysOfWeekMeta,
        daysOfWeek.isAcceptableOrUnknown(
          data['days_of_week']!,
          _daysOfWeekMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Reminder map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Reminder(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      timeOfDay: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}time_of_day'],
      )!,
      enabled: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}enabled'],
      )!,
      daysOfWeek: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}days_of_week'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $RemindersTable createAlias(String alias) {
    return $RemindersTable(attachedDatabase, alias);
  }
}

class Reminder extends DataClass implements Insertable<Reminder> {
  final int id;
  final String type;
  final String title;
  final String timeOfDay;
  final bool enabled;
  final String daysOfWeek;
  final DateTime createdAt;
  const Reminder({
    required this.id,
    required this.type,
    required this.title,
    required this.timeOfDay,
    required this.enabled,
    required this.daysOfWeek,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['type'] = Variable<String>(type);
    map['title'] = Variable<String>(title);
    map['time_of_day'] = Variable<String>(timeOfDay);
    map['enabled'] = Variable<bool>(enabled);
    map['days_of_week'] = Variable<String>(daysOfWeek);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  RemindersCompanion toCompanion(bool nullToAbsent) {
    return RemindersCompanion(
      id: Value(id),
      type: Value(type),
      title: Value(title),
      timeOfDay: Value(timeOfDay),
      enabled: Value(enabled),
      daysOfWeek: Value(daysOfWeek),
      createdAt: Value(createdAt),
    );
  }

  factory Reminder.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Reminder(
      id: serializer.fromJson<int>(json['id']),
      type: serializer.fromJson<String>(json['type']),
      title: serializer.fromJson<String>(json['title']),
      timeOfDay: serializer.fromJson<String>(json['timeOfDay']),
      enabled: serializer.fromJson<bool>(json['enabled']),
      daysOfWeek: serializer.fromJson<String>(json['daysOfWeek']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'type': serializer.toJson<String>(type),
      'title': serializer.toJson<String>(title),
      'timeOfDay': serializer.toJson<String>(timeOfDay),
      'enabled': serializer.toJson<bool>(enabled),
      'daysOfWeek': serializer.toJson<String>(daysOfWeek),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Reminder copyWith({
    int? id,
    String? type,
    String? title,
    String? timeOfDay,
    bool? enabled,
    String? daysOfWeek,
    DateTime? createdAt,
  }) => Reminder(
    id: id ?? this.id,
    type: type ?? this.type,
    title: title ?? this.title,
    timeOfDay: timeOfDay ?? this.timeOfDay,
    enabled: enabled ?? this.enabled,
    daysOfWeek: daysOfWeek ?? this.daysOfWeek,
    createdAt: createdAt ?? this.createdAt,
  );
  Reminder copyWithCompanion(RemindersCompanion data) {
    return Reminder(
      id: data.id.present ? data.id.value : this.id,
      type: data.type.present ? data.type.value : this.type,
      title: data.title.present ? data.title.value : this.title,
      timeOfDay: data.timeOfDay.present ? data.timeOfDay.value : this.timeOfDay,
      enabled: data.enabled.present ? data.enabled.value : this.enabled,
      daysOfWeek: data.daysOfWeek.present
          ? data.daysOfWeek.value
          : this.daysOfWeek,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Reminder(')
          ..write('id: $id, ')
          ..write('type: $type, ')
          ..write('title: $title, ')
          ..write('timeOfDay: $timeOfDay, ')
          ..write('enabled: $enabled, ')
          ..write('daysOfWeek: $daysOfWeek, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, type, title, timeOfDay, enabled, daysOfWeek, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Reminder &&
          other.id == this.id &&
          other.type == this.type &&
          other.title == this.title &&
          other.timeOfDay == this.timeOfDay &&
          other.enabled == this.enabled &&
          other.daysOfWeek == this.daysOfWeek &&
          other.createdAt == this.createdAt);
}

class RemindersCompanion extends UpdateCompanion<Reminder> {
  final Value<int> id;
  final Value<String> type;
  final Value<String> title;
  final Value<String> timeOfDay;
  final Value<bool> enabled;
  final Value<String> daysOfWeek;
  final Value<DateTime> createdAt;
  const RemindersCompanion({
    this.id = const Value.absent(),
    this.type = const Value.absent(),
    this.title = const Value.absent(),
    this.timeOfDay = const Value.absent(),
    this.enabled = const Value.absent(),
    this.daysOfWeek = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  RemindersCompanion.insert({
    this.id = const Value.absent(),
    required String type,
    required String title,
    required String timeOfDay,
    this.enabled = const Value.absent(),
    this.daysOfWeek = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : type = Value(type),
       title = Value(title),
       timeOfDay = Value(timeOfDay);
  static Insertable<Reminder> custom({
    Expression<int>? id,
    Expression<String>? type,
    Expression<String>? title,
    Expression<String>? timeOfDay,
    Expression<bool>? enabled,
    Expression<String>? daysOfWeek,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (type != null) 'type': type,
      if (title != null) 'title': title,
      if (timeOfDay != null) 'time_of_day': timeOfDay,
      if (enabled != null) 'enabled': enabled,
      if (daysOfWeek != null) 'days_of_week': daysOfWeek,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  RemindersCompanion copyWith({
    Value<int>? id,
    Value<String>? type,
    Value<String>? title,
    Value<String>? timeOfDay,
    Value<bool>? enabled,
    Value<String>? daysOfWeek,
    Value<DateTime>? createdAt,
  }) {
    return RemindersCompanion(
      id: id ?? this.id,
      type: type ?? this.type,
      title: title ?? this.title,
      timeOfDay: timeOfDay ?? this.timeOfDay,
      enabled: enabled ?? this.enabled,
      daysOfWeek: daysOfWeek ?? this.daysOfWeek,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (timeOfDay.present) {
      map['time_of_day'] = Variable<String>(timeOfDay.value);
    }
    if (enabled.present) {
      map['enabled'] = Variable<bool>(enabled.value);
    }
    if (daysOfWeek.present) {
      map['days_of_week'] = Variable<String>(daysOfWeek.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RemindersCompanion(')
          ..write('id: $id, ')
          ..write('type: $type, ')
          ..write('title: $title, ')
          ..write('timeOfDay: $timeOfDay, ')
          ..write('enabled: $enabled, ')
          ..write('daysOfWeek: $daysOfWeek, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $AchievementsTable extends Achievements
    with TableInfo<$AchievementsTable, Achievement> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AchievementsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _slugMeta = const VerificationMeta('slug');
  @override
  late final GeneratedColumn<String> slug = GeneratedColumn<String>(
    'slug',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _iconMeta = const VerificationMeta('icon');
  @override
  late final GeneratedColumn<String> icon = GeneratedColumn<String>(
    'icon',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isUnlockedMeta = const VerificationMeta(
    'isUnlocked',
  );
  @override
  late final GeneratedColumn<bool> isUnlocked = GeneratedColumn<bool>(
    'is_unlocked',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_unlocked" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _unlockedAtMeta = const VerificationMeta(
    'unlockedAt',
  );
  @override
  late final GeneratedColumn<DateTime> unlockedAt = GeneratedColumn<DateTime>(
    'unlocked_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    slug,
    title,
    description,
    icon,
    isUnlocked,
    unlockedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'achievements';
  @override
  VerificationContext validateIntegrity(
    Insertable<Achievement> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('slug')) {
      context.handle(
        _slugMeta,
        slug.isAcceptableOrUnknown(data['slug']!, _slugMeta),
      );
    } else if (isInserting) {
      context.missing(_slugMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('icon')) {
      context.handle(
        _iconMeta,
        icon.isAcceptableOrUnknown(data['icon']!, _iconMeta),
      );
    } else if (isInserting) {
      context.missing(_iconMeta);
    }
    if (data.containsKey('is_unlocked')) {
      context.handle(
        _isUnlockedMeta,
        isUnlocked.isAcceptableOrUnknown(data['is_unlocked']!, _isUnlockedMeta),
      );
    }
    if (data.containsKey('unlocked_at')) {
      context.handle(
        _unlockedAtMeta,
        unlockedAt.isAcceptableOrUnknown(data['unlocked_at']!, _unlockedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Achievement map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Achievement(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      slug: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}slug'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      )!,
      icon: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}icon'],
      )!,
      isUnlocked: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_unlocked'],
      )!,
      unlockedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}unlocked_at'],
      ),
    );
  }

  @override
  $AchievementsTable createAlias(String alias) {
    return $AchievementsTable(attachedDatabase, alias);
  }
}

class Achievement extends DataClass implements Insertable<Achievement> {
  final int id;
  final String slug;
  final String title;
  final String description;
  final String icon;
  final bool isUnlocked;
  final DateTime? unlockedAt;
  const Achievement({
    required this.id,
    required this.slug,
    required this.title,
    required this.description,
    required this.icon,
    required this.isUnlocked,
    this.unlockedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['slug'] = Variable<String>(slug);
    map['title'] = Variable<String>(title);
    map['description'] = Variable<String>(description);
    map['icon'] = Variable<String>(icon);
    map['is_unlocked'] = Variable<bool>(isUnlocked);
    if (!nullToAbsent || unlockedAt != null) {
      map['unlocked_at'] = Variable<DateTime>(unlockedAt);
    }
    return map;
  }

  AchievementsCompanion toCompanion(bool nullToAbsent) {
    return AchievementsCompanion(
      id: Value(id),
      slug: Value(slug),
      title: Value(title),
      description: Value(description),
      icon: Value(icon),
      isUnlocked: Value(isUnlocked),
      unlockedAt: unlockedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(unlockedAt),
    );
  }

  factory Achievement.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Achievement(
      id: serializer.fromJson<int>(json['id']),
      slug: serializer.fromJson<String>(json['slug']),
      title: serializer.fromJson<String>(json['title']),
      description: serializer.fromJson<String>(json['description']),
      icon: serializer.fromJson<String>(json['icon']),
      isUnlocked: serializer.fromJson<bool>(json['isUnlocked']),
      unlockedAt: serializer.fromJson<DateTime?>(json['unlockedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'slug': serializer.toJson<String>(slug),
      'title': serializer.toJson<String>(title),
      'description': serializer.toJson<String>(description),
      'icon': serializer.toJson<String>(icon),
      'isUnlocked': serializer.toJson<bool>(isUnlocked),
      'unlockedAt': serializer.toJson<DateTime?>(unlockedAt),
    };
  }

  Achievement copyWith({
    int? id,
    String? slug,
    String? title,
    String? description,
    String? icon,
    bool? isUnlocked,
    Value<DateTime?> unlockedAt = const Value.absent(),
  }) => Achievement(
    id: id ?? this.id,
    slug: slug ?? this.slug,
    title: title ?? this.title,
    description: description ?? this.description,
    icon: icon ?? this.icon,
    isUnlocked: isUnlocked ?? this.isUnlocked,
    unlockedAt: unlockedAt.present ? unlockedAt.value : this.unlockedAt,
  );
  Achievement copyWithCompanion(AchievementsCompanion data) {
    return Achievement(
      id: data.id.present ? data.id.value : this.id,
      slug: data.slug.present ? data.slug.value : this.slug,
      title: data.title.present ? data.title.value : this.title,
      description: data.description.present
          ? data.description.value
          : this.description,
      icon: data.icon.present ? data.icon.value : this.icon,
      isUnlocked: data.isUnlocked.present
          ? data.isUnlocked.value
          : this.isUnlocked,
      unlockedAt: data.unlockedAt.present
          ? data.unlockedAt.value
          : this.unlockedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Achievement(')
          ..write('id: $id, ')
          ..write('slug: $slug, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('icon: $icon, ')
          ..write('isUnlocked: $isUnlocked, ')
          ..write('unlockedAt: $unlockedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, slug, title, description, icon, isUnlocked, unlockedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Achievement &&
          other.id == this.id &&
          other.slug == this.slug &&
          other.title == this.title &&
          other.description == this.description &&
          other.icon == this.icon &&
          other.isUnlocked == this.isUnlocked &&
          other.unlockedAt == this.unlockedAt);
}

class AchievementsCompanion extends UpdateCompanion<Achievement> {
  final Value<int> id;
  final Value<String> slug;
  final Value<String> title;
  final Value<String> description;
  final Value<String> icon;
  final Value<bool> isUnlocked;
  final Value<DateTime?> unlockedAt;
  const AchievementsCompanion({
    this.id = const Value.absent(),
    this.slug = const Value.absent(),
    this.title = const Value.absent(),
    this.description = const Value.absent(),
    this.icon = const Value.absent(),
    this.isUnlocked = const Value.absent(),
    this.unlockedAt = const Value.absent(),
  });
  AchievementsCompanion.insert({
    this.id = const Value.absent(),
    required String slug,
    required String title,
    required String description,
    required String icon,
    this.isUnlocked = const Value.absent(),
    this.unlockedAt = const Value.absent(),
  }) : slug = Value(slug),
       title = Value(title),
       description = Value(description),
       icon = Value(icon);
  static Insertable<Achievement> custom({
    Expression<int>? id,
    Expression<String>? slug,
    Expression<String>? title,
    Expression<String>? description,
    Expression<String>? icon,
    Expression<bool>? isUnlocked,
    Expression<DateTime>? unlockedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (slug != null) 'slug': slug,
      if (title != null) 'title': title,
      if (description != null) 'description': description,
      if (icon != null) 'icon': icon,
      if (isUnlocked != null) 'is_unlocked': isUnlocked,
      if (unlockedAt != null) 'unlocked_at': unlockedAt,
    });
  }

  AchievementsCompanion copyWith({
    Value<int>? id,
    Value<String>? slug,
    Value<String>? title,
    Value<String>? description,
    Value<String>? icon,
    Value<bool>? isUnlocked,
    Value<DateTime?>? unlockedAt,
  }) {
    return AchievementsCompanion(
      id: id ?? this.id,
      slug: slug ?? this.slug,
      title: title ?? this.title,
      description: description ?? this.description,
      icon: icon ?? this.icon,
      isUnlocked: isUnlocked ?? this.isUnlocked,
      unlockedAt: unlockedAt ?? this.unlockedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (slug.present) {
      map['slug'] = Variable<String>(slug.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (icon.present) {
      map['icon'] = Variable<String>(icon.value);
    }
    if (isUnlocked.present) {
      map['is_unlocked'] = Variable<bool>(isUnlocked.value);
    }
    if (unlockedAt.present) {
      map['unlocked_at'] = Variable<DateTime>(unlockedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AchievementsCompanion(')
          ..write('id: $id, ')
          ..write('slug: $slug, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('icon: $icon, ')
          ..write('isUnlocked: $isUnlocked, ')
          ..write('unlockedAt: $unlockedAt')
          ..write(')'))
        .toString();
  }
}

class $DailyProgressesTable extends DailyProgresses
    with TableInfo<$DailyProgressesTable, DailyProgressesData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DailyProgressesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _wellnessScoreMeta = const VerificationMeta(
    'wellnessScore',
  );
  @override
  late final GeneratedColumn<int> wellnessScore = GeneratedColumn<int>(
    'wellness_score',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _exercisesCompletedMeta =
      const VerificationMeta('exercisesCompleted');
  @override
  late final GeneratedColumn<int> exercisesCompleted = GeneratedColumn<int>(
    'exercises_completed',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _breathingSessionsMeta = const VerificationMeta(
    'breathingSessions',
  );
  @override
  late final GeneratedColumn<int> breathingSessions = GeneratedColumn<int>(
    'breathing_sessions',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _journalEntriesMeta = const VerificationMeta(
    'journalEntries',
  );
  @override
  late final GeneratedColumn<int> journalEntries = GeneratedColumn<int>(
    'journal_entries',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _waterGlassesMeta = const VerificationMeta(
    'waterGlasses',
  );
  @override
  late final GeneratedColumn<int> waterGlasses = GeneratedColumn<int>(
    'water_glasses',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _streakDayMeta = const VerificationMeta(
    'streakDay',
  );
  @override
  late final GeneratedColumn<int> streakDay = GeneratedColumn<int>(
    'streak_day',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    date,
    wellnessScore,
    exercisesCompleted,
    breathingSessions,
    journalEntries,
    waterGlasses,
    streakDay,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'daily_progresses';
  @override
  VerificationContext validateIntegrity(
    Insertable<DailyProgressesData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('wellness_score')) {
      context.handle(
        _wellnessScoreMeta,
        wellnessScore.isAcceptableOrUnknown(
          data['wellness_score']!,
          _wellnessScoreMeta,
        ),
      );
    }
    if (data.containsKey('exercises_completed')) {
      context.handle(
        _exercisesCompletedMeta,
        exercisesCompleted.isAcceptableOrUnknown(
          data['exercises_completed']!,
          _exercisesCompletedMeta,
        ),
      );
    }
    if (data.containsKey('breathing_sessions')) {
      context.handle(
        _breathingSessionsMeta,
        breathingSessions.isAcceptableOrUnknown(
          data['breathing_sessions']!,
          _breathingSessionsMeta,
        ),
      );
    }
    if (data.containsKey('journal_entries')) {
      context.handle(
        _journalEntriesMeta,
        journalEntries.isAcceptableOrUnknown(
          data['journal_entries']!,
          _journalEntriesMeta,
        ),
      );
    }
    if (data.containsKey('water_glasses')) {
      context.handle(
        _waterGlassesMeta,
        waterGlasses.isAcceptableOrUnknown(
          data['water_glasses']!,
          _waterGlassesMeta,
        ),
      );
    }
    if (data.containsKey('streak_day')) {
      context.handle(
        _streakDayMeta,
        streakDay.isAcceptableOrUnknown(data['streak_day']!, _streakDayMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DailyProgressesData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DailyProgressesData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date'],
      )!,
      wellnessScore: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}wellness_score'],
      )!,
      exercisesCompleted: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}exercises_completed'],
      )!,
      breathingSessions: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}breathing_sessions'],
      )!,
      journalEntries: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}journal_entries'],
      )!,
      waterGlasses: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}water_glasses'],
      )!,
      streakDay: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}streak_day'],
      )!,
    );
  }

  @override
  $DailyProgressesTable createAlias(String alias) {
    return $DailyProgressesTable(attachedDatabase, alias);
  }
}

class DailyProgressesData extends DataClass
    implements Insertable<DailyProgressesData> {
  final int id;
  final DateTime date;
  final int wellnessScore;
  final int exercisesCompleted;
  final int breathingSessions;
  final int journalEntries;
  final int waterGlasses;
  final int streakDay;
  const DailyProgressesData({
    required this.id,
    required this.date,
    required this.wellnessScore,
    required this.exercisesCompleted,
    required this.breathingSessions,
    required this.journalEntries,
    required this.waterGlasses,
    required this.streakDay,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['date'] = Variable<DateTime>(date);
    map['wellness_score'] = Variable<int>(wellnessScore);
    map['exercises_completed'] = Variable<int>(exercisesCompleted);
    map['breathing_sessions'] = Variable<int>(breathingSessions);
    map['journal_entries'] = Variable<int>(journalEntries);
    map['water_glasses'] = Variable<int>(waterGlasses);
    map['streak_day'] = Variable<int>(streakDay);
    return map;
  }

  DailyProgressesCompanion toCompanion(bool nullToAbsent) {
    return DailyProgressesCompanion(
      id: Value(id),
      date: Value(date),
      wellnessScore: Value(wellnessScore),
      exercisesCompleted: Value(exercisesCompleted),
      breathingSessions: Value(breathingSessions),
      journalEntries: Value(journalEntries),
      waterGlasses: Value(waterGlasses),
      streakDay: Value(streakDay),
    );
  }

  factory DailyProgressesData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DailyProgressesData(
      id: serializer.fromJson<int>(json['id']),
      date: serializer.fromJson<DateTime>(json['date']),
      wellnessScore: serializer.fromJson<int>(json['wellnessScore']),
      exercisesCompleted: serializer.fromJson<int>(json['exercisesCompleted']),
      breathingSessions: serializer.fromJson<int>(json['breathingSessions']),
      journalEntries: serializer.fromJson<int>(json['journalEntries']),
      waterGlasses: serializer.fromJson<int>(json['waterGlasses']),
      streakDay: serializer.fromJson<int>(json['streakDay']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'date': serializer.toJson<DateTime>(date),
      'wellnessScore': serializer.toJson<int>(wellnessScore),
      'exercisesCompleted': serializer.toJson<int>(exercisesCompleted),
      'breathingSessions': serializer.toJson<int>(breathingSessions),
      'journalEntries': serializer.toJson<int>(journalEntries),
      'waterGlasses': serializer.toJson<int>(waterGlasses),
      'streakDay': serializer.toJson<int>(streakDay),
    };
  }

  DailyProgressesData copyWith({
    int? id,
    DateTime? date,
    int? wellnessScore,
    int? exercisesCompleted,
    int? breathingSessions,
    int? journalEntries,
    int? waterGlasses,
    int? streakDay,
  }) => DailyProgressesData(
    id: id ?? this.id,
    date: date ?? this.date,
    wellnessScore: wellnessScore ?? this.wellnessScore,
    exercisesCompleted: exercisesCompleted ?? this.exercisesCompleted,
    breathingSessions: breathingSessions ?? this.breathingSessions,
    journalEntries: journalEntries ?? this.journalEntries,
    waterGlasses: waterGlasses ?? this.waterGlasses,
    streakDay: streakDay ?? this.streakDay,
  );
  DailyProgressesData copyWithCompanion(DailyProgressesCompanion data) {
    return DailyProgressesData(
      id: data.id.present ? data.id.value : this.id,
      date: data.date.present ? data.date.value : this.date,
      wellnessScore: data.wellnessScore.present
          ? data.wellnessScore.value
          : this.wellnessScore,
      exercisesCompleted: data.exercisesCompleted.present
          ? data.exercisesCompleted.value
          : this.exercisesCompleted,
      breathingSessions: data.breathingSessions.present
          ? data.breathingSessions.value
          : this.breathingSessions,
      journalEntries: data.journalEntries.present
          ? data.journalEntries.value
          : this.journalEntries,
      waterGlasses: data.waterGlasses.present
          ? data.waterGlasses.value
          : this.waterGlasses,
      streakDay: data.streakDay.present ? data.streakDay.value : this.streakDay,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DailyProgressesData(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('wellnessScore: $wellnessScore, ')
          ..write('exercisesCompleted: $exercisesCompleted, ')
          ..write('breathingSessions: $breathingSessions, ')
          ..write('journalEntries: $journalEntries, ')
          ..write('waterGlasses: $waterGlasses, ')
          ..write('streakDay: $streakDay')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    date,
    wellnessScore,
    exercisesCompleted,
    breathingSessions,
    journalEntries,
    waterGlasses,
    streakDay,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DailyProgressesData &&
          other.id == this.id &&
          other.date == this.date &&
          other.wellnessScore == this.wellnessScore &&
          other.exercisesCompleted == this.exercisesCompleted &&
          other.breathingSessions == this.breathingSessions &&
          other.journalEntries == this.journalEntries &&
          other.waterGlasses == this.waterGlasses &&
          other.streakDay == this.streakDay);
}

class DailyProgressesCompanion extends UpdateCompanion<DailyProgressesData> {
  final Value<int> id;
  final Value<DateTime> date;
  final Value<int> wellnessScore;
  final Value<int> exercisesCompleted;
  final Value<int> breathingSessions;
  final Value<int> journalEntries;
  final Value<int> waterGlasses;
  final Value<int> streakDay;
  const DailyProgressesCompanion({
    this.id = const Value.absent(),
    this.date = const Value.absent(),
    this.wellnessScore = const Value.absent(),
    this.exercisesCompleted = const Value.absent(),
    this.breathingSessions = const Value.absent(),
    this.journalEntries = const Value.absent(),
    this.waterGlasses = const Value.absent(),
    this.streakDay = const Value.absent(),
  });
  DailyProgressesCompanion.insert({
    this.id = const Value.absent(),
    required DateTime date,
    this.wellnessScore = const Value.absent(),
    this.exercisesCompleted = const Value.absent(),
    this.breathingSessions = const Value.absent(),
    this.journalEntries = const Value.absent(),
    this.waterGlasses = const Value.absent(),
    this.streakDay = const Value.absent(),
  }) : date = Value(date);
  static Insertable<DailyProgressesData> custom({
    Expression<int>? id,
    Expression<DateTime>? date,
    Expression<int>? wellnessScore,
    Expression<int>? exercisesCompleted,
    Expression<int>? breathingSessions,
    Expression<int>? journalEntries,
    Expression<int>? waterGlasses,
    Expression<int>? streakDay,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (date != null) 'date': date,
      if (wellnessScore != null) 'wellness_score': wellnessScore,
      if (exercisesCompleted != null) 'exercises_completed': exercisesCompleted,
      if (breathingSessions != null) 'breathing_sessions': breathingSessions,
      if (journalEntries != null) 'journal_entries': journalEntries,
      if (waterGlasses != null) 'water_glasses': waterGlasses,
      if (streakDay != null) 'streak_day': streakDay,
    });
  }

  DailyProgressesCompanion copyWith({
    Value<int>? id,
    Value<DateTime>? date,
    Value<int>? wellnessScore,
    Value<int>? exercisesCompleted,
    Value<int>? breathingSessions,
    Value<int>? journalEntries,
    Value<int>? waterGlasses,
    Value<int>? streakDay,
  }) {
    return DailyProgressesCompanion(
      id: id ?? this.id,
      date: date ?? this.date,
      wellnessScore: wellnessScore ?? this.wellnessScore,
      exercisesCompleted: exercisesCompleted ?? this.exercisesCompleted,
      breathingSessions: breathingSessions ?? this.breathingSessions,
      journalEntries: journalEntries ?? this.journalEntries,
      waterGlasses: waterGlasses ?? this.waterGlasses,
      streakDay: streakDay ?? this.streakDay,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (wellnessScore.present) {
      map['wellness_score'] = Variable<int>(wellnessScore.value);
    }
    if (exercisesCompleted.present) {
      map['exercises_completed'] = Variable<int>(exercisesCompleted.value);
    }
    if (breathingSessions.present) {
      map['breathing_sessions'] = Variable<int>(breathingSessions.value);
    }
    if (journalEntries.present) {
      map['journal_entries'] = Variable<int>(journalEntries.value);
    }
    if (waterGlasses.present) {
      map['water_glasses'] = Variable<int>(waterGlasses.value);
    }
    if (streakDay.present) {
      map['streak_day'] = Variable<int>(streakDay.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DailyProgressesCompanion(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('wellnessScore: $wellnessScore, ')
          ..write('exercisesCompleted: $exercisesCompleted, ')
          ..write('breathingSessions: $breathingSessions, ')
          ..write('journalEntries: $journalEntries, ')
          ..write('waterGlasses: $waterGlasses, ')
          ..write('streakDay: $streakDay')
          ..write(')'))
        .toString();
  }
}

class $UserSettingsTable extends UserSettings
    with TableInfo<$UserSettingsTable, UserSetting> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UserSettingsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _onboardingCompleteMeta =
      const VerificationMeta('onboardingComplete');
  @override
  late final GeneratedColumn<bool> onboardingComplete = GeneratedColumn<bool>(
    'onboarding_complete',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("onboarding_complete" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _displayNameMeta = const VerificationMeta(
    'displayName',
  );
  @override
  late final GeneratedColumn<String> displayName = GeneratedColumn<String>(
    'display_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('there'),
  );
  static const VerificationMeta _goalsMeta = const VerificationMeta('goals');
  @override
  late final GeneratedColumn<String> goals = GeneratedColumn<String>(
    'goals',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _themeModeMeta = const VerificationMeta(
    'themeMode',
  );
  @override
  late final GeneratedColumn<String> themeMode = GeneratedColumn<String>(
    'theme_mode',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('system'),
  );
  static const VerificationMeta _languageCodeMeta = const VerificationMeta(
    'languageCode',
  );
  @override
  late final GeneratedColumn<String> languageCode = GeneratedColumn<String>(
    'language_code',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('en'),
  );
  static const VerificationMeta _notificationsEnabledMeta =
      const VerificationMeta('notificationsEnabled');
  @override
  late final GeneratedColumn<bool> notificationsEnabled = GeneratedColumn<bool>(
    'notifications_enabled',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("notifications_enabled" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _defaultReminderTimeMeta =
      const VerificationMeta('defaultReminderTime');
  @override
  late final GeneratedColumn<String> defaultReminderTime =
      GeneratedColumn<String>(
        'default_reminder_time',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: const Constant('10:00'),
      );
  static const VerificationMeta _dailyWaterGoalMeta = const VerificationMeta(
    'dailyWaterGoal',
  );
  @override
  late final GeneratedColumn<int> dailyWaterGoal = GeneratedColumn<int>(
    'daily_water_goal',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(8),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    onboardingComplete,
    displayName,
    goals,
    themeMode,
    languageCode,
    notificationsEnabled,
    defaultReminderTime,
    dailyWaterGoal,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'user_settings';
  @override
  VerificationContext validateIntegrity(
    Insertable<UserSetting> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('onboarding_complete')) {
      context.handle(
        _onboardingCompleteMeta,
        onboardingComplete.isAcceptableOrUnknown(
          data['onboarding_complete']!,
          _onboardingCompleteMeta,
        ),
      );
    }
    if (data.containsKey('display_name')) {
      context.handle(
        _displayNameMeta,
        displayName.isAcceptableOrUnknown(
          data['display_name']!,
          _displayNameMeta,
        ),
      );
    }
    if (data.containsKey('goals')) {
      context.handle(
        _goalsMeta,
        goals.isAcceptableOrUnknown(data['goals']!, _goalsMeta),
      );
    }
    if (data.containsKey('theme_mode')) {
      context.handle(
        _themeModeMeta,
        themeMode.isAcceptableOrUnknown(data['theme_mode']!, _themeModeMeta),
      );
    }
    if (data.containsKey('language_code')) {
      context.handle(
        _languageCodeMeta,
        languageCode.isAcceptableOrUnknown(
          data['language_code']!,
          _languageCodeMeta,
        ),
      );
    }
    if (data.containsKey('notifications_enabled')) {
      context.handle(
        _notificationsEnabledMeta,
        notificationsEnabled.isAcceptableOrUnknown(
          data['notifications_enabled']!,
          _notificationsEnabledMeta,
        ),
      );
    }
    if (data.containsKey('default_reminder_time')) {
      context.handle(
        _defaultReminderTimeMeta,
        defaultReminderTime.isAcceptableOrUnknown(
          data['default_reminder_time']!,
          _defaultReminderTimeMeta,
        ),
      );
    }
    if (data.containsKey('daily_water_goal')) {
      context.handle(
        _dailyWaterGoalMeta,
        dailyWaterGoal.isAcceptableOrUnknown(
          data['daily_water_goal']!,
          _dailyWaterGoalMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  UserSetting map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UserSetting(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      onboardingComplete: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}onboarding_complete'],
      )!,
      displayName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}display_name'],
      )!,
      goals: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}goals'],
      )!,
      themeMode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}theme_mode'],
      )!,
      languageCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}language_code'],
      )!,
      notificationsEnabled: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}notifications_enabled'],
      )!,
      defaultReminderTime: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}default_reminder_time'],
      )!,
      dailyWaterGoal: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}daily_water_goal'],
      )!,
    );
  }

  @override
  $UserSettingsTable createAlias(String alias) {
    return $UserSettingsTable(attachedDatabase, alias);
  }
}

class UserSetting extends DataClass implements Insertable<UserSetting> {
  final int id;
  final bool onboardingComplete;
  final String displayName;
  final String goals;
  final String themeMode;
  final String languageCode;
  final bool notificationsEnabled;
  final String defaultReminderTime;
  final int dailyWaterGoal;
  const UserSetting({
    required this.id,
    required this.onboardingComplete,
    required this.displayName,
    required this.goals,
    required this.themeMode,
    required this.languageCode,
    required this.notificationsEnabled,
    required this.defaultReminderTime,
    required this.dailyWaterGoal,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['onboarding_complete'] = Variable<bool>(onboardingComplete);
    map['display_name'] = Variable<String>(displayName);
    map['goals'] = Variable<String>(goals);
    map['theme_mode'] = Variable<String>(themeMode);
    map['language_code'] = Variable<String>(languageCode);
    map['notifications_enabled'] = Variable<bool>(notificationsEnabled);
    map['default_reminder_time'] = Variable<String>(defaultReminderTime);
    map['daily_water_goal'] = Variable<int>(dailyWaterGoal);
    return map;
  }

  UserSettingsCompanion toCompanion(bool nullToAbsent) {
    return UserSettingsCompanion(
      id: Value(id),
      onboardingComplete: Value(onboardingComplete),
      displayName: Value(displayName),
      goals: Value(goals),
      themeMode: Value(themeMode),
      languageCode: Value(languageCode),
      notificationsEnabled: Value(notificationsEnabled),
      defaultReminderTime: Value(defaultReminderTime),
      dailyWaterGoal: Value(dailyWaterGoal),
    );
  }

  factory UserSetting.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UserSetting(
      id: serializer.fromJson<int>(json['id']),
      onboardingComplete: serializer.fromJson<bool>(json['onboardingComplete']),
      displayName: serializer.fromJson<String>(json['displayName']),
      goals: serializer.fromJson<String>(json['goals']),
      themeMode: serializer.fromJson<String>(json['themeMode']),
      languageCode: serializer.fromJson<String>(json['languageCode']),
      notificationsEnabled: serializer.fromJson<bool>(
        json['notificationsEnabled'],
      ),
      defaultReminderTime: serializer.fromJson<String>(
        json['defaultReminderTime'],
      ),
      dailyWaterGoal: serializer.fromJson<int>(json['dailyWaterGoal']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'onboardingComplete': serializer.toJson<bool>(onboardingComplete),
      'displayName': serializer.toJson<String>(displayName),
      'goals': serializer.toJson<String>(goals),
      'themeMode': serializer.toJson<String>(themeMode),
      'languageCode': serializer.toJson<String>(languageCode),
      'notificationsEnabled': serializer.toJson<bool>(notificationsEnabled),
      'defaultReminderTime': serializer.toJson<String>(defaultReminderTime),
      'dailyWaterGoal': serializer.toJson<int>(dailyWaterGoal),
    };
  }

  UserSetting copyWith({
    int? id,
    bool? onboardingComplete,
    String? displayName,
    String? goals,
    String? themeMode,
    String? languageCode,
    bool? notificationsEnabled,
    String? defaultReminderTime,
    int? dailyWaterGoal,
  }) => UserSetting(
    id: id ?? this.id,
    onboardingComplete: onboardingComplete ?? this.onboardingComplete,
    displayName: displayName ?? this.displayName,
    goals: goals ?? this.goals,
    themeMode: themeMode ?? this.themeMode,
    languageCode: languageCode ?? this.languageCode,
    notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
    defaultReminderTime: defaultReminderTime ?? this.defaultReminderTime,
    dailyWaterGoal: dailyWaterGoal ?? this.dailyWaterGoal,
  );
  UserSetting copyWithCompanion(UserSettingsCompanion data) {
    return UserSetting(
      id: data.id.present ? data.id.value : this.id,
      onboardingComplete: data.onboardingComplete.present
          ? data.onboardingComplete.value
          : this.onboardingComplete,
      displayName: data.displayName.present
          ? data.displayName.value
          : this.displayName,
      goals: data.goals.present ? data.goals.value : this.goals,
      themeMode: data.themeMode.present ? data.themeMode.value : this.themeMode,
      languageCode: data.languageCode.present
          ? data.languageCode.value
          : this.languageCode,
      notificationsEnabled: data.notificationsEnabled.present
          ? data.notificationsEnabled.value
          : this.notificationsEnabled,
      defaultReminderTime: data.defaultReminderTime.present
          ? data.defaultReminderTime.value
          : this.defaultReminderTime,
      dailyWaterGoal: data.dailyWaterGoal.present
          ? data.dailyWaterGoal.value
          : this.dailyWaterGoal,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UserSetting(')
          ..write('id: $id, ')
          ..write('onboardingComplete: $onboardingComplete, ')
          ..write('displayName: $displayName, ')
          ..write('goals: $goals, ')
          ..write('themeMode: $themeMode, ')
          ..write('languageCode: $languageCode, ')
          ..write('notificationsEnabled: $notificationsEnabled, ')
          ..write('defaultReminderTime: $defaultReminderTime, ')
          ..write('dailyWaterGoal: $dailyWaterGoal')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    onboardingComplete,
    displayName,
    goals,
    themeMode,
    languageCode,
    notificationsEnabled,
    defaultReminderTime,
    dailyWaterGoal,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserSetting &&
          other.id == this.id &&
          other.onboardingComplete == this.onboardingComplete &&
          other.displayName == this.displayName &&
          other.goals == this.goals &&
          other.themeMode == this.themeMode &&
          other.languageCode == this.languageCode &&
          other.notificationsEnabled == this.notificationsEnabled &&
          other.defaultReminderTime == this.defaultReminderTime &&
          other.dailyWaterGoal == this.dailyWaterGoal);
}

class UserSettingsCompanion extends UpdateCompanion<UserSetting> {
  final Value<int> id;
  final Value<bool> onboardingComplete;
  final Value<String> displayName;
  final Value<String> goals;
  final Value<String> themeMode;
  final Value<String> languageCode;
  final Value<bool> notificationsEnabled;
  final Value<String> defaultReminderTime;
  final Value<int> dailyWaterGoal;
  const UserSettingsCompanion({
    this.id = const Value.absent(),
    this.onboardingComplete = const Value.absent(),
    this.displayName = const Value.absent(),
    this.goals = const Value.absent(),
    this.themeMode = const Value.absent(),
    this.languageCode = const Value.absent(),
    this.notificationsEnabled = const Value.absent(),
    this.defaultReminderTime = const Value.absent(),
    this.dailyWaterGoal = const Value.absent(),
  });
  UserSettingsCompanion.insert({
    this.id = const Value.absent(),
    this.onboardingComplete = const Value.absent(),
    this.displayName = const Value.absent(),
    this.goals = const Value.absent(),
    this.themeMode = const Value.absent(),
    this.languageCode = const Value.absent(),
    this.notificationsEnabled = const Value.absent(),
    this.defaultReminderTime = const Value.absent(),
    this.dailyWaterGoal = const Value.absent(),
  });
  static Insertable<UserSetting> custom({
    Expression<int>? id,
    Expression<bool>? onboardingComplete,
    Expression<String>? displayName,
    Expression<String>? goals,
    Expression<String>? themeMode,
    Expression<String>? languageCode,
    Expression<bool>? notificationsEnabled,
    Expression<String>? defaultReminderTime,
    Expression<int>? dailyWaterGoal,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (onboardingComplete != null) 'onboarding_complete': onboardingComplete,
      if (displayName != null) 'display_name': displayName,
      if (goals != null) 'goals': goals,
      if (themeMode != null) 'theme_mode': themeMode,
      if (languageCode != null) 'language_code': languageCode,
      if (notificationsEnabled != null)
        'notifications_enabled': notificationsEnabled,
      if (defaultReminderTime != null)
        'default_reminder_time': defaultReminderTime,
      if (dailyWaterGoal != null) 'daily_water_goal': dailyWaterGoal,
    });
  }

  UserSettingsCompanion copyWith({
    Value<int>? id,
    Value<bool>? onboardingComplete,
    Value<String>? displayName,
    Value<String>? goals,
    Value<String>? themeMode,
    Value<String>? languageCode,
    Value<bool>? notificationsEnabled,
    Value<String>? defaultReminderTime,
    Value<int>? dailyWaterGoal,
  }) {
    return UserSettingsCompanion(
      id: id ?? this.id,
      onboardingComplete: onboardingComplete ?? this.onboardingComplete,
      displayName: displayName ?? this.displayName,
      goals: goals ?? this.goals,
      themeMode: themeMode ?? this.themeMode,
      languageCode: languageCode ?? this.languageCode,
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
      defaultReminderTime: defaultReminderTime ?? this.defaultReminderTime,
      dailyWaterGoal: dailyWaterGoal ?? this.dailyWaterGoal,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (onboardingComplete.present) {
      map['onboarding_complete'] = Variable<bool>(onboardingComplete.value);
    }
    if (displayName.present) {
      map['display_name'] = Variable<String>(displayName.value);
    }
    if (goals.present) {
      map['goals'] = Variable<String>(goals.value);
    }
    if (themeMode.present) {
      map['theme_mode'] = Variable<String>(themeMode.value);
    }
    if (languageCode.present) {
      map['language_code'] = Variable<String>(languageCode.value);
    }
    if (notificationsEnabled.present) {
      map['notifications_enabled'] = Variable<bool>(notificationsEnabled.value);
    }
    if (defaultReminderTime.present) {
      map['default_reminder_time'] = Variable<String>(
        defaultReminderTime.value,
      );
    }
    if (dailyWaterGoal.present) {
      map['daily_water_goal'] = Variable<int>(dailyWaterGoal.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UserSettingsCompanion(')
          ..write('id: $id, ')
          ..write('onboardingComplete: $onboardingComplete, ')
          ..write('displayName: $displayName, ')
          ..write('goals: $goals, ')
          ..write('themeMode: $themeMode, ')
          ..write('languageCode: $languageCode, ')
          ..write('notificationsEnabled: $notificationsEnabled, ')
          ..write('defaultReminderTime: $defaultReminderTime, ')
          ..write('dailyWaterGoal: $dailyWaterGoal')
          ..write(')'))
        .toString();
  }
}

class $WaterTrackingsTable extends WaterTrackings
    with TableInfo<$WaterTrackingsTable, WaterTracking> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WaterTrackingsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _glassesMeta = const VerificationMeta(
    'glasses',
  );
  @override
  late final GeneratedColumn<int> glasses = GeneratedColumn<int>(
    'glasses',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [id, date, glasses];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'water_trackings';
  @override
  VerificationContext validateIntegrity(
    Insertable<WaterTracking> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('glasses')) {
      context.handle(
        _glassesMeta,
        glasses.isAcceptableOrUnknown(data['glasses']!, _glassesMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  WaterTracking map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WaterTracking(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date'],
      )!,
      glasses: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}glasses'],
      )!,
    );
  }

  @override
  $WaterTrackingsTable createAlias(String alias) {
    return $WaterTrackingsTable(attachedDatabase, alias);
  }
}

class WaterTracking extends DataClass implements Insertable<WaterTracking> {
  final int id;
  final DateTime date;
  final int glasses;
  const WaterTracking({
    required this.id,
    required this.date,
    required this.glasses,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['date'] = Variable<DateTime>(date);
    map['glasses'] = Variable<int>(glasses);
    return map;
  }

  WaterTrackingsCompanion toCompanion(bool nullToAbsent) {
    return WaterTrackingsCompanion(
      id: Value(id),
      date: Value(date),
      glasses: Value(glasses),
    );
  }

  factory WaterTracking.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WaterTracking(
      id: serializer.fromJson<int>(json['id']),
      date: serializer.fromJson<DateTime>(json['date']),
      glasses: serializer.fromJson<int>(json['glasses']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'date': serializer.toJson<DateTime>(date),
      'glasses': serializer.toJson<int>(glasses),
    };
  }

  WaterTracking copyWith({int? id, DateTime? date, int? glasses}) =>
      WaterTracking(
        id: id ?? this.id,
        date: date ?? this.date,
        glasses: glasses ?? this.glasses,
      );
  WaterTracking copyWithCompanion(WaterTrackingsCompanion data) {
    return WaterTracking(
      id: data.id.present ? data.id.value : this.id,
      date: data.date.present ? data.date.value : this.date,
      glasses: data.glasses.present ? data.glasses.value : this.glasses,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WaterTracking(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('glasses: $glasses')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, date, glasses);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WaterTracking &&
          other.id == this.id &&
          other.date == this.date &&
          other.glasses == this.glasses);
}

class WaterTrackingsCompanion extends UpdateCompanion<WaterTracking> {
  final Value<int> id;
  final Value<DateTime> date;
  final Value<int> glasses;
  const WaterTrackingsCompanion({
    this.id = const Value.absent(),
    this.date = const Value.absent(),
    this.glasses = const Value.absent(),
  });
  WaterTrackingsCompanion.insert({
    this.id = const Value.absent(),
    required DateTime date,
    this.glasses = const Value.absent(),
  }) : date = Value(date);
  static Insertable<WaterTracking> custom({
    Expression<int>? id,
    Expression<DateTime>? date,
    Expression<int>? glasses,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (date != null) 'date': date,
      if (glasses != null) 'glasses': glasses,
    });
  }

  WaterTrackingsCompanion copyWith({
    Value<int>? id,
    Value<DateTime>? date,
    Value<int>? glasses,
  }) {
    return WaterTrackingsCompanion(
      id: id ?? this.id,
      date: date ?? this.date,
      glasses: glasses ?? this.glasses,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (glasses.present) {
      map['glasses'] = Variable<int>(glasses.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WaterTrackingsCompanion(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('glasses: $glasses')
          ..write(')'))
        .toString();
  }
}

class $BreathingHistoriesTable extends BreathingHistories
    with TableInfo<$BreathingHistoriesTable, BreathingHistory> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BreathingHistoriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _patternMeta = const VerificationMeta(
    'pattern',
  );
  @override
  late final GeneratedColumn<String> pattern = GeneratedColumn<String>(
    'pattern',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _durationSecondsMeta = const VerificationMeta(
    'durationSeconds',
  );
  @override
  late final GeneratedColumn<int> durationSeconds = GeneratedColumn<int>(
    'duration_seconds',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _completedAtMeta = const VerificationMeta(
    'completedAt',
  );
  @override
  late final GeneratedColumn<DateTime> completedAt = GeneratedColumn<DateTime>(
    'completed_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    pattern,
    durationSeconds,
    completedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'breathing_histories';
  @override
  VerificationContext validateIntegrity(
    Insertable<BreathingHistory> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('pattern')) {
      context.handle(
        _patternMeta,
        pattern.isAcceptableOrUnknown(data['pattern']!, _patternMeta),
      );
    } else if (isInserting) {
      context.missing(_patternMeta);
    }
    if (data.containsKey('duration_seconds')) {
      context.handle(
        _durationSecondsMeta,
        durationSeconds.isAcceptableOrUnknown(
          data['duration_seconds']!,
          _durationSecondsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_durationSecondsMeta);
    }
    if (data.containsKey('completed_at')) {
      context.handle(
        _completedAtMeta,
        completedAt.isAcceptableOrUnknown(
          data['completed_at']!,
          _completedAtMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  BreathingHistory map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BreathingHistory(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      pattern: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}pattern'],
      )!,
      durationSeconds: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}duration_seconds'],
      )!,
      completedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}completed_at'],
      )!,
    );
  }

  @override
  $BreathingHistoriesTable createAlias(String alias) {
    return $BreathingHistoriesTable(attachedDatabase, alias);
  }
}

class BreathingHistory extends DataClass
    implements Insertable<BreathingHistory> {
  final int id;
  final String pattern;
  final int durationSeconds;
  final DateTime completedAt;
  const BreathingHistory({
    required this.id,
    required this.pattern,
    required this.durationSeconds,
    required this.completedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['pattern'] = Variable<String>(pattern);
    map['duration_seconds'] = Variable<int>(durationSeconds);
    map['completed_at'] = Variable<DateTime>(completedAt);
    return map;
  }

  BreathingHistoriesCompanion toCompanion(bool nullToAbsent) {
    return BreathingHistoriesCompanion(
      id: Value(id),
      pattern: Value(pattern),
      durationSeconds: Value(durationSeconds),
      completedAt: Value(completedAt),
    );
  }

  factory BreathingHistory.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BreathingHistory(
      id: serializer.fromJson<int>(json['id']),
      pattern: serializer.fromJson<String>(json['pattern']),
      durationSeconds: serializer.fromJson<int>(json['durationSeconds']),
      completedAt: serializer.fromJson<DateTime>(json['completedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'pattern': serializer.toJson<String>(pattern),
      'durationSeconds': serializer.toJson<int>(durationSeconds),
      'completedAt': serializer.toJson<DateTime>(completedAt),
    };
  }

  BreathingHistory copyWith({
    int? id,
    String? pattern,
    int? durationSeconds,
    DateTime? completedAt,
  }) => BreathingHistory(
    id: id ?? this.id,
    pattern: pattern ?? this.pattern,
    durationSeconds: durationSeconds ?? this.durationSeconds,
    completedAt: completedAt ?? this.completedAt,
  );
  BreathingHistory copyWithCompanion(BreathingHistoriesCompanion data) {
    return BreathingHistory(
      id: data.id.present ? data.id.value : this.id,
      pattern: data.pattern.present ? data.pattern.value : this.pattern,
      durationSeconds: data.durationSeconds.present
          ? data.durationSeconds.value
          : this.durationSeconds,
      completedAt: data.completedAt.present
          ? data.completedAt.value
          : this.completedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BreathingHistory(')
          ..write('id: $id, ')
          ..write('pattern: $pattern, ')
          ..write('durationSeconds: $durationSeconds, ')
          ..write('completedAt: $completedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, pattern, durationSeconds, completedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BreathingHistory &&
          other.id == this.id &&
          other.pattern == this.pattern &&
          other.durationSeconds == this.durationSeconds &&
          other.completedAt == this.completedAt);
}

class BreathingHistoriesCompanion extends UpdateCompanion<BreathingHistory> {
  final Value<int> id;
  final Value<String> pattern;
  final Value<int> durationSeconds;
  final Value<DateTime> completedAt;
  const BreathingHistoriesCompanion({
    this.id = const Value.absent(),
    this.pattern = const Value.absent(),
    this.durationSeconds = const Value.absent(),
    this.completedAt = const Value.absent(),
  });
  BreathingHistoriesCompanion.insert({
    this.id = const Value.absent(),
    required String pattern,
    required int durationSeconds,
    this.completedAt = const Value.absent(),
  }) : pattern = Value(pattern),
       durationSeconds = Value(durationSeconds);
  static Insertable<BreathingHistory> custom({
    Expression<int>? id,
    Expression<String>? pattern,
    Expression<int>? durationSeconds,
    Expression<DateTime>? completedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (pattern != null) 'pattern': pattern,
      if (durationSeconds != null) 'duration_seconds': durationSeconds,
      if (completedAt != null) 'completed_at': completedAt,
    });
  }

  BreathingHistoriesCompanion copyWith({
    Value<int>? id,
    Value<String>? pattern,
    Value<int>? durationSeconds,
    Value<DateTime>? completedAt,
  }) {
    return BreathingHistoriesCompanion(
      id: id ?? this.id,
      pattern: pattern ?? this.pattern,
      durationSeconds: durationSeconds ?? this.durationSeconds,
      completedAt: completedAt ?? this.completedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (pattern.present) {
      map['pattern'] = Variable<String>(pattern.value);
    }
    if (durationSeconds.present) {
      map['duration_seconds'] = Variable<int>(durationSeconds.value);
    }
    if (completedAt.present) {
      map['completed_at'] = Variable<DateTime>(completedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BreathingHistoriesCompanion(')
          ..write('id: $id, ')
          ..write('pattern: $pattern, ')
          ..write('durationSeconds: $durationSeconds, ')
          ..write('completedAt: $completedAt')
          ..write(')'))
        .toString();
  }
}

class $FavoritesTable extends Favorites
    with TableInfo<$FavoritesTable, Favorite> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FavoritesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _entityTypeMeta = const VerificationMeta(
    'entityType',
  );
  @override
  late final GeneratedColumn<String> entityType = GeneratedColumn<String>(
    'entity_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _entityIdMeta = const VerificationMeta(
    'entityId',
  );
  @override
  late final GeneratedColumn<int> entityId = GeneratedColumn<int>(
    'entity_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, entityType, entityId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'favorites';
  @override
  VerificationContext validateIntegrity(
    Insertable<Favorite> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('entity_type')) {
      context.handle(
        _entityTypeMeta,
        entityType.isAcceptableOrUnknown(data['entity_type']!, _entityTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_entityTypeMeta);
    }
    if (data.containsKey('entity_id')) {
      context.handle(
        _entityIdMeta,
        entityId.isAcceptableOrUnknown(data['entity_id']!, _entityIdMeta),
      );
    } else if (isInserting) {
      context.missing(_entityIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Favorite map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Favorite(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      entityType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}entity_type'],
      )!,
      entityId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}entity_id'],
      )!,
    );
  }

  @override
  $FavoritesTable createAlias(String alias) {
    return $FavoritesTable(attachedDatabase, alias);
  }
}

class Favorite extends DataClass implements Insertable<Favorite> {
  final int id;
  final String entityType;
  final int entityId;
  const Favorite({
    required this.id,
    required this.entityType,
    required this.entityId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['entity_type'] = Variable<String>(entityType);
    map['entity_id'] = Variable<int>(entityId);
    return map;
  }

  FavoritesCompanion toCompanion(bool nullToAbsent) {
    return FavoritesCompanion(
      id: Value(id),
      entityType: Value(entityType),
      entityId: Value(entityId),
    );
  }

  factory Favorite.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Favorite(
      id: serializer.fromJson<int>(json['id']),
      entityType: serializer.fromJson<String>(json['entityType']),
      entityId: serializer.fromJson<int>(json['entityId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'entityType': serializer.toJson<String>(entityType),
      'entityId': serializer.toJson<int>(entityId),
    };
  }

  Favorite copyWith({int? id, String? entityType, int? entityId}) => Favorite(
    id: id ?? this.id,
    entityType: entityType ?? this.entityType,
    entityId: entityId ?? this.entityId,
  );
  Favorite copyWithCompanion(FavoritesCompanion data) {
    return Favorite(
      id: data.id.present ? data.id.value : this.id,
      entityType: data.entityType.present
          ? data.entityType.value
          : this.entityType,
      entityId: data.entityId.present ? data.entityId.value : this.entityId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Favorite(')
          ..write('id: $id, ')
          ..write('entityType: $entityType, ')
          ..write('entityId: $entityId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, entityType, entityId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Favorite &&
          other.id == this.id &&
          other.entityType == this.entityType &&
          other.entityId == this.entityId);
}

class FavoritesCompanion extends UpdateCompanion<Favorite> {
  final Value<int> id;
  final Value<String> entityType;
  final Value<int> entityId;
  const FavoritesCompanion({
    this.id = const Value.absent(),
    this.entityType = const Value.absent(),
    this.entityId = const Value.absent(),
  });
  FavoritesCompanion.insert({
    this.id = const Value.absent(),
    required String entityType,
    required int entityId,
  }) : entityType = Value(entityType),
       entityId = Value(entityId);
  static Insertable<Favorite> custom({
    Expression<int>? id,
    Expression<String>? entityType,
    Expression<int>? entityId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (entityType != null) 'entity_type': entityType,
      if (entityId != null) 'entity_id': entityId,
    });
  }

  FavoritesCompanion copyWith({
    Value<int>? id,
    Value<String>? entityType,
    Value<int>? entityId,
  }) {
    return FavoritesCompanion(
      id: id ?? this.id,
      entityType: entityType ?? this.entityType,
      entityId: entityId ?? this.entityId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (entityType.present) {
      map['entity_type'] = Variable<String>(entityType.value);
    }
    if (entityId.present) {
      map['entity_id'] = Variable<int>(entityId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FavoritesCompanion(')
          ..write('id: $id, ')
          ..write('entityType: $entityType, ')
          ..write('entityId: $entityId')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $ExerciseCategoriesTable exerciseCategories =
      $ExerciseCategoriesTable(this);
  late final $ExercisesTable exercises = $ExercisesTable(this);
  late final $ExerciseHistoriesTable exerciseHistories =
      $ExerciseHistoriesTable(this);
  late final $AffirmationsTable affirmations = $AffirmationsTable(this);
  late final $MoodsTable moods = $MoodsTable(this);
  late final $JournalEntriesTable journalEntries = $JournalEntriesTable(this);
  late final $RemindersTable reminders = $RemindersTable(this);
  late final $AchievementsTable achievements = $AchievementsTable(this);
  late final $DailyProgressesTable dailyProgresses = $DailyProgressesTable(
    this,
  );
  late final $UserSettingsTable userSettings = $UserSettingsTable(this);
  late final $WaterTrackingsTable waterTrackings = $WaterTrackingsTable(this);
  late final $BreathingHistoriesTable breathingHistories =
      $BreathingHistoriesTable(this);
  late final $FavoritesTable favorites = $FavoritesTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    exerciseCategories,
    exercises,
    exerciseHistories,
    affirmations,
    moods,
    journalEntries,
    reminders,
    achievements,
    dailyProgresses,
    userSettings,
    waterTrackings,
    breathingHistories,
    favorites,
  ];
}

typedef $$ExerciseCategoriesTableCreateCompanionBuilder =
    ExerciseCategoriesCompanion Function({
      Value<int> id,
      required String slug,
      required String name,
      Value<String> icon,
      Value<int> sortOrder,
    });
typedef $$ExerciseCategoriesTableUpdateCompanionBuilder =
    ExerciseCategoriesCompanion Function({
      Value<int> id,
      Value<String> slug,
      Value<String> name,
      Value<String> icon,
      Value<int> sortOrder,
    });

final class $$ExerciseCategoriesTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $ExerciseCategoriesTable,
          ExerciseCategory
        > {
  $$ExerciseCategoriesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<$ExercisesTable, List<Exercise>>
  _exercisesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.exercises,
    aliasName: $_aliasNameGenerator(
      db.exerciseCategories.id,
      db.exercises.categoryId,
    ),
  );

  $$ExercisesTableProcessedTableManager get exercisesRefs {
    final manager = $$ExercisesTableTableManager(
      $_db,
      $_db.exercises,
    ).filter((f) => f.categoryId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_exercisesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$ExerciseCategoriesTableFilterComposer
    extends Composer<_$AppDatabase, $ExerciseCategoriesTable> {
  $$ExerciseCategoriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get slug => $composableBuilder(
    column: $table.slug,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get icon => $composableBuilder(
    column: $table.icon,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> exercisesRefs(
    Expression<bool> Function($$ExercisesTableFilterComposer f) f,
  ) {
    final $$ExercisesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.exercises,
      getReferencedColumn: (t) => t.categoryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ExercisesTableFilterComposer(
            $db: $db,
            $table: $db.exercises,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ExerciseCategoriesTableOrderingComposer
    extends Composer<_$AppDatabase, $ExerciseCategoriesTable> {
  $$ExerciseCategoriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get slug => $composableBuilder(
    column: $table.slug,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get icon => $composableBuilder(
    column: $table.icon,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ExerciseCategoriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ExerciseCategoriesTable> {
  $$ExerciseCategoriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get slug =>
      $composableBuilder(column: $table.slug, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get icon =>
      $composableBuilder(column: $table.icon, builder: (column) => column);

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  Expression<T> exercisesRefs<T extends Object>(
    Expression<T> Function($$ExercisesTableAnnotationComposer a) f,
  ) {
    final $$ExercisesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.exercises,
      getReferencedColumn: (t) => t.categoryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ExercisesTableAnnotationComposer(
            $db: $db,
            $table: $db.exercises,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ExerciseCategoriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ExerciseCategoriesTable,
          ExerciseCategory,
          $$ExerciseCategoriesTableFilterComposer,
          $$ExerciseCategoriesTableOrderingComposer,
          $$ExerciseCategoriesTableAnnotationComposer,
          $$ExerciseCategoriesTableCreateCompanionBuilder,
          $$ExerciseCategoriesTableUpdateCompanionBuilder,
          (ExerciseCategory, $$ExerciseCategoriesTableReferences),
          ExerciseCategory,
          PrefetchHooks Function({bool exercisesRefs})
        > {
  $$ExerciseCategoriesTableTableManager(
    _$AppDatabase db,
    $ExerciseCategoriesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ExerciseCategoriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ExerciseCategoriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ExerciseCategoriesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> slug = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> icon = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
              }) => ExerciseCategoriesCompanion(
                id: id,
                slug: slug,
                name: name,
                icon: icon,
                sortOrder: sortOrder,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String slug,
                required String name,
                Value<String> icon = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
              }) => ExerciseCategoriesCompanion.insert(
                id: id,
                slug: slug,
                name: name,
                icon: icon,
                sortOrder: sortOrder,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ExerciseCategoriesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({exercisesRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (exercisesRefs) db.exercises],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (exercisesRefs)
                    await $_getPrefetchedData<
                      ExerciseCategory,
                      $ExerciseCategoriesTable,
                      Exercise
                    >(
                      currentTable: table,
                      referencedTable: $$ExerciseCategoriesTableReferences
                          ._exercisesRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$ExerciseCategoriesTableReferences(
                            db,
                            table,
                            p0,
                          ).exercisesRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.categoryId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$ExerciseCategoriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ExerciseCategoriesTable,
      ExerciseCategory,
      $$ExerciseCategoriesTableFilterComposer,
      $$ExerciseCategoriesTableOrderingComposer,
      $$ExerciseCategoriesTableAnnotationComposer,
      $$ExerciseCategoriesTableCreateCompanionBuilder,
      $$ExerciseCategoriesTableUpdateCompanionBuilder,
      (ExerciseCategory, $$ExerciseCategoriesTableReferences),
      ExerciseCategory,
      PrefetchHooks Function({bool exercisesRefs})
    >;
typedef $$ExercisesTableCreateCompanionBuilder =
    ExercisesCompanion Function({
      Value<int> id,
      required String slug,
      required String title,
      required int categoryId,
      required int durationSeconds,
      required String difficulty,
      Value<String?> animationAsset,
      required String description,
      required String instructions,
      required String benefits,
      required String targetMuscles,
      Value<int> caloriesEstimate,
      Value<bool> isFavorite,
    });
typedef $$ExercisesTableUpdateCompanionBuilder =
    ExercisesCompanion Function({
      Value<int> id,
      Value<String> slug,
      Value<String> title,
      Value<int> categoryId,
      Value<int> durationSeconds,
      Value<String> difficulty,
      Value<String?> animationAsset,
      Value<String> description,
      Value<String> instructions,
      Value<String> benefits,
      Value<String> targetMuscles,
      Value<int> caloriesEstimate,
      Value<bool> isFavorite,
    });

final class $$ExercisesTableReferences
    extends BaseReferences<_$AppDatabase, $ExercisesTable, Exercise> {
  $$ExercisesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ExerciseCategoriesTable _categoryIdTable(_$AppDatabase db) =>
      db.exerciseCategories.createAlias(
        $_aliasNameGenerator(db.exercises.categoryId, db.exerciseCategories.id),
      );

  $$ExerciseCategoriesTableProcessedTableManager get categoryId {
    final $_column = $_itemColumn<int>('category_id')!;

    final manager = $$ExerciseCategoriesTableTableManager(
      $_db,
      $_db.exerciseCategories,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_categoryIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$ExerciseHistoriesTable, List<ExerciseHistory>>
  _exerciseHistoriesRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.exerciseHistories,
        aliasName: $_aliasNameGenerator(
          db.exercises.id,
          db.exerciseHistories.exerciseId,
        ),
      );

  $$ExerciseHistoriesTableProcessedTableManager get exerciseHistoriesRefs {
    final manager = $$ExerciseHistoriesTableTableManager(
      $_db,
      $_db.exerciseHistories,
    ).filter((f) => f.exerciseId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _exerciseHistoriesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$ExercisesTableFilterComposer
    extends Composer<_$AppDatabase, $ExercisesTable> {
  $$ExercisesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get slug => $composableBuilder(
    column: $table.slug,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get durationSeconds => $composableBuilder(
    column: $table.durationSeconds,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get difficulty => $composableBuilder(
    column: $table.difficulty,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get animationAsset => $composableBuilder(
    column: $table.animationAsset,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get instructions => $composableBuilder(
    column: $table.instructions,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get benefits => $composableBuilder(
    column: $table.benefits,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get targetMuscles => $composableBuilder(
    column: $table.targetMuscles,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get caloriesEstimate => $composableBuilder(
    column: $table.caloriesEstimate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isFavorite => $composableBuilder(
    column: $table.isFavorite,
    builder: (column) => ColumnFilters(column),
  );

  $$ExerciseCategoriesTableFilterComposer get categoryId {
    final $$ExerciseCategoriesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.categoryId,
      referencedTable: $db.exerciseCategories,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ExerciseCategoriesTableFilterComposer(
            $db: $db,
            $table: $db.exerciseCategories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> exerciseHistoriesRefs(
    Expression<bool> Function($$ExerciseHistoriesTableFilterComposer f) f,
  ) {
    final $$ExerciseHistoriesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.exerciseHistories,
      getReferencedColumn: (t) => t.exerciseId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ExerciseHistoriesTableFilterComposer(
            $db: $db,
            $table: $db.exerciseHistories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ExercisesTableOrderingComposer
    extends Composer<_$AppDatabase, $ExercisesTable> {
  $$ExercisesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get slug => $composableBuilder(
    column: $table.slug,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get durationSeconds => $composableBuilder(
    column: $table.durationSeconds,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get difficulty => $composableBuilder(
    column: $table.difficulty,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get animationAsset => $composableBuilder(
    column: $table.animationAsset,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get instructions => $composableBuilder(
    column: $table.instructions,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get benefits => $composableBuilder(
    column: $table.benefits,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get targetMuscles => $composableBuilder(
    column: $table.targetMuscles,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get caloriesEstimate => $composableBuilder(
    column: $table.caloriesEstimate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isFavorite => $composableBuilder(
    column: $table.isFavorite,
    builder: (column) => ColumnOrderings(column),
  );

  $$ExerciseCategoriesTableOrderingComposer get categoryId {
    final $$ExerciseCategoriesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.categoryId,
      referencedTable: $db.exerciseCategories,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ExerciseCategoriesTableOrderingComposer(
            $db: $db,
            $table: $db.exerciseCategories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ExercisesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ExercisesTable> {
  $$ExercisesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get slug =>
      $composableBuilder(column: $table.slug, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<int> get durationSeconds => $composableBuilder(
    column: $table.durationSeconds,
    builder: (column) => column,
  );

  GeneratedColumn<String> get difficulty => $composableBuilder(
    column: $table.difficulty,
    builder: (column) => column,
  );

  GeneratedColumn<String> get animationAsset => $composableBuilder(
    column: $table.animationAsset,
    builder: (column) => column,
  );

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<String> get instructions => $composableBuilder(
    column: $table.instructions,
    builder: (column) => column,
  );

  GeneratedColumn<String> get benefits =>
      $composableBuilder(column: $table.benefits, builder: (column) => column);

  GeneratedColumn<String> get targetMuscles => $composableBuilder(
    column: $table.targetMuscles,
    builder: (column) => column,
  );

  GeneratedColumn<int> get caloriesEstimate => $composableBuilder(
    column: $table.caloriesEstimate,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isFavorite => $composableBuilder(
    column: $table.isFavorite,
    builder: (column) => column,
  );

  $$ExerciseCategoriesTableAnnotationComposer get categoryId {
    final $$ExerciseCategoriesTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.categoryId,
          referencedTable: $db.exerciseCategories,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$ExerciseCategoriesTableAnnotationComposer(
                $db: $db,
                $table: $db.exerciseCategories,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }

  Expression<T> exerciseHistoriesRefs<T extends Object>(
    Expression<T> Function($$ExerciseHistoriesTableAnnotationComposer a) f,
  ) {
    final $$ExerciseHistoriesTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.exerciseHistories,
          getReferencedColumn: (t) => t.exerciseId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$ExerciseHistoriesTableAnnotationComposer(
                $db: $db,
                $table: $db.exerciseHistories,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$ExercisesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ExercisesTable,
          Exercise,
          $$ExercisesTableFilterComposer,
          $$ExercisesTableOrderingComposer,
          $$ExercisesTableAnnotationComposer,
          $$ExercisesTableCreateCompanionBuilder,
          $$ExercisesTableUpdateCompanionBuilder,
          (Exercise, $$ExercisesTableReferences),
          Exercise,
          PrefetchHooks Function({bool categoryId, bool exerciseHistoriesRefs})
        > {
  $$ExercisesTableTableManager(_$AppDatabase db, $ExercisesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ExercisesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ExercisesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ExercisesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> slug = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<int> categoryId = const Value.absent(),
                Value<int> durationSeconds = const Value.absent(),
                Value<String> difficulty = const Value.absent(),
                Value<String?> animationAsset = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<String> instructions = const Value.absent(),
                Value<String> benefits = const Value.absent(),
                Value<String> targetMuscles = const Value.absent(),
                Value<int> caloriesEstimate = const Value.absent(),
                Value<bool> isFavorite = const Value.absent(),
              }) => ExercisesCompanion(
                id: id,
                slug: slug,
                title: title,
                categoryId: categoryId,
                durationSeconds: durationSeconds,
                difficulty: difficulty,
                animationAsset: animationAsset,
                description: description,
                instructions: instructions,
                benefits: benefits,
                targetMuscles: targetMuscles,
                caloriesEstimate: caloriesEstimate,
                isFavorite: isFavorite,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String slug,
                required String title,
                required int categoryId,
                required int durationSeconds,
                required String difficulty,
                Value<String?> animationAsset = const Value.absent(),
                required String description,
                required String instructions,
                required String benefits,
                required String targetMuscles,
                Value<int> caloriesEstimate = const Value.absent(),
                Value<bool> isFavorite = const Value.absent(),
              }) => ExercisesCompanion.insert(
                id: id,
                slug: slug,
                title: title,
                categoryId: categoryId,
                durationSeconds: durationSeconds,
                difficulty: difficulty,
                animationAsset: animationAsset,
                description: description,
                instructions: instructions,
                benefits: benefits,
                targetMuscles: targetMuscles,
                caloriesEstimate: caloriesEstimate,
                isFavorite: isFavorite,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ExercisesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({categoryId = false, exerciseHistoriesRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (exerciseHistoriesRefs) db.exerciseHistories,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (categoryId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.categoryId,
                                    referencedTable: $$ExercisesTableReferences
                                        ._categoryIdTable(db),
                                    referencedColumn: $$ExercisesTableReferences
                                        ._categoryIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (exerciseHistoriesRefs)
                        await $_getPrefetchedData<
                          Exercise,
                          $ExercisesTable,
                          ExerciseHistory
                        >(
                          currentTable: table,
                          referencedTable: $$ExercisesTableReferences
                              ._exerciseHistoriesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ExercisesTableReferences(
                                db,
                                table,
                                p0,
                              ).exerciseHistoriesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.exerciseId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$ExercisesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ExercisesTable,
      Exercise,
      $$ExercisesTableFilterComposer,
      $$ExercisesTableOrderingComposer,
      $$ExercisesTableAnnotationComposer,
      $$ExercisesTableCreateCompanionBuilder,
      $$ExercisesTableUpdateCompanionBuilder,
      (Exercise, $$ExercisesTableReferences),
      Exercise,
      PrefetchHooks Function({bool categoryId, bool exerciseHistoriesRefs})
    >;
typedef $$ExerciseHistoriesTableCreateCompanionBuilder =
    ExerciseHistoriesCompanion Function({
      Value<int> id,
      required int exerciseId,
      required DateTime completedAt,
      required int durationSeconds,
    });
typedef $$ExerciseHistoriesTableUpdateCompanionBuilder =
    ExerciseHistoriesCompanion Function({
      Value<int> id,
      Value<int> exerciseId,
      Value<DateTime> completedAt,
      Value<int> durationSeconds,
    });

final class $$ExerciseHistoriesTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $ExerciseHistoriesTable,
          ExerciseHistory
        > {
  $$ExerciseHistoriesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $ExercisesTable _exerciseIdTable(_$AppDatabase db) =>
      db.exercises.createAlias(
        $_aliasNameGenerator(db.exerciseHistories.exerciseId, db.exercises.id),
      );

  $$ExercisesTableProcessedTableManager get exerciseId {
    final $_column = $_itemColumn<int>('exercise_id')!;

    final manager = $$ExercisesTableTableManager(
      $_db,
      $_db.exercises,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_exerciseIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ExerciseHistoriesTableFilterComposer
    extends Composer<_$AppDatabase, $ExerciseHistoriesTable> {
  $$ExerciseHistoriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get durationSeconds => $composableBuilder(
    column: $table.durationSeconds,
    builder: (column) => ColumnFilters(column),
  );

  $$ExercisesTableFilterComposer get exerciseId {
    final $$ExercisesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.exerciseId,
      referencedTable: $db.exercises,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ExercisesTableFilterComposer(
            $db: $db,
            $table: $db.exercises,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ExerciseHistoriesTableOrderingComposer
    extends Composer<_$AppDatabase, $ExerciseHistoriesTable> {
  $$ExerciseHistoriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get durationSeconds => $composableBuilder(
    column: $table.durationSeconds,
    builder: (column) => ColumnOrderings(column),
  );

  $$ExercisesTableOrderingComposer get exerciseId {
    final $$ExercisesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.exerciseId,
      referencedTable: $db.exercises,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ExercisesTableOrderingComposer(
            $db: $db,
            $table: $db.exercises,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ExerciseHistoriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ExerciseHistoriesTable> {
  $$ExerciseHistoriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => column,
  );

  GeneratedColumn<int> get durationSeconds => $composableBuilder(
    column: $table.durationSeconds,
    builder: (column) => column,
  );

  $$ExercisesTableAnnotationComposer get exerciseId {
    final $$ExercisesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.exerciseId,
      referencedTable: $db.exercises,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ExercisesTableAnnotationComposer(
            $db: $db,
            $table: $db.exercises,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ExerciseHistoriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ExerciseHistoriesTable,
          ExerciseHistory,
          $$ExerciseHistoriesTableFilterComposer,
          $$ExerciseHistoriesTableOrderingComposer,
          $$ExerciseHistoriesTableAnnotationComposer,
          $$ExerciseHistoriesTableCreateCompanionBuilder,
          $$ExerciseHistoriesTableUpdateCompanionBuilder,
          (ExerciseHistory, $$ExerciseHistoriesTableReferences),
          ExerciseHistory,
          PrefetchHooks Function({bool exerciseId})
        > {
  $$ExerciseHistoriesTableTableManager(
    _$AppDatabase db,
    $ExerciseHistoriesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ExerciseHistoriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ExerciseHistoriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ExerciseHistoriesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> exerciseId = const Value.absent(),
                Value<DateTime> completedAt = const Value.absent(),
                Value<int> durationSeconds = const Value.absent(),
              }) => ExerciseHistoriesCompanion(
                id: id,
                exerciseId: exerciseId,
                completedAt: completedAt,
                durationSeconds: durationSeconds,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int exerciseId,
                required DateTime completedAt,
                required int durationSeconds,
              }) => ExerciseHistoriesCompanion.insert(
                id: id,
                exerciseId: exerciseId,
                completedAt: completedAt,
                durationSeconds: durationSeconds,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ExerciseHistoriesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({exerciseId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (exerciseId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.exerciseId,
                                referencedTable:
                                    $$ExerciseHistoriesTableReferences
                                        ._exerciseIdTable(db),
                                referencedColumn:
                                    $$ExerciseHistoriesTableReferences
                                        ._exerciseIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$ExerciseHistoriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ExerciseHistoriesTable,
      ExerciseHistory,
      $$ExerciseHistoriesTableFilterComposer,
      $$ExerciseHistoriesTableOrderingComposer,
      $$ExerciseHistoriesTableAnnotationComposer,
      $$ExerciseHistoriesTableCreateCompanionBuilder,
      $$ExerciseHistoriesTableUpdateCompanionBuilder,
      (ExerciseHistory, $$ExerciseHistoriesTableReferences),
      ExerciseHistory,
      PrefetchHooks Function({bool exerciseId})
    >;
typedef $$AffirmationsTableCreateCompanionBuilder =
    AffirmationsCompanion Function({
      Value<int> id,
      required String content,
      required String category,
      Value<bool> isFavorite,
      Value<bool> isCustom,
      Value<DateTime> createdAt,
    });
typedef $$AffirmationsTableUpdateCompanionBuilder =
    AffirmationsCompanion Function({
      Value<int> id,
      Value<String> content,
      Value<String> category,
      Value<bool> isFavorite,
      Value<bool> isCustom,
      Value<DateTime> createdAt,
    });

class $$AffirmationsTableFilterComposer
    extends Composer<_$AppDatabase, $AffirmationsTable> {
  $$AffirmationsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get content => $composableBuilder(
    column: $table.content,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isFavorite => $composableBuilder(
    column: $table.isFavorite,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isCustom => $composableBuilder(
    column: $table.isCustom,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$AffirmationsTableOrderingComposer
    extends Composer<_$AppDatabase, $AffirmationsTable> {
  $$AffirmationsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get content => $composableBuilder(
    column: $table.content,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isFavorite => $composableBuilder(
    column: $table.isFavorite,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isCustom => $composableBuilder(
    column: $table.isCustom,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AffirmationsTableAnnotationComposer
    extends Composer<_$AppDatabase, $AffirmationsTable> {
  $$AffirmationsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get content =>
      $composableBuilder(column: $table.content, builder: (column) => column);

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<bool> get isFavorite => $composableBuilder(
    column: $table.isFavorite,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isCustom =>
      $composableBuilder(column: $table.isCustom, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$AffirmationsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AffirmationsTable,
          Affirmation,
          $$AffirmationsTableFilterComposer,
          $$AffirmationsTableOrderingComposer,
          $$AffirmationsTableAnnotationComposer,
          $$AffirmationsTableCreateCompanionBuilder,
          $$AffirmationsTableUpdateCompanionBuilder,
          (
            Affirmation,
            BaseReferences<_$AppDatabase, $AffirmationsTable, Affirmation>,
          ),
          Affirmation,
          PrefetchHooks Function()
        > {
  $$AffirmationsTableTableManager(_$AppDatabase db, $AffirmationsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AffirmationsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AffirmationsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AffirmationsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> content = const Value.absent(),
                Value<String> category = const Value.absent(),
                Value<bool> isFavorite = const Value.absent(),
                Value<bool> isCustom = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => AffirmationsCompanion(
                id: id,
                content: content,
                category: category,
                isFavorite: isFavorite,
                isCustom: isCustom,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String content,
                required String category,
                Value<bool> isFavorite = const Value.absent(),
                Value<bool> isCustom = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => AffirmationsCompanion.insert(
                id: id,
                content: content,
                category: category,
                isFavorite: isFavorite,
                isCustom: isCustom,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AffirmationsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AffirmationsTable,
      Affirmation,
      $$AffirmationsTableFilterComposer,
      $$AffirmationsTableOrderingComposer,
      $$AffirmationsTableAnnotationComposer,
      $$AffirmationsTableCreateCompanionBuilder,
      $$AffirmationsTableUpdateCompanionBuilder,
      (
        Affirmation,
        BaseReferences<_$AppDatabase, $AffirmationsTable, Affirmation>,
      ),
      Affirmation,
      PrefetchHooks Function()
    >;
typedef $$MoodsTableCreateCompanionBuilder =
    MoodsCompanion Function({
      Value<int> id,
      required int moodLevel,
      required int stressLevel,
      required int energyLevel,
      Value<int?> sleepQuality,
      Value<String> notes,
      Value<DateTime> recordedAt,
    });
typedef $$MoodsTableUpdateCompanionBuilder =
    MoodsCompanion Function({
      Value<int> id,
      Value<int> moodLevel,
      Value<int> stressLevel,
      Value<int> energyLevel,
      Value<int?> sleepQuality,
      Value<String> notes,
      Value<DateTime> recordedAt,
    });

final class $$MoodsTableReferences
    extends BaseReferences<_$AppDatabase, $MoodsTable, Mood> {
  $$MoodsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$JournalEntriesTable, List<JournalEntry>>
  _journalEntriesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.journalEntries,
    aliasName: $_aliasNameGenerator(db.moods.id, db.journalEntries.moodId),
  );

  $$JournalEntriesTableProcessedTableManager get journalEntriesRefs {
    final manager = $$JournalEntriesTableTableManager(
      $_db,
      $_db.journalEntries,
    ).filter((f) => f.moodId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_journalEntriesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$MoodsTableFilterComposer extends Composer<_$AppDatabase, $MoodsTable> {
  $$MoodsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get moodLevel => $composableBuilder(
    column: $table.moodLevel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get stressLevel => $composableBuilder(
    column: $table.stressLevel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get energyLevel => $composableBuilder(
    column: $table.energyLevel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sleepQuality => $composableBuilder(
    column: $table.sleepQuality,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get recordedAt => $composableBuilder(
    column: $table.recordedAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> journalEntriesRefs(
    Expression<bool> Function($$JournalEntriesTableFilterComposer f) f,
  ) {
    final $$JournalEntriesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.journalEntries,
      getReferencedColumn: (t) => t.moodId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$JournalEntriesTableFilterComposer(
            $db: $db,
            $table: $db.journalEntries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$MoodsTableOrderingComposer
    extends Composer<_$AppDatabase, $MoodsTable> {
  $$MoodsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get moodLevel => $composableBuilder(
    column: $table.moodLevel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get stressLevel => $composableBuilder(
    column: $table.stressLevel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get energyLevel => $composableBuilder(
    column: $table.energyLevel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sleepQuality => $composableBuilder(
    column: $table.sleepQuality,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get recordedAt => $composableBuilder(
    column: $table.recordedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$MoodsTableAnnotationComposer
    extends Composer<_$AppDatabase, $MoodsTable> {
  $$MoodsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get moodLevel =>
      $composableBuilder(column: $table.moodLevel, builder: (column) => column);

  GeneratedColumn<int> get stressLevel => $composableBuilder(
    column: $table.stressLevel,
    builder: (column) => column,
  );

  GeneratedColumn<int> get energyLevel => $composableBuilder(
    column: $table.energyLevel,
    builder: (column) => column,
  );

  GeneratedColumn<int> get sleepQuality => $composableBuilder(
    column: $table.sleepQuality,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<DateTime> get recordedAt => $composableBuilder(
    column: $table.recordedAt,
    builder: (column) => column,
  );

  Expression<T> journalEntriesRefs<T extends Object>(
    Expression<T> Function($$JournalEntriesTableAnnotationComposer a) f,
  ) {
    final $$JournalEntriesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.journalEntries,
      getReferencedColumn: (t) => t.moodId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$JournalEntriesTableAnnotationComposer(
            $db: $db,
            $table: $db.journalEntries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$MoodsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MoodsTable,
          Mood,
          $$MoodsTableFilterComposer,
          $$MoodsTableOrderingComposer,
          $$MoodsTableAnnotationComposer,
          $$MoodsTableCreateCompanionBuilder,
          $$MoodsTableUpdateCompanionBuilder,
          (Mood, $$MoodsTableReferences),
          Mood,
          PrefetchHooks Function({bool journalEntriesRefs})
        > {
  $$MoodsTableTableManager(_$AppDatabase db, $MoodsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MoodsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MoodsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MoodsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> moodLevel = const Value.absent(),
                Value<int> stressLevel = const Value.absent(),
                Value<int> energyLevel = const Value.absent(),
                Value<int?> sleepQuality = const Value.absent(),
                Value<String> notes = const Value.absent(),
                Value<DateTime> recordedAt = const Value.absent(),
              }) => MoodsCompanion(
                id: id,
                moodLevel: moodLevel,
                stressLevel: stressLevel,
                energyLevel: energyLevel,
                sleepQuality: sleepQuality,
                notes: notes,
                recordedAt: recordedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int moodLevel,
                required int stressLevel,
                required int energyLevel,
                Value<int?> sleepQuality = const Value.absent(),
                Value<String> notes = const Value.absent(),
                Value<DateTime> recordedAt = const Value.absent(),
              }) => MoodsCompanion.insert(
                id: id,
                moodLevel: moodLevel,
                stressLevel: stressLevel,
                energyLevel: energyLevel,
                sleepQuality: sleepQuality,
                notes: notes,
                recordedAt: recordedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$MoodsTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback: ({journalEntriesRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (journalEntriesRefs) db.journalEntries,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (journalEntriesRefs)
                    await $_getPrefetchedData<Mood, $MoodsTable, JournalEntry>(
                      currentTable: table,
                      referencedTable: $$MoodsTableReferences
                          ._journalEntriesRefsTable(db),
                      managerFromTypedResult: (p0) => $$MoodsTableReferences(
                        db,
                        table,
                        p0,
                      ).journalEntriesRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.moodId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$MoodsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MoodsTable,
      Mood,
      $$MoodsTableFilterComposer,
      $$MoodsTableOrderingComposer,
      $$MoodsTableAnnotationComposer,
      $$MoodsTableCreateCompanionBuilder,
      $$MoodsTableUpdateCompanionBuilder,
      (Mood, $$MoodsTableReferences),
      Mood,
      PrefetchHooks Function({bool journalEntriesRefs})
    >;
typedef $$JournalEntriesTableCreateCompanionBuilder =
    JournalEntriesCompanion Function({
      Value<int> id,
      Value<String> title,
      required String body,
      Value<String> tags,
      Value<int?> moodId,
      Value<bool> isFavorite,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });
typedef $$JournalEntriesTableUpdateCompanionBuilder =
    JournalEntriesCompanion Function({
      Value<int> id,
      Value<String> title,
      Value<String> body,
      Value<String> tags,
      Value<int?> moodId,
      Value<bool> isFavorite,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });

final class $$JournalEntriesTableReferences
    extends BaseReferences<_$AppDatabase, $JournalEntriesTable, JournalEntry> {
  $$JournalEntriesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $MoodsTable _moodIdTable(_$AppDatabase db) => db.moods.createAlias(
    $_aliasNameGenerator(db.journalEntries.moodId, db.moods.id),
  );

  $$MoodsTableProcessedTableManager? get moodId {
    final $_column = $_itemColumn<int>('mood_id');
    if ($_column == null) return null;
    final manager = $$MoodsTableTableManager(
      $_db,
      $_db.moods,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_moodIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$JournalEntriesTableFilterComposer
    extends Composer<_$AppDatabase, $JournalEntriesTable> {
  $$JournalEntriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get body => $composableBuilder(
    column: $table.body,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get tags => $composableBuilder(
    column: $table.tags,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isFavorite => $composableBuilder(
    column: $table.isFavorite,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$MoodsTableFilterComposer get moodId {
    final $$MoodsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.moodId,
      referencedTable: $db.moods,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MoodsTableFilterComposer(
            $db: $db,
            $table: $db.moods,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$JournalEntriesTableOrderingComposer
    extends Composer<_$AppDatabase, $JournalEntriesTable> {
  $$JournalEntriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get body => $composableBuilder(
    column: $table.body,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tags => $composableBuilder(
    column: $table.tags,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isFavorite => $composableBuilder(
    column: $table.isFavorite,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$MoodsTableOrderingComposer get moodId {
    final $$MoodsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.moodId,
      referencedTable: $db.moods,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MoodsTableOrderingComposer(
            $db: $db,
            $table: $db.moods,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$JournalEntriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $JournalEntriesTable> {
  $$JournalEntriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get body =>
      $composableBuilder(column: $table.body, builder: (column) => column);

  GeneratedColumn<String> get tags =>
      $composableBuilder(column: $table.tags, builder: (column) => column);

  GeneratedColumn<bool> get isFavorite => $composableBuilder(
    column: $table.isFavorite,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$MoodsTableAnnotationComposer get moodId {
    final $$MoodsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.moodId,
      referencedTable: $db.moods,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MoodsTableAnnotationComposer(
            $db: $db,
            $table: $db.moods,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$JournalEntriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $JournalEntriesTable,
          JournalEntry,
          $$JournalEntriesTableFilterComposer,
          $$JournalEntriesTableOrderingComposer,
          $$JournalEntriesTableAnnotationComposer,
          $$JournalEntriesTableCreateCompanionBuilder,
          $$JournalEntriesTableUpdateCompanionBuilder,
          (JournalEntry, $$JournalEntriesTableReferences),
          JournalEntry,
          PrefetchHooks Function({bool moodId})
        > {
  $$JournalEntriesTableTableManager(
    _$AppDatabase db,
    $JournalEntriesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$JournalEntriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$JournalEntriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$JournalEntriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String> body = const Value.absent(),
                Value<String> tags = const Value.absent(),
                Value<int?> moodId = const Value.absent(),
                Value<bool> isFavorite = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => JournalEntriesCompanion(
                id: id,
                title: title,
                body: body,
                tags: tags,
                moodId: moodId,
                isFavorite: isFavorite,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> title = const Value.absent(),
                required String body,
                Value<String> tags = const Value.absent(),
                Value<int?> moodId = const Value.absent(),
                Value<bool> isFavorite = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => JournalEntriesCompanion.insert(
                id: id,
                title: title,
                body: body,
                tags: tags,
                moodId: moodId,
                isFavorite: isFavorite,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$JournalEntriesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({moodId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (moodId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.moodId,
                                referencedTable: $$JournalEntriesTableReferences
                                    ._moodIdTable(db),
                                referencedColumn:
                                    $$JournalEntriesTableReferences
                                        ._moodIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$JournalEntriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $JournalEntriesTable,
      JournalEntry,
      $$JournalEntriesTableFilterComposer,
      $$JournalEntriesTableOrderingComposer,
      $$JournalEntriesTableAnnotationComposer,
      $$JournalEntriesTableCreateCompanionBuilder,
      $$JournalEntriesTableUpdateCompanionBuilder,
      (JournalEntry, $$JournalEntriesTableReferences),
      JournalEntry,
      PrefetchHooks Function({bool moodId})
    >;
typedef $$RemindersTableCreateCompanionBuilder =
    RemindersCompanion Function({
      Value<int> id,
      required String type,
      required String title,
      required String timeOfDay,
      Value<bool> enabled,
      Value<String> daysOfWeek,
      Value<DateTime> createdAt,
    });
typedef $$RemindersTableUpdateCompanionBuilder =
    RemindersCompanion Function({
      Value<int> id,
      Value<String> type,
      Value<String> title,
      Value<String> timeOfDay,
      Value<bool> enabled,
      Value<String> daysOfWeek,
      Value<DateTime> createdAt,
    });

class $$RemindersTableFilterComposer
    extends Composer<_$AppDatabase, $RemindersTable> {
  $$RemindersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get timeOfDay => $composableBuilder(
    column: $table.timeOfDay,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get enabled => $composableBuilder(
    column: $table.enabled,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get daysOfWeek => $composableBuilder(
    column: $table.daysOfWeek,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$RemindersTableOrderingComposer
    extends Composer<_$AppDatabase, $RemindersTable> {
  $$RemindersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get timeOfDay => $composableBuilder(
    column: $table.timeOfDay,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get enabled => $composableBuilder(
    column: $table.enabled,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get daysOfWeek => $composableBuilder(
    column: $table.daysOfWeek,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$RemindersTableAnnotationComposer
    extends Composer<_$AppDatabase, $RemindersTable> {
  $$RemindersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get timeOfDay =>
      $composableBuilder(column: $table.timeOfDay, builder: (column) => column);

  GeneratedColumn<bool> get enabled =>
      $composableBuilder(column: $table.enabled, builder: (column) => column);

  GeneratedColumn<String> get daysOfWeek => $composableBuilder(
    column: $table.daysOfWeek,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$RemindersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $RemindersTable,
          Reminder,
          $$RemindersTableFilterComposer,
          $$RemindersTableOrderingComposer,
          $$RemindersTableAnnotationComposer,
          $$RemindersTableCreateCompanionBuilder,
          $$RemindersTableUpdateCompanionBuilder,
          (Reminder, BaseReferences<_$AppDatabase, $RemindersTable, Reminder>),
          Reminder,
          PrefetchHooks Function()
        > {
  $$RemindersTableTableManager(_$AppDatabase db, $RemindersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RemindersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RemindersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RemindersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> type = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String> timeOfDay = const Value.absent(),
                Value<bool> enabled = const Value.absent(),
                Value<String> daysOfWeek = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => RemindersCompanion(
                id: id,
                type: type,
                title: title,
                timeOfDay: timeOfDay,
                enabled: enabled,
                daysOfWeek: daysOfWeek,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String type,
                required String title,
                required String timeOfDay,
                Value<bool> enabled = const Value.absent(),
                Value<String> daysOfWeek = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => RemindersCompanion.insert(
                id: id,
                type: type,
                title: title,
                timeOfDay: timeOfDay,
                enabled: enabled,
                daysOfWeek: daysOfWeek,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$RemindersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $RemindersTable,
      Reminder,
      $$RemindersTableFilterComposer,
      $$RemindersTableOrderingComposer,
      $$RemindersTableAnnotationComposer,
      $$RemindersTableCreateCompanionBuilder,
      $$RemindersTableUpdateCompanionBuilder,
      (Reminder, BaseReferences<_$AppDatabase, $RemindersTable, Reminder>),
      Reminder,
      PrefetchHooks Function()
    >;
typedef $$AchievementsTableCreateCompanionBuilder =
    AchievementsCompanion Function({
      Value<int> id,
      required String slug,
      required String title,
      required String description,
      required String icon,
      Value<bool> isUnlocked,
      Value<DateTime?> unlockedAt,
    });
typedef $$AchievementsTableUpdateCompanionBuilder =
    AchievementsCompanion Function({
      Value<int> id,
      Value<String> slug,
      Value<String> title,
      Value<String> description,
      Value<String> icon,
      Value<bool> isUnlocked,
      Value<DateTime?> unlockedAt,
    });

class $$AchievementsTableFilterComposer
    extends Composer<_$AppDatabase, $AchievementsTable> {
  $$AchievementsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get slug => $composableBuilder(
    column: $table.slug,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get icon => $composableBuilder(
    column: $table.icon,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isUnlocked => $composableBuilder(
    column: $table.isUnlocked,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get unlockedAt => $composableBuilder(
    column: $table.unlockedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$AchievementsTableOrderingComposer
    extends Composer<_$AppDatabase, $AchievementsTable> {
  $$AchievementsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get slug => $composableBuilder(
    column: $table.slug,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get icon => $composableBuilder(
    column: $table.icon,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isUnlocked => $composableBuilder(
    column: $table.isUnlocked,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get unlockedAt => $composableBuilder(
    column: $table.unlockedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AchievementsTableAnnotationComposer
    extends Composer<_$AppDatabase, $AchievementsTable> {
  $$AchievementsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get slug =>
      $composableBuilder(column: $table.slug, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<String> get icon =>
      $composableBuilder(column: $table.icon, builder: (column) => column);

  GeneratedColumn<bool> get isUnlocked => $composableBuilder(
    column: $table.isUnlocked,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get unlockedAt => $composableBuilder(
    column: $table.unlockedAt,
    builder: (column) => column,
  );
}

class $$AchievementsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AchievementsTable,
          Achievement,
          $$AchievementsTableFilterComposer,
          $$AchievementsTableOrderingComposer,
          $$AchievementsTableAnnotationComposer,
          $$AchievementsTableCreateCompanionBuilder,
          $$AchievementsTableUpdateCompanionBuilder,
          (
            Achievement,
            BaseReferences<_$AppDatabase, $AchievementsTable, Achievement>,
          ),
          Achievement,
          PrefetchHooks Function()
        > {
  $$AchievementsTableTableManager(_$AppDatabase db, $AchievementsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AchievementsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AchievementsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AchievementsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> slug = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<String> icon = const Value.absent(),
                Value<bool> isUnlocked = const Value.absent(),
                Value<DateTime?> unlockedAt = const Value.absent(),
              }) => AchievementsCompanion(
                id: id,
                slug: slug,
                title: title,
                description: description,
                icon: icon,
                isUnlocked: isUnlocked,
                unlockedAt: unlockedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String slug,
                required String title,
                required String description,
                required String icon,
                Value<bool> isUnlocked = const Value.absent(),
                Value<DateTime?> unlockedAt = const Value.absent(),
              }) => AchievementsCompanion.insert(
                id: id,
                slug: slug,
                title: title,
                description: description,
                icon: icon,
                isUnlocked: isUnlocked,
                unlockedAt: unlockedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AchievementsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AchievementsTable,
      Achievement,
      $$AchievementsTableFilterComposer,
      $$AchievementsTableOrderingComposer,
      $$AchievementsTableAnnotationComposer,
      $$AchievementsTableCreateCompanionBuilder,
      $$AchievementsTableUpdateCompanionBuilder,
      (
        Achievement,
        BaseReferences<_$AppDatabase, $AchievementsTable, Achievement>,
      ),
      Achievement,
      PrefetchHooks Function()
    >;
typedef $$DailyProgressesTableCreateCompanionBuilder =
    DailyProgressesCompanion Function({
      Value<int> id,
      required DateTime date,
      Value<int> wellnessScore,
      Value<int> exercisesCompleted,
      Value<int> breathingSessions,
      Value<int> journalEntries,
      Value<int> waterGlasses,
      Value<int> streakDay,
    });
typedef $$DailyProgressesTableUpdateCompanionBuilder =
    DailyProgressesCompanion Function({
      Value<int> id,
      Value<DateTime> date,
      Value<int> wellnessScore,
      Value<int> exercisesCompleted,
      Value<int> breathingSessions,
      Value<int> journalEntries,
      Value<int> waterGlasses,
      Value<int> streakDay,
    });

class $$DailyProgressesTableFilterComposer
    extends Composer<_$AppDatabase, $DailyProgressesTable> {
  $$DailyProgressesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get wellnessScore => $composableBuilder(
    column: $table.wellnessScore,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get exercisesCompleted => $composableBuilder(
    column: $table.exercisesCompleted,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get breathingSessions => $composableBuilder(
    column: $table.breathingSessions,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get journalEntries => $composableBuilder(
    column: $table.journalEntries,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get waterGlasses => $composableBuilder(
    column: $table.waterGlasses,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get streakDay => $composableBuilder(
    column: $table.streakDay,
    builder: (column) => ColumnFilters(column),
  );
}

class $$DailyProgressesTableOrderingComposer
    extends Composer<_$AppDatabase, $DailyProgressesTable> {
  $$DailyProgressesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get wellnessScore => $composableBuilder(
    column: $table.wellnessScore,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get exercisesCompleted => $composableBuilder(
    column: $table.exercisesCompleted,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get breathingSessions => $composableBuilder(
    column: $table.breathingSessions,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get journalEntries => $composableBuilder(
    column: $table.journalEntries,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get waterGlasses => $composableBuilder(
    column: $table.waterGlasses,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get streakDay => $composableBuilder(
    column: $table.streakDay,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$DailyProgressesTableAnnotationComposer
    extends Composer<_$AppDatabase, $DailyProgressesTable> {
  $$DailyProgressesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<int> get wellnessScore => $composableBuilder(
    column: $table.wellnessScore,
    builder: (column) => column,
  );

  GeneratedColumn<int> get exercisesCompleted => $composableBuilder(
    column: $table.exercisesCompleted,
    builder: (column) => column,
  );

  GeneratedColumn<int> get breathingSessions => $composableBuilder(
    column: $table.breathingSessions,
    builder: (column) => column,
  );

  GeneratedColumn<int> get journalEntries => $composableBuilder(
    column: $table.journalEntries,
    builder: (column) => column,
  );

  GeneratedColumn<int> get waterGlasses => $composableBuilder(
    column: $table.waterGlasses,
    builder: (column) => column,
  );

  GeneratedColumn<int> get streakDay =>
      $composableBuilder(column: $table.streakDay, builder: (column) => column);
}

class $$DailyProgressesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DailyProgressesTable,
          DailyProgressesData,
          $$DailyProgressesTableFilterComposer,
          $$DailyProgressesTableOrderingComposer,
          $$DailyProgressesTableAnnotationComposer,
          $$DailyProgressesTableCreateCompanionBuilder,
          $$DailyProgressesTableUpdateCompanionBuilder,
          (
            DailyProgressesData,
            BaseReferences<
              _$AppDatabase,
              $DailyProgressesTable,
              DailyProgressesData
            >,
          ),
          DailyProgressesData,
          PrefetchHooks Function()
        > {
  $$DailyProgressesTableTableManager(
    _$AppDatabase db,
    $DailyProgressesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DailyProgressesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DailyProgressesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DailyProgressesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<DateTime> date = const Value.absent(),
                Value<int> wellnessScore = const Value.absent(),
                Value<int> exercisesCompleted = const Value.absent(),
                Value<int> breathingSessions = const Value.absent(),
                Value<int> journalEntries = const Value.absent(),
                Value<int> waterGlasses = const Value.absent(),
                Value<int> streakDay = const Value.absent(),
              }) => DailyProgressesCompanion(
                id: id,
                date: date,
                wellnessScore: wellnessScore,
                exercisesCompleted: exercisesCompleted,
                breathingSessions: breathingSessions,
                journalEntries: journalEntries,
                waterGlasses: waterGlasses,
                streakDay: streakDay,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required DateTime date,
                Value<int> wellnessScore = const Value.absent(),
                Value<int> exercisesCompleted = const Value.absent(),
                Value<int> breathingSessions = const Value.absent(),
                Value<int> journalEntries = const Value.absent(),
                Value<int> waterGlasses = const Value.absent(),
                Value<int> streakDay = const Value.absent(),
              }) => DailyProgressesCompanion.insert(
                id: id,
                date: date,
                wellnessScore: wellnessScore,
                exercisesCompleted: exercisesCompleted,
                breathingSessions: breathingSessions,
                journalEntries: journalEntries,
                waterGlasses: waterGlasses,
                streakDay: streakDay,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$DailyProgressesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DailyProgressesTable,
      DailyProgressesData,
      $$DailyProgressesTableFilterComposer,
      $$DailyProgressesTableOrderingComposer,
      $$DailyProgressesTableAnnotationComposer,
      $$DailyProgressesTableCreateCompanionBuilder,
      $$DailyProgressesTableUpdateCompanionBuilder,
      (
        DailyProgressesData,
        BaseReferences<
          _$AppDatabase,
          $DailyProgressesTable,
          DailyProgressesData
        >,
      ),
      DailyProgressesData,
      PrefetchHooks Function()
    >;
typedef $$UserSettingsTableCreateCompanionBuilder =
    UserSettingsCompanion Function({
      Value<int> id,
      Value<bool> onboardingComplete,
      Value<String> displayName,
      Value<String> goals,
      Value<String> themeMode,
      Value<String> languageCode,
      Value<bool> notificationsEnabled,
      Value<String> defaultReminderTime,
      Value<int> dailyWaterGoal,
    });
typedef $$UserSettingsTableUpdateCompanionBuilder =
    UserSettingsCompanion Function({
      Value<int> id,
      Value<bool> onboardingComplete,
      Value<String> displayName,
      Value<String> goals,
      Value<String> themeMode,
      Value<String> languageCode,
      Value<bool> notificationsEnabled,
      Value<String> defaultReminderTime,
      Value<int> dailyWaterGoal,
    });

class $$UserSettingsTableFilterComposer
    extends Composer<_$AppDatabase, $UserSettingsTable> {
  $$UserSettingsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get onboardingComplete => $composableBuilder(
    column: $table.onboardingComplete,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get goals => $composableBuilder(
    column: $table.goals,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get themeMode => $composableBuilder(
    column: $table.themeMode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get languageCode => $composableBuilder(
    column: $table.languageCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get notificationsEnabled => $composableBuilder(
    column: $table.notificationsEnabled,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get defaultReminderTime => $composableBuilder(
    column: $table.defaultReminderTime,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get dailyWaterGoal => $composableBuilder(
    column: $table.dailyWaterGoal,
    builder: (column) => ColumnFilters(column),
  );
}

class $$UserSettingsTableOrderingComposer
    extends Composer<_$AppDatabase, $UserSettingsTable> {
  $$UserSettingsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get onboardingComplete => $composableBuilder(
    column: $table.onboardingComplete,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get goals => $composableBuilder(
    column: $table.goals,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get themeMode => $composableBuilder(
    column: $table.themeMode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get languageCode => $composableBuilder(
    column: $table.languageCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get notificationsEnabled => $composableBuilder(
    column: $table.notificationsEnabled,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get defaultReminderTime => $composableBuilder(
    column: $table.defaultReminderTime,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get dailyWaterGoal => $composableBuilder(
    column: $table.dailyWaterGoal,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$UserSettingsTableAnnotationComposer
    extends Composer<_$AppDatabase, $UserSettingsTable> {
  $$UserSettingsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<bool> get onboardingComplete => $composableBuilder(
    column: $table.onboardingComplete,
    builder: (column) => column,
  );

  GeneratedColumn<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get goals =>
      $composableBuilder(column: $table.goals, builder: (column) => column);

  GeneratedColumn<String> get themeMode =>
      $composableBuilder(column: $table.themeMode, builder: (column) => column);

  GeneratedColumn<String> get languageCode => $composableBuilder(
    column: $table.languageCode,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get notificationsEnabled => $composableBuilder(
    column: $table.notificationsEnabled,
    builder: (column) => column,
  );

  GeneratedColumn<String> get defaultReminderTime => $composableBuilder(
    column: $table.defaultReminderTime,
    builder: (column) => column,
  );

  GeneratedColumn<int> get dailyWaterGoal => $composableBuilder(
    column: $table.dailyWaterGoal,
    builder: (column) => column,
  );
}

class $$UserSettingsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $UserSettingsTable,
          UserSetting,
          $$UserSettingsTableFilterComposer,
          $$UserSettingsTableOrderingComposer,
          $$UserSettingsTableAnnotationComposer,
          $$UserSettingsTableCreateCompanionBuilder,
          $$UserSettingsTableUpdateCompanionBuilder,
          (
            UserSetting,
            BaseReferences<_$AppDatabase, $UserSettingsTable, UserSetting>,
          ),
          UserSetting,
          PrefetchHooks Function()
        > {
  $$UserSettingsTableTableManager(_$AppDatabase db, $UserSettingsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UserSettingsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UserSettingsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UserSettingsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<bool> onboardingComplete = const Value.absent(),
                Value<String> displayName = const Value.absent(),
                Value<String> goals = const Value.absent(),
                Value<String> themeMode = const Value.absent(),
                Value<String> languageCode = const Value.absent(),
                Value<bool> notificationsEnabled = const Value.absent(),
                Value<String> defaultReminderTime = const Value.absent(),
                Value<int> dailyWaterGoal = const Value.absent(),
              }) => UserSettingsCompanion(
                id: id,
                onboardingComplete: onboardingComplete,
                displayName: displayName,
                goals: goals,
                themeMode: themeMode,
                languageCode: languageCode,
                notificationsEnabled: notificationsEnabled,
                defaultReminderTime: defaultReminderTime,
                dailyWaterGoal: dailyWaterGoal,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<bool> onboardingComplete = const Value.absent(),
                Value<String> displayName = const Value.absent(),
                Value<String> goals = const Value.absent(),
                Value<String> themeMode = const Value.absent(),
                Value<String> languageCode = const Value.absent(),
                Value<bool> notificationsEnabled = const Value.absent(),
                Value<String> defaultReminderTime = const Value.absent(),
                Value<int> dailyWaterGoal = const Value.absent(),
              }) => UserSettingsCompanion.insert(
                id: id,
                onboardingComplete: onboardingComplete,
                displayName: displayName,
                goals: goals,
                themeMode: themeMode,
                languageCode: languageCode,
                notificationsEnabled: notificationsEnabled,
                defaultReminderTime: defaultReminderTime,
                dailyWaterGoal: dailyWaterGoal,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$UserSettingsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $UserSettingsTable,
      UserSetting,
      $$UserSettingsTableFilterComposer,
      $$UserSettingsTableOrderingComposer,
      $$UserSettingsTableAnnotationComposer,
      $$UserSettingsTableCreateCompanionBuilder,
      $$UserSettingsTableUpdateCompanionBuilder,
      (
        UserSetting,
        BaseReferences<_$AppDatabase, $UserSettingsTable, UserSetting>,
      ),
      UserSetting,
      PrefetchHooks Function()
    >;
typedef $$WaterTrackingsTableCreateCompanionBuilder =
    WaterTrackingsCompanion Function({
      Value<int> id,
      required DateTime date,
      Value<int> glasses,
    });
typedef $$WaterTrackingsTableUpdateCompanionBuilder =
    WaterTrackingsCompanion Function({
      Value<int> id,
      Value<DateTime> date,
      Value<int> glasses,
    });

class $$WaterTrackingsTableFilterComposer
    extends Composer<_$AppDatabase, $WaterTrackingsTable> {
  $$WaterTrackingsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get glasses => $composableBuilder(
    column: $table.glasses,
    builder: (column) => ColumnFilters(column),
  );
}

class $$WaterTrackingsTableOrderingComposer
    extends Composer<_$AppDatabase, $WaterTrackingsTable> {
  $$WaterTrackingsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get glasses => $composableBuilder(
    column: $table.glasses,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$WaterTrackingsTableAnnotationComposer
    extends Composer<_$AppDatabase, $WaterTrackingsTable> {
  $$WaterTrackingsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<int> get glasses =>
      $composableBuilder(column: $table.glasses, builder: (column) => column);
}

class $$WaterTrackingsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $WaterTrackingsTable,
          WaterTracking,
          $$WaterTrackingsTableFilterComposer,
          $$WaterTrackingsTableOrderingComposer,
          $$WaterTrackingsTableAnnotationComposer,
          $$WaterTrackingsTableCreateCompanionBuilder,
          $$WaterTrackingsTableUpdateCompanionBuilder,
          (
            WaterTracking,
            BaseReferences<_$AppDatabase, $WaterTrackingsTable, WaterTracking>,
          ),
          WaterTracking,
          PrefetchHooks Function()
        > {
  $$WaterTrackingsTableTableManager(
    _$AppDatabase db,
    $WaterTrackingsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WaterTrackingsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WaterTrackingsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$WaterTrackingsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<DateTime> date = const Value.absent(),
                Value<int> glasses = const Value.absent(),
              }) =>
                  WaterTrackingsCompanion(id: id, date: date, glasses: glasses),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required DateTime date,
                Value<int> glasses = const Value.absent(),
              }) => WaterTrackingsCompanion.insert(
                id: id,
                date: date,
                glasses: glasses,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$WaterTrackingsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $WaterTrackingsTable,
      WaterTracking,
      $$WaterTrackingsTableFilterComposer,
      $$WaterTrackingsTableOrderingComposer,
      $$WaterTrackingsTableAnnotationComposer,
      $$WaterTrackingsTableCreateCompanionBuilder,
      $$WaterTrackingsTableUpdateCompanionBuilder,
      (
        WaterTracking,
        BaseReferences<_$AppDatabase, $WaterTrackingsTable, WaterTracking>,
      ),
      WaterTracking,
      PrefetchHooks Function()
    >;
typedef $$BreathingHistoriesTableCreateCompanionBuilder =
    BreathingHistoriesCompanion Function({
      Value<int> id,
      required String pattern,
      required int durationSeconds,
      Value<DateTime> completedAt,
    });
typedef $$BreathingHistoriesTableUpdateCompanionBuilder =
    BreathingHistoriesCompanion Function({
      Value<int> id,
      Value<String> pattern,
      Value<int> durationSeconds,
      Value<DateTime> completedAt,
    });

class $$BreathingHistoriesTableFilterComposer
    extends Composer<_$AppDatabase, $BreathingHistoriesTable> {
  $$BreathingHistoriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get pattern => $composableBuilder(
    column: $table.pattern,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get durationSeconds => $composableBuilder(
    column: $table.durationSeconds,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$BreathingHistoriesTableOrderingComposer
    extends Composer<_$AppDatabase, $BreathingHistoriesTable> {
  $$BreathingHistoriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get pattern => $composableBuilder(
    column: $table.pattern,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get durationSeconds => $composableBuilder(
    column: $table.durationSeconds,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$BreathingHistoriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $BreathingHistoriesTable> {
  $$BreathingHistoriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get pattern =>
      $composableBuilder(column: $table.pattern, builder: (column) => column);

  GeneratedColumn<int> get durationSeconds => $composableBuilder(
    column: $table.durationSeconds,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => column,
  );
}

class $$BreathingHistoriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $BreathingHistoriesTable,
          BreathingHistory,
          $$BreathingHistoriesTableFilterComposer,
          $$BreathingHistoriesTableOrderingComposer,
          $$BreathingHistoriesTableAnnotationComposer,
          $$BreathingHistoriesTableCreateCompanionBuilder,
          $$BreathingHistoriesTableUpdateCompanionBuilder,
          (
            BreathingHistory,
            BaseReferences<
              _$AppDatabase,
              $BreathingHistoriesTable,
              BreathingHistory
            >,
          ),
          BreathingHistory,
          PrefetchHooks Function()
        > {
  $$BreathingHistoriesTableTableManager(
    _$AppDatabase db,
    $BreathingHistoriesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BreathingHistoriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BreathingHistoriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BreathingHistoriesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> pattern = const Value.absent(),
                Value<int> durationSeconds = const Value.absent(),
                Value<DateTime> completedAt = const Value.absent(),
              }) => BreathingHistoriesCompanion(
                id: id,
                pattern: pattern,
                durationSeconds: durationSeconds,
                completedAt: completedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String pattern,
                required int durationSeconds,
                Value<DateTime> completedAt = const Value.absent(),
              }) => BreathingHistoriesCompanion.insert(
                id: id,
                pattern: pattern,
                durationSeconds: durationSeconds,
                completedAt: completedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$BreathingHistoriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $BreathingHistoriesTable,
      BreathingHistory,
      $$BreathingHistoriesTableFilterComposer,
      $$BreathingHistoriesTableOrderingComposer,
      $$BreathingHistoriesTableAnnotationComposer,
      $$BreathingHistoriesTableCreateCompanionBuilder,
      $$BreathingHistoriesTableUpdateCompanionBuilder,
      (
        BreathingHistory,
        BaseReferences<
          _$AppDatabase,
          $BreathingHistoriesTable,
          BreathingHistory
        >,
      ),
      BreathingHistory,
      PrefetchHooks Function()
    >;
typedef $$FavoritesTableCreateCompanionBuilder =
    FavoritesCompanion Function({
      Value<int> id,
      required String entityType,
      required int entityId,
    });
typedef $$FavoritesTableUpdateCompanionBuilder =
    FavoritesCompanion Function({
      Value<int> id,
      Value<String> entityType,
      Value<int> entityId,
    });

class $$FavoritesTableFilterComposer
    extends Composer<_$AppDatabase, $FavoritesTable> {
  $$FavoritesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get entityType => $composableBuilder(
    column: $table.entityType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get entityId => $composableBuilder(
    column: $table.entityId,
    builder: (column) => ColumnFilters(column),
  );
}

class $$FavoritesTableOrderingComposer
    extends Composer<_$AppDatabase, $FavoritesTable> {
  $$FavoritesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get entityType => $composableBuilder(
    column: $table.entityType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get entityId => $composableBuilder(
    column: $table.entityId,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$FavoritesTableAnnotationComposer
    extends Composer<_$AppDatabase, $FavoritesTable> {
  $$FavoritesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get entityType => $composableBuilder(
    column: $table.entityType,
    builder: (column) => column,
  );

  GeneratedColumn<int> get entityId =>
      $composableBuilder(column: $table.entityId, builder: (column) => column);
}

class $$FavoritesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $FavoritesTable,
          Favorite,
          $$FavoritesTableFilterComposer,
          $$FavoritesTableOrderingComposer,
          $$FavoritesTableAnnotationComposer,
          $$FavoritesTableCreateCompanionBuilder,
          $$FavoritesTableUpdateCompanionBuilder,
          (Favorite, BaseReferences<_$AppDatabase, $FavoritesTable, Favorite>),
          Favorite,
          PrefetchHooks Function()
        > {
  $$FavoritesTableTableManager(_$AppDatabase db, $FavoritesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FavoritesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FavoritesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FavoritesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> entityType = const Value.absent(),
                Value<int> entityId = const Value.absent(),
              }) => FavoritesCompanion(
                id: id,
                entityType: entityType,
                entityId: entityId,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String entityType,
                required int entityId,
              }) => FavoritesCompanion.insert(
                id: id,
                entityType: entityType,
                entityId: entityId,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$FavoritesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $FavoritesTable,
      Favorite,
      $$FavoritesTableFilterComposer,
      $$FavoritesTableOrderingComposer,
      $$FavoritesTableAnnotationComposer,
      $$FavoritesTableCreateCompanionBuilder,
      $$FavoritesTableUpdateCompanionBuilder,
      (Favorite, BaseReferences<_$AppDatabase, $FavoritesTable, Favorite>),
      Favorite,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$ExerciseCategoriesTableTableManager get exerciseCategories =>
      $$ExerciseCategoriesTableTableManager(_db, _db.exerciseCategories);
  $$ExercisesTableTableManager get exercises =>
      $$ExercisesTableTableManager(_db, _db.exercises);
  $$ExerciseHistoriesTableTableManager get exerciseHistories =>
      $$ExerciseHistoriesTableTableManager(_db, _db.exerciseHistories);
  $$AffirmationsTableTableManager get affirmations =>
      $$AffirmationsTableTableManager(_db, _db.affirmations);
  $$MoodsTableTableManager get moods =>
      $$MoodsTableTableManager(_db, _db.moods);
  $$JournalEntriesTableTableManager get journalEntries =>
      $$JournalEntriesTableTableManager(_db, _db.journalEntries);
  $$RemindersTableTableManager get reminders =>
      $$RemindersTableTableManager(_db, _db.reminders);
  $$AchievementsTableTableManager get achievements =>
      $$AchievementsTableTableManager(_db, _db.achievements);
  $$DailyProgressesTableTableManager get dailyProgresses =>
      $$DailyProgressesTableTableManager(_db, _db.dailyProgresses);
  $$UserSettingsTableTableManager get userSettings =>
      $$UserSettingsTableTableManager(_db, _db.userSettings);
  $$WaterTrackingsTableTableManager get waterTrackings =>
      $$WaterTrackingsTableTableManager(_db, _db.waterTrackings);
  $$BreathingHistoriesTableTableManager get breathingHistories =>
      $$BreathingHistoriesTableTableManager(_db, _db.breathingHistories);
  $$FavoritesTableTableManager get favorites =>
      $$FavoritesTableTableManager(_db, _db.favorites);
}
