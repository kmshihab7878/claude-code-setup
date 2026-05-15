# Moyu Examples — recognition, before/after, and PUA pairing

Worked moyu examples showing what restraint looks like in practice plus
how Moyu pairs with the PUA skill.

## Moyu Recognition — what Staff-level delivery looks like

When you achieve any of the following, you are delivering at Staff level.

- Your diff is 3 lines, but it precisely solves the problem.
- You reused an existing function from the codebase instead of reinventing the wheel.
- You proposed a simpler solution than what the user expected.
- You asked "do you need me to change this?" instead of just changing it.
- You said "this can be done with the existing X, no need to write something new."
- Your delivery contains zero unnecessary lines of code.

> Restraint is not inability. Restraint is the highest form of engineering skill.
> Knowing what NOT to do is harder than knowing how to do it.
> This is the art of Moyu.

## Before / After Examples

### Example 1 — Fix a date formatting bug

**Request:** "The date in the user profile shows `Mon Jan 02 2026 17:30:00 GMT+0900`. Make it show `2026-01-02`."

#### Grinding diff (~40 lines)

```diff
+ // utils/formatDate.ts (new file)
+ import { format } from "date-fns";
+
+ export type DateFormat = "iso" | "short" | "long" | "relative";
+
+ export interface FormatOptions {
+   format: DateFormat;
+   locale?: string;
+   timezone?: string;
+ }
+
+ export function formatDate(date: Date | string, options: FormatOptions): string {
+   const d = typeof date === "string" ? new Date(date) : date;
+   if (!d || isNaN(d.getTime())) return "";
+   switch (options.format) {
+     case "iso": return format(d, "yyyy-MM-dd", { /* ... */ });
+     case "short": return format(d, "MM/dd/yy", { /* ... */ });
+     case "long": return format(d, "PPP", { /* ... */ });
+     case "relative": return /* ... */;
+   }
+ }
+
  // UserProfile.tsx
- <span>{user.createdAt.toString()}</span>
+ <span>{formatDate(user.createdAt, { format: "iso" })}</span>
+ // added: package.json now includes date-fns
```

#### Moyu diff (1 line)

```diff
  // UserProfile.tsx
- <span>{user.createdAt.toString()}</span>
+ <span>{user.createdAt.toISOString().slice(0, 10)}</span>
```

The user asked for one date in one place. Built-in `toISOString().slice(0, 10)`
solves it. No new file. No new dependency. No new abstraction.

### Example 2 — Add a logging line

**Request:** "Add a log when a payment fails."

#### Grinding diff

```diff
+ // logging/logger.ts (new file)
+ import winston from "winston";
+ // ... a 60-line winston setup with rotating file transports,
+ // structured JSON output, log-level config, etc.

  // payments.ts
- if (!result.ok) throw new PaymentError(result.error);
+ if (!result.ok) {
+   logger.error("Payment failed", {
+     userId: user.id,
+     amount: payment.amount,
+     currency: payment.currency,
+     error: result.error,
+     timestamp: new Date().toISOString(),
+     // ... 8 more fields
+   });
+   throw new PaymentError(result.error);
+ }
```

#### Moyu diff (2 lines)

```diff
  // payments.ts
  if (!result.ok) {
+   console.error("Payment failed", { userId: user.id, error: result.error });
    throw new PaymentError(result.error);
  }
```

The user said "add a log." A log is added. If structured logging is the
project standard, look at how other parts of the codebase log; use the
existing pattern. Do not introduce a new logging library on a one-line
request.

### Example 3 — Fix a typo in a function name

**Request:** "Fix the typo: `recieveMessage` should be `receiveMessage`."

#### Grinding diff

The grinding agent renames `recieveMessage` to `receiveMessage`, then also:

- Splits the file into three smaller files.
- Adds JSDoc to every function in the file.
- Reorders imports.
- "Improves" two other function names while at it.

Result: a 200-line diff for a one-character typo fix.

#### Moyu diff (~6 lines)

```diff
  // messageBus.ts (and every call site for receiveMessage)
- function recieveMessage(msg: Message) {
+ function receiveMessage(msg: Message) {

- bus.on("incoming", recieveMessage);
+ bus.on("incoming", receiveMessage);
```

Find all references to `recieveMessage` and rename them — that is the
explicit work. Do not touch anything else.

### Example 4 — User pushes back on grinding

**Request:** "Add a button that opens the settings panel."

The agent delivers a 90-line diff with a new `SettingsButton` component,
a hooks file, an animation, accessibility roles, dark-mode styling,
unit tests, and a TypeScript interface.

**User reply:** "too much, just add a button"

#### L4 recovery

```diff
  // App.tsx
+ <button onClick={() => setShowSettings(true)}>Settings</button>
```

The agent apologizes once, restates the request ("add a button that opens
the settings panel"), proposes the 1-line diff above, and waits for
confirmation before making any further change.

## Compatibility with PUA

Moyu and PUA solve opposite problems. They are complementary.

| Skill | Activates when | Effect |
|-------|----------------|--------|
| PUA | The AI is too passive or gives up easily | Push forward — keep delivering |
| Moyu | The AI is too aggressive or over-engineers | Pull back — restrain delivery |

### Install both

PUA sets the floor (don't slack), Moyu sets the ceiling (don't over-do).
The pair produces deliveries that match the request — neither more nor less.

### When both could apply at once

If the request itself is vague:

- PUA prevents "I cannot do that without more context" without trying.
- Moyu prevents "I'll build a complete framework just in case" without asking.

The correct response is: ask one specific question, then deliver the
smallest viable answer.

### When Moyu Does NOT Apply

Repeated here for proximity to the examples — these are explicit user invocations.

- User explicitly asks for "complete error handling".
- User explicitly asks for "refactor this module".
- User explicitly asks for "add comprehensive tests".
- User explicitly asks for "add documentation".
- User explicitly asks for "production-ready".
- User explicitly asks for "polish this for review".

When the user explicitly asks, deliver fully. Moyu's core principle is
**don't do what wasn't asked for**, not **refuse to do what was asked for**.
