---
trigger: always_on
---

# Coding Style Rules

## General

Write clean, readable code.

Follow:

- SOLID principles.
- DRY principle.
- KISS principle.

## Naming

Use meaningful names.

Avoid:

- a
- temp
- data
- obj

Prefer:

- customerRepository
- paymentService
- orderStatus

## Functions

Functions should:

- Do one thing.
- Have clear responsibility.
- Avoid excessive parameters.

## Error Handling

Never silently ignore errors.

Always:

- Handle exceptions.
- Provide meaningful messages.
- Log important failures.

## Comments

Comments should explain:

- Why something exists.

Avoid comments explaining:

- What the code obviously does.
