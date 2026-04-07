# Frontend Patterns Reference

> UI component libraries, terminal UI, browser automation, and design systems
> Compiled: 2026-03-15

---

## Component Library Landscape

### Comparison Matrix

| Library | Framework | Style | Accessible | Customizable | Bundle Size |
|---------|-----------|-------|------------|-------------|-------------|
| **shadcn/ui** | React | Tailwind | Yes (Radix) | Full source | Zero (copy/paste) |
| **Radix UI** | React | Unstyled | Yes | Bring your CSS | Small per-component |
| **Headless UI** | React/Vue | Unstyled | Yes | Bring your CSS | Small |
| **Ark UI** | React/Vue/Solid | Unstyled | Yes (Zag) | Bring your CSS | Small |
| **Mantine** | React | Built-in | Yes | Theme system | Medium |
| **Chakra UI** | React | Built-in | Yes | Theme system | Medium |
| **Material UI** | React | Material | Yes | Theme system | Large |
| **Ant Design** | React | Ant | Partial | Theme tokens | Large |

---

## shadcn/ui Architecture

### How It Works
Unlike traditional component libraries, shadcn/ui is NOT installed as a dependency. Components are copied into your project and become your own code.

```
npx shadcn-ui@latest init    # Initialize in project
npx shadcn-ui@latest add button  # Copy button component
npx shadcn-ui@latest add dialog  # Copy dialog component
```

### Architecture
```
Your Project
├── components/
│   └── ui/           ← shadcn components live here (YOUR code)
│       ├── button.tsx
│       ├── dialog.tsx
│       ├── input.tsx
│       └── ...
├── lib/
│   └── utils.ts      ← cn() utility for Tailwind class merging
└── tailwind.config.ts ← Extended with shadcn theme tokens
```

### Key Patterns

**cn() Utility** (class name merging):
```typescript
import { clsx, type ClassValue } from "clsx"
import { twMerge } from "tailwind-merge"

export function cn(...inputs: ClassValue[]) {
  return twMerge(clsx(inputs))
}

// Usage
<Button className={cn("bg-blue-500", isActive && "bg-green-500")} />
```

**Component Variants** (class-variance-authority):
```typescript
import { cva, type VariantProps } from "class-variance-authority"

const buttonVariants = cva(
  "inline-flex items-center justify-center rounded-md text-sm font-medium transition-colors",
  {
    variants: {
      variant: {
        default: "bg-primary text-primary-foreground hover:bg-primary/90",
        destructive: "bg-destructive text-destructive-foreground hover:bg-destructive/90",
        outline: "border border-input bg-background hover:bg-accent",
        ghost: "hover:bg-accent hover:text-accent-foreground",
      },
      size: {
        default: "h-10 px-4 py-2",
        sm: "h-9 px-3 rounded-md",
        lg: "h-11 px-8 rounded-md",
        icon: "h-10 w-10",
      },
    },
    defaultVariants: {
      variant: "default",
      size: "default",
    },
  }
)
```

**Theme System** (CSS variables):
```css
@layer base {
  :root {
    --background: 0 0% 100%;
    --foreground: 222.2 84% 4.9%;
    --primary: 222.2 47.4% 11.2%;
    --primary-foreground: 210 40% 98%;
    /* ... */
  }
  .dark {
    --background: 222.2 84% 4.9%;
    --foreground: 210 40% 98%;
    --primary: 210 40% 98%;
    --primary-foreground: 222.2 47.4% 11.2%;
  }
}
```

---

## Terminal UI

### Charm (charmbracelet ecosystem)

**Libraries**:
- **Bubble Tea**: TUI framework (Go) — Elm-inspired, model/view/update
- **Lip Gloss**: CSS-like styling for terminal output
- **Bubbles**: Pre-built TUI components
- **Huh**: Interactive forms for CLI
- **Crush**: Image processing for terminal (resize, crop, filter)

**Key Pattern: Elm Architecture for TUI**:
```go
// Model-View-Update pattern
type Model struct {
    choices  []string
    cursor   int
    selected map[int]struct{}
}

func (m Model) Update(msg tea.Msg) (tea.Model, tea.Cmd) {
    switch msg := msg.(type) {
    case tea.KeyMsg:
        switch msg.String() {
        case "up", "k":
            m.cursor--
        case "down", "j":
            m.cursor++
        case "enter":
            m.selected[m.cursor] = struct{}{}
        }
    }
    return m, nil
}
```

**Python Alternatives**: Rich (formatting), Textual (TUI framework), Click (CLI).

---

## Browser & UI Automation

### UI-TARS (ByteDance)

**Value**: AI-powered GUI automation using vision models.

**Architecture**:
```
Screenshot → Vision Model → Action Plan → Execute Actions
    ↑                                           │
    └──────── Feedback Loop ◄───────────────────┘
```

**Key Concepts**:
- Visual understanding of UI elements (no DOM parsing needed)
- Action grounding: click, type, scroll, drag
- Multi-step task planning from screenshots
- Cross-platform: works with any GUI (web, desktop, mobile)

### Bytebot

**Value**: Browser automation via AI agent — natural language → browser actions.

**Comparison with Khaled's webapp-testing skill**:
| Feature | webapp-testing (Playwright) | Bytebot |
|---------|---------------------------|---------|
| Approach | Code-driven selectors | AI vision + NL commands |
| Reliability | High (deterministic) | Medium (AI-dependent) |
| Maintenance | Update selectors when UI changes | Self-healing |
| Speed | Fast | Slower (LLM inference) |

### React Native CLI (Cali)

**Value**: Streamlined CLI for React Native development.

**Key Commands**:
```bash
# Create project
npx cali init my-app

# Run on platforms
npx cali run:ios
npx cali run:android

# Build
npx cali build:ios
npx cali build:android
```

---

## Design Token Systems

### Token Architecture
```
Design Tokens (Abstract)
    ├── Color: primary, secondary, accent, neutral
    ├── Typography: font-family, font-size scale, line-height, weight
    ├── Spacing: 4px base unit (4, 8, 12, 16, 24, 32, 48, 64)
    ├── Radius: sm (4px), md (8px), lg (12px), full
    ├── Shadow: sm, md, lg, xl
    └── Motion: duration (150ms, 300ms, 500ms), easing (ease-in-out)
         ↓
CSS Custom Properties
    ├── --color-primary-500: #3b82f6
    ├── --font-size-lg: 1.125rem
    ├── --space-4: 1rem
    └── --radius-md: 0.5rem
         ↓
Tailwind Config / CSS-in-JS Theme
```

### Implementation
```css
:root {
  /* Semantic color tokens */
  --color-bg-primary: var(--color-white);
  --color-bg-secondary: var(--color-gray-50);
  --color-text-primary: var(--color-gray-900);
  --color-text-secondary: var(--color-gray-600);
  --color-border-default: var(--color-gray-200);
  --color-accent: var(--color-blue-500);

  /* Spacing scale */
  --space-1: 0.25rem;
  --space-2: 0.5rem;
  --space-3: 0.75rem;
  --space-4: 1rem;
  --space-6: 1.5rem;
  --space-8: 2rem;

  /* Typography scale */
  --text-xs: 0.75rem;
  --text-sm: 0.875rem;
  --text-base: 1rem;
  --text-lg: 1.125rem;
  --text-xl: 1.25rem;
  --text-2xl: 1.5rem;
}
```

---

## Animation Performance Patterns

### Compositor-Safe Properties
Only animate these for 60fps:
- `transform` (translate, scale, rotate)
- `opacity`
- `filter` (with GPU acceleration)

### CSS Animation Patterns
```css
/* Staggered entrance */
.item {
  opacity: 0;
  transform: translateY(20px);
  animation: fadeUp 0.5s ease-out forwards;
}
.item:nth-child(1) { animation-delay: 0.1s; }
.item:nth-child(2) { animation-delay: 0.2s; }
.item:nth-child(3) { animation-delay: 0.3s; }

@keyframes fadeUp {
  to {
    opacity: 1;
    transform: translateY(0);
  }
}

/* Respect user preferences */
@media (prefers-reduced-motion: reduce) {
  * {
    animation-duration: 0.01ms !important;
    transition-duration: 0.01ms !important;
  }
}
```

---

## Cross-References

- **frontend-design** skill: Creative UI design, bold aesthetics
- **responsive-design** skill: Mobile-first, breakpoints, fluid typography
- **baseline-ui** skill: Tailwind defaults, component accessibility
- **fixing-accessibility** skill: ARIA, keyboard nav, WCAG
- **fixing-motion-performance** skill: Animation performance
- **ui-ux-pro-max** skill: 50+ styles, design system generation
- **webapp-testing** skill: Playwright browser testing
- **frontend-architect** agent: UI architecture decisions
