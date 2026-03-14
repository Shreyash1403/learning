# 📚 Flutter/Dart Concepts Reference Guide
> Created from learning sessions — refer anytime!

---

## Table of Contents
1. [Null Safety — All ? Symbols](#1-null-safety--all--symbols)
2. [Null, Empty, No Data](#2-null-empty-no-data)
3. [Model Class — Complete Guide](#3-model-class--complete-guide)
4. [fromJson — Field Type Decision](#4-fromjson--field-type-decision)
5. [Equatable, copyWith, props](#5-equatable-copywith-props)
6. [Service Class — Complete Guide](#6-service-class--complete-guide)
7. [Error Handling — try-catch](#7-error-handling--trycatch)
8. [Architecture Pattern — BLoC](#8-architecture-pattern--bloc)
9. [Widgets — Flexible vs Expanded](#9-widgets--flexible-vs-expanded)
10. [Quick Cheat Sheets](#10-quick-cheat-sheets)

---

## 1. Null Safety — All `?` Symbols

### ? has DIFFERENT meanings based on WHERE it's used:

```dart
// AFTER TYPE → "can be null" (declaring nullable variable)
String? name;              // name can hold null or a String
int? age;                  // age can hold null or an int
Owner? owner;              // owner can hold null or an Owner object

// BEFORE DOT → "safe access" (access property only if not null)
owner?.name                // if owner is null → returns null, no crash
name?.length               // if name is null → returns null, no crash
name?.toUpperCase()        // if name is null → returns null, no crash

// BEFORE BRACKET → "safe bracket access" (for Maps and Lists)
data?['message']           // if data is null → returns null, no crash
list?[0]                   // if list is null → returns null, no crash

// ?? → "if null, use this default instead"
name ?? ''                 // if name is null → use ''
age ?? 0                   // if age is null → use 0
list ?? []                 // if list is null → use []

// ! → "I'm SURE this is not null" (force unwrap)
owner!.name                // if owner IS null → CRASH! Use carefully.
```

### Summary Table:
```
┌──────────────┬────────────────────────────┬──────────────────────┐
│ Symbol       │ Name                       │ Example              │
├──────────────┼────────────────────────────┼──────────────────────┤
│ Type?        │ Nullable type              │ String? name;        │
│ ?.           │ Safe access (dot)          │ owner?.name          │
│ ?[]          │ Safe access (bracket)      │ data?['key']         │
│ ??           │ Null coalescing (default)  │ name ?? ''           │
│ !            │ Force unwrap (dangerous)   │ owner!.name          │
│ ?.toString() │ Safe method call           │ json['x']?.toString()│
└──────────────┴────────────────────────────┴──────────────────────┘
```

---

## 2. Null, Empty, No Data

```
┌───────────┬────────────────────┬──────────────────────────────┐
│ Value     │ What it is         │ Real life example            │
├───────────┼────────────────────┼──────────────────────────────┤
│ null      │ NOTHING exists     │ No box at all 📭             │
│ ""        │ Empty string       │ Box exists, but empty 📦     │
│ []        │ Empty list         │ Shelf exists, but no items 🗄️│
│ {}        │ Empty map/object   │ Folder exists, but no files 📁│
│ 0         │ Zero (has value!)  │ Wallet exists, ₹0 inside 👛  │
│ false     │ Boolean false      │ Switch exists, turned OFF 🔘 │
└───────────┴────────────────────┴──────────────────────────────┘
```

### Checks in Dart:
```dart
value == null              // Is it null?
"".isEmpty                 // true (empty string)
[].isEmpty                 // true (empty list)
{}.isEmpty                 // true (empty map)
(value ?? '').isEmpty      // true if null OR empty
```

---

## 3. Model Class — Complete Guide

### 5-Part Structure:
```dart
class MyModel extends Equatable {
  // PART 1: Fields (final = immutable)
  final String name;
  final int age;
  final Owner? owner;          // Object → nullable

  // PART 2: Constructor
  const MyModel({required this.name, required this.age, this.owner});

  // PART 3: fromJson (JSON → Dart object)
  factory MyModel.fromJson(Map<String, dynamic> json) { ... }

  // PART 4: toJson (Dart object → JSON)
  Map<String, dynamic> toJson() => { ... };

  // PART 5: copyWith (create modified copy)
  MyModel copyWith({String? name, int? age}) { ... }

  // PART 6: props (for Equatable comparison)
  @override
  List<Object?> get props => [name, age, owner];
}
```

---

## 4. fromJson — Field Type Decision

### THE GOLDEN RULE: "Do I need to know if this data is MISSING?"
```
NO  → Use non-nullable + ?? default   (handle once in fromJson)
YES → Use nullable (?)                 (handle in UI with if-check)
```

### Decision Table:
```
┌─────────────────┬──────────────┬─────────────────────────────────────────┐
│ Type            │ fromJson     │ When to use                             │
├─────────────────┼──────────────┼─────────────────────────────────────────┤
│ String (always  │ ?? ''        │ name, email, address — always show      │
│  show in UI)    │              │                                          │
│                 │              │                                          │
│ String? (hide   │ keep null    │ phone, website — HIDE section if missing│
│  section if     │              │                                          │
│  missing)       │              │                                          │
│                 │              │                                          │
│ int             │ ?? 0         │ count, status — always show             │
│                 │              │                                          │
│ int?            │ keep null    │ discount — HIDE badge if no discount    │
│                 │              │                                          │
│ double          │ ?? 0.0       │ rating, price — always show             │
│                 │              │                                          │
│ bool            │ ?? false     │ isOpen, isActive — always show          │
│                 │              │                                          │
│ List<X>         │ ?? []        │ photos, tags — always use (empty = ok)  │
│                 │              │                                          │
│ Object? (Owner?)│ keep null    │ owner, topDish — HIDE section if missing│
└─────────────────┴──────────────┴─────────────────────────────────────────┘
```

### Why Objects use ? (not ?? {}):
```
''  (empty string)  = "I AM a string, just empty"     ← Makes sense
[]  (empty list)    = "I AM a list, just empty"        ← Makes sense
Owner(name:'')      = "I AM a person, just... empty?"  ← FAKE! No sense 🤮
null                = "There IS no person"             ← Makes sense ✅
```

### fromJson Patterns:
```dart
// String (always show):
name: json['name']?.toString() ?? '',

// String? (hide if missing):
phone: json['phone']?.toString(),

// int (always show):
status: json['status'] ?? 0,

// int (API sends as String "1"):
currentPage: int.tryParse(json['current_page']?.toString() ?? '') ?? 0,

// bool:
isOpen: json['is_open'] ?? false,

// List:
photos: (json['photos'] as List<dynamic>?)?.map((e) => e.toString()).toList() ?? [],

// Object? (nullable):
owner: json['owner'] != null ? Owner.fromJson(json['owner']) : null,

// List of objects:
users: (json['users'] as List<dynamic>?)?.map((e) => User.fromJson(e)).toList() ?? [],

// Convert empty string to null (special case):
paidBy: (json['paid_by']?.toString() ?? '').isNotEmpty ? json['paid_by'].toString() : null,

// Convert dummy date to null (special case):
linkOpenedOn: rawDate == '0000-00-00 00:00:00' ? null : rawDate,
```

### ?.toString() explained:
```dart
json['name']?.toString() ?? ''
│            │  │          │
│            │  │          └── If still null → use ''
│            │  └── Convert to String (safe against wrong types like int)
│            └── Only call toString() if not null
└── Get value from JSON map (could be null, String, int, anything)
```

### When NOT sure if field can be null → use ? (safer):
```
Start with ?     → Remove later = easy (delete some if checks)
Start without ?  → Add later    = painful (crash + fix many files)
```

---

## 5. Equatable, copyWith, props

### Equatable — WHY:
```dart
// Without Equatable:
final a = User(name: 'Shreyash');
final b = User(name: 'Shreyash');
a == b  // false! (different memory address)

// With Equatable:
a == b  // true! (same values = equal)

// BLoC NEEDS this:
// oldState == newState → true → no UI rebuild (saves performance)
// oldState != newState → false → UI rebuilds (shows new data)
```

### copyWith — WHY:
```dart
// Fields are final (can't change):
user.name = 'New Name';  // ❌ ERROR!

// copyWith creates NEW object with changes:
final updated = user.copyWith(name: 'New Name');

// Original unchanged:
user.name       // 'Shreyash' (untouched)
updated.name    // 'New Name' (new copy)

// Used in BLoC to update state immutably
```

### copyWith — WHY all params are nullable:
```dart
MyModel copyWith({
  String? name,       // ? means "optional to pass"
  int? age,
}) {
  return MyModel(
    name: name ?? this.name,    // passed? use new. not passed? keep old.
    age: age ?? this.age,
  );
}

// Usage:
user.copyWith(name: 'New')    // only name changes, age stays same
```

### props — WHY:
```dart
@override
List<Object?> get props => [name, age, owner];
// Tells Equatable: "Compare THESE fields for equality"
// ⚠️ Put ALL fields here! Missing a field = BLoC won't detect that change!
```

---

## 6. Service Class — Complete Guide

### Service Role:
```
Service ONLY does 3 things:
1. CALL API        → _dio.get(endpoint, queryParameters)
2. CHECK response  → switch (error_code or statusCode)
3. RETURN or THROW → success: return Model | error: throw Exception
```

### Your API Pattern (HTTP 200 for everything):
```dart
switch (response.data['error_code']) {    // Check INSIDE body
  case 100: return Model.fromJson(data);  // Success
  case 440: throw SessionExpiredException();
  default:  throw ApiException(errorCode, message);
}
```

### Proper REST API Pattern (different HTTP codes):
```dart
switch (response.statusCode) {            // Check HTTP code directly
  case 200: return Model.fromJson(data);  // Success
  case 401: throw SessionExpiredException();
  default:  throw ApiException(statusCode, message);
}
```

### queryParameters (Dio builds URL automatically):
```dart
_dio.get('/api/users', queryParameters: {'page': 1, 'limit': 10})
// Becomes: /api/users?page=1&limit=10
```

---

## 7. Error Handling — try-catch

### Hierarchy Rule: SPECIFIC → GENERIC (top to bottom)
```dart
try {
  // Code that might fail
} on DioException catch (e) {          // 1️⃣ Most specific
  // Network error (no internet, timeout)
} on SessionExpiredException {         // 2️⃣ Specific
  rethrow;                             // Pass up to BLoC
} on ApiException catch (e) {          // 3️⃣ Specific
  rethrow;                             // Pass up to BLoC
} catch (e) {                          // 4️⃣ LAST! Catches everything
  // Unexpected error (parsing, null, etc.)
}
```

### How Dart checks:
```
Error thrown → Check catch 1 → Match? Stop. No? → Check catch 2 → ...
First matching catch block wins. Others are skipped.
```

### ❌ WRONG: catch(e) first = catches everything, others never run!
```dart
catch (e) { ... }              // Catches ALL errors!
on DioException catch (e) { }  // ❌ Never reached!
```

### Custom Exception Classes:
```dart
ApiException           → Show error message (toast/snackbar)
SessionExpiredException → Navigate to LOGIN screen
NetworkException        → Show "Check your internet"
```

### rethrow vs throw:
```dart
rethrow;                    // Pass SAME exception up (don't create new one)
throw Exception('...');     // Create NEW exception
```

### DioException types:
```
connectionTimeout  → "Taking too long to connect"
receiveTimeout     → "Server too slow to respond"
connectionError    → "No internet / server down"
sendTimeout        → "Upload taking too long"
cancel             → "Request was cancelled"
badResponse        → "Server returned error HTTP code"
```

---

## 8. Architecture Pattern — BLoC

### Layer Diagram:
```
┌─────────────────────────────────────────────────┐
│ UI (Screen)     → Displays data, sends events   │
├─────────────────────────────────────────────────┤
│ BLoC            → Manages state, emits states    │
├─────────────────────────────────────────────────┤
│ Repository      → Business logic, decisions      │
├─────────────────────────────────────────────────┤
│ Service         → Makes API calls, parses JSON   │
├─────────────────────────────────────────────────┤
│ Model           → Data classes (Equatable)        │
├─────────────────────────────────────────────────┤
│ Exceptions      → Custom error types              │
└─────────────────────────────────────────────────┘
```

### Each Layer's Job:
```
Model      → Define data structure + parsing
Exceptions → Define error types
Service    → Call API + throw exceptions
Repository → Business logic + catch/handle exceptions
BLoC       → Receive events + emit states
UI         → Display states + send events
```

### Error Flow:
```
API sends error_code 440
  → Service throws SessionExpiredException
    → Repository catches and rethrows
      → BLoC catches and emits SessionExpiredState
        → UI navigates to login screen
```

### Folder Structure:
```
lib/
├── core/                          ← Shared across project
│   └── api/
│       ├── api_client.dart        ← Dio singleton
│       ├── api_constants.dart     ← URLs, headers
│       └── exceptions.dart        ← Custom exceptions
│
└── modules/
    └── livelink/                  ← One module
        ├── models/                ← Data classes
        ├── services/              ← API calls
        ├── repositories/          ← Business logic
        ├── bloc/                  ← State management
        ├── screens/               ← Full pages
        └── widgets/               ← Reusable UI pieces
```

---

## 9. Widgets — Flexible vs Expanded

### Problem: `RenderFlex overflow error` (text goes off screen)

### Expanded (Greedy — takes ALL remaining space):
```dart
Row(
  children: [
    Text('Label'),
    Expanded(child: Text('Very long text...')),  // Takes ALL remaining space
  ],
)
// Use when: child should FILL available space
// Expanded = Flexible with fit: FlexFit.tight
```

### Flexible (Modest — takes only needed space):
```dart
Row(
  children: [
    Text('Label'),
    Flexible(child: Text('Very long text...')),  // Takes only what it needs
  ],
)
// Use when: prevent overflow without stretching
```

### Decision:
```
Need to FILL remaining space?  → Expanded
Just prevent overflow?         → Flexible
```

---

## 10. Quick Cheat Sheets

### Model Creation Workflow:
```
1. Auto-generate from JSON (quicktype.io)
2. Make fields 'final'
3. Add ?? defaults in fromJson
4. Decide nullable fields (Object? only when API can send null)
5. Add extends Equatable + props
6. Add copyWith
```

### for...in Loop:
```dart
// Traditional (index):
for (int i = 0; i < list.length; i++) { print(list[i]); }

// Shortcut (for...in):
for (final item in list) { print(item); }

// Both do the SAME thing!
```

### `as` keyword (Type casting):
```dart
json['users'] as List<dynamic>?    // Tell Dart "this is a List"
// Without 'as': Dart says "I don't know the type, can't loop!"
// With 'as': Dart says "OK it's a List, I can loop!" ✅
```

### `is` keyword (Type checking):
```dart
if (value is List) { ... }    // "Is this value a List?"
if (value is String) { ... }  // "Is this value a String?"
// Security guard: only proceed if type matches
```

### Nested List Flattening:
```
API: [ [{A}, {B}], [{C}, {D}] ]     ← Double nested
Our model: [A, B, C, D]              ← Flat list (easy to use)
```

### StatelessWidget vs StatefulWidget:
```
StatelessWidget → No internal state (just displays data)
StatefulWidget  → Has internal state (dropdowns, toggles, animations)
```

---

## 🎯 Golden Rules to Remember

1. **Handle null in fromJson, not in UI** → Write `?? ''` once, use everywhere
2. **Objects use ?, primitives use ??** → `Owner?` but `String + ?? ''`
3. **When in doubt, use ?** → Safer to remove later than add after crash
4. **catch(e) always LAST** → Specific exceptions first, generic last
5. **Each layer does ONE job** → Service=API, Repository=Logic, BLoC=State
6. **rethrow, don't wrap** → Keep original exception type for proper handling
7. **final fields** → Immutable = no accidental changes = no bugs
8. **All fields in props** → Missing one = BLoC won't detect that change
