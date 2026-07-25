# VAG-DMP — Design System

Inspired by rural India, agriculture, and trust. Soft, earthen palette — deliberately avoids harsh generic primary colors.

## Color Palette (as specified)

| Role | Hex | Meaning |
|---|---|---|
| Primary — Agricultural Green | `#2E7D32` | Trust, growth, agriculture |
| Secondary — Terracotta/Soil | `#D84315` | Earth, action, ground-reality |
| Tertiary — Mustard/Gold | `#F9A825` | Warmth, alerts |
| Background — Cream | `#FAF9F6` | Replaces stark white, reduces eye strain |
| Surface — Cards | `#FFFFFF` | Contrast against cream background |

## ⚠️ Found Issue: Palette Violation Already Shipped
Your Submit screen screenshot shows a **blue card** for the "Drinking Water" category. Blue does not exist anywhere in the defined palette above. This is a real inconsistency already in the build, not a hypothetical one — fix it one of two ways:
1. **Recolor it** to fit the existing earthen palette (e.g., a deep teal-green variant of Primary, or a muted slate within the Terracotta family), or
2. **Formally add a 4th brand color** (a specific water-blue hex) to this document so it's an intentional design decision, not an accidental one-off.

Either is fine — just make the choice deliberately and update this file, so the next screen you build doesn't invent a 5th ad hoc color.

## Typography
- **Font Family**: Inter (Google Fonts) — chosen for legibility on low-resolution screens
- **Hierarchy**:
  - `titleLarge` — Bold, Primary text
  - `bodyMedium` — Standard text, Secondary color
  - `labelSmall` — Hints, tags, uppercase tracking

## UI Theme Rules
- **Material 3** components throughout
- **Cards**: zero-elevation (`elevation: 0`), rounded corners (`Radius.circular(16)` or `24`), subtle borders instead of drop shadows
- **Buttons**: large, pill-shaped `FilledButton`s for primary actions — maximizes tap targets for users unused to touch screens

## Verified Against Screenshots
- Green app bar, pill-shaped filter chips (History screen), rounded avatar badge (Profile) — all consistent with the system above. Good execution overall; the blue card is the one thing to fix.
