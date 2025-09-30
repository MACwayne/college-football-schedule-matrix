# Development Workflow - AI-Assisted Development

## Problem
Currently, we have to push to GitHub Pages every time to see changes, which is slow and inefficient for rapid iteration.

## Solution: Multiple Options for Real-Time Development Preview

---

## Option 1: **Local Dev Server with Screenshots** (Recommended)

### How It Works
1. Run local dev server (instant updates)
2. Take screenshots of UI changes
3. Share screenshots with AI for feedback
4. Iterate quickly without deployments

### Setup
```bash
# Start dev server
npm run dev
# Opens at http://localhost:5173

# In another terminal, take screenshots on demand
npm run screenshot
```

### Screenshot Script
```json
// package.json
{
  "scripts": {
    "dev": "vite",
    "screenshot": "node scripts/screenshot.js"
  }
}
```

```javascript
// scripts/screenshot.js
const puppeteer = require('puppeteer');

(async () => {
  const browser = await puppeteer.launch();
  const page = await browser.newPage();
  
  // Set viewport for desktop/mobile
  await page.setViewport({ width: 1920, height: 1080 });
  
  await page.goto('http://localhost:5173');
  await page.screenshot({ 
    path: 'screenshots/desktop-latest.png',
    fullPage: true 
  });
  
  // Mobile viewport
  await page.setViewport({ width: 375, height: 812 }); // iPhone
  await page.screenshot({ 
    path: 'screenshots/mobile-latest.png',
    fullPage: true 
  });
  
  console.log('✅ Screenshots saved to screenshots/');
  await browser.close();
})();
```

**Pros:**
- ✅ Instant feedback
- ✅ Visual verification
- ✅ Can test responsive design
- ✅ No deployment needed

**Cons:**
- ❌ Requires manual screenshot sharing
- ❌ Not real-time interaction

---

## Option 2: **Tunneling with ngrok or localtunnel**

### How It Works
Expose your local dev server to the internet temporarily so AI can access it.

### Setup with ngrok
```bash
# Install ngrok
brew install ngrok  # macOS
# or download from ngrok.com

# Start dev server
npm run dev

# In another terminal, create tunnel
ngrok http 5173

# Copy the public URL (e.g., https://abc123.ngrok.io)
# Share with AI
```

### Setup with localtunnel (Free, No Signup)
```bash
# Install localtunnel
npm install -g localtunnel

# Start dev server
npm run dev

# Create tunnel
lt --port 5173

# Copy the URL (e.g., https://abc123.loca.lt)
```

**Pros:**
- ✅ Real-time access to live dev server
- ✅ AI can see actual UI, not screenshots
- ✅ Test on real URLs
- ✅ Works with mobile devices too

**Cons:**
- ❌ Requires running tunnel service
- ❌ URLs expire after session
- ❌ Security consideration (exposing localhost)

---

## Option 3: **Console Logging + HTML Snapshots** (Simplest)

### How It Works
Generate HTML snapshots and detailed console logs that can be easily shared.

### Setup
```typescript
// src/utils/devLogger.ts
export const logUIState = () => {
  const state = {
    timestamp: new Date().toISOString(),
    viewport: {
      width: window.innerWidth,
      height: window.innerHeight,
    },
    currentView: getCurrentView(),
    scheduleData: getScheduleState(),
    rankings: getRankingsState(),
    errors: getErrors(),
  };
  
  console.log('📊 UI State Snapshot:', JSON.stringify(state, null, 2));
  
  // Also save to file
  saveSnapshot(state);
};

// Auto-log on significant changes
useEffect(() => {
  logUIState();
}, [scheduleData, rankings]);
```

### Generate HTML Snapshots
```javascript
// scripts/snapshot.js
const fs = require('fs');

// Capture current HTML
const html = document.documentElement.outerHTML;

// Save with timestamp
const filename = `snapshots/ui-${Date.now()}.html`;
fs.writeFileSync(filename, html);

console.log(`✅ Snapshot saved: ${filename}`);
```

**Pros:**
- ✅ Simple to implement
- ✅ No external services
- ✅ Detailed state tracking
- ✅ Easy to review logs

**Cons:**
- ❌ Not real-time
- ❌ Requires manual snapshot generation
- ❌ Static HTML may not capture full interactivity

---

## Option 4: **Storybook for Component Development** (Best for Components)

### How It Works
Develop components in isolation with Storybook, making it easy to share specific UI states.

### Setup
```bash
npx storybook@latest init
npm run storybook
```

### Example Story
```typescript
// src/components/GameCell.stories.tsx
import type { Meta, StoryObj } from '@storybook/react';
import { GameCell } from './GameCell';

const meta: Meta<typeof GameCell> = {
  title: 'Schedule/GameCell',
  component: GameCell,
  parameters: {
    layout: 'centered',
  },
};

export default meta;
type Story = StoryObj<typeof GameCell>;

export const Default: Story = {
  args: {
    game: {
      opponent: 'Alabama',
      score: '24-21',
      homeAway: 'H',
      result: 'W',
    },
  },
};

export const Away: Story = {
  args: {
    game: {
      opponent: 'Georgia',
      score: '17-24',
      homeAway: 'A',
      result: 'L',
    },
  },
};

export const Future: Story = {
  args: {
    game: {
      opponent: 'LSU',
      homeAway: 'H',
      result: null,
    },
  },
};
```

### Deploy Storybook
```bash
# Build static storybook
npm run build-storybook

# Deploy to GitHub Pages (separate from main app)
# https://yourusername.github.io/cfb-matrix-storybook/
```

**Pros:**
- ✅ Best for isolated component development
- ✅ Can be deployed and shared easily
- ✅ Interactive component playground
- ✅ Automatic documentation
- ✅ Visual regression testing

**Cons:**
- ❌ Extra setup required
- ❌ Doesn't show full app integration

---

## Option 5: **Automated Visual Regression Testing**

### How It Works
Automatically capture screenshots, compare with baselines, and log differences.

### Setup with Percy or Chromatic
```bash
# Install Percy
npm install --save-dev @percy/cli @percy/puppeteer

# Or Chromatic (from Storybook team)
npm install --save-dev chromatic
```

### Percy Example
```javascript
// tests/visual.test.js
const puppeteer = require('puppeteer');
const percySnapshot = require('@percy/puppeteer');

describe('Visual Tests', () => {
  let browser, page;

  beforeAll(async () => {
    browser = await puppeteer.launch();
    page = await browser.newPage();
  });

  test('Homepage', async () => {
    await page.goto('http://localhost:5173');
    await percySnapshot(page, 'Homepage');
  });

  test('Schedule Matrix', async () => {
    await page.goto('http://localhost:5173');
    await page.click('[data-testid="fbs-tab"]');
    await percySnapshot(page, 'FBS Schedule');
  });

  afterAll(() => browser.close());
});
```

### Run and Share
```bash
# Run visual tests
npm run test:visual

# Percy creates a dashboard with comparisons
# Share the Percy dashboard URL with AI
```

**Pros:**
- ✅ Automated screenshot capture
- ✅ Visual diff tracking
- ✅ Shareable dashboard
- ✅ Catches visual regressions

**Cons:**
- ❌ Requires paid service (Percy/Chromatic)
- ❌ Overkill for simple dev workflow

---

## Option 6: **Screen Recording + Loom/CloudApp**

### How It Works
Record your screen showing the UI, share video link with AI.

### Tools
- **Loom** (loom.com): Free, records screen + webcam
- **CloudApp** (getcloudapp.com): Screenshots + GIFs
- **QuickTime** (macOS): Built-in screen recording

### Workflow
1. Make changes in code
2. Record 30-second demo of UI
3. Share Loom link with AI
4. AI provides feedback
5. Iterate

**Pros:**
- ✅ Shows actual UI interaction
- ✅ Easy to demonstrate animations
- ✅ Can narrate what you're doing
- ✅ Free tools available

**Cons:**
- ❌ Not real-time
- ❌ Manual recording required
- ❌ AI can't interact directly

---

## Option 7: **Live Collaboration with Replit or CodeSandbox** (Real-Time)

### How It Works
Develop in a cloud IDE that generates shareable live preview URLs.

### Replit
```bash
# Import GitHub repo to Replit
# https://replit.com/github/yourusername/cfb-matrix

# Share the Replit preview URL
# https://cfb-matrix.yourusername.repl.co
```

### CodeSandbox
```bash
# Import GitHub repo to CodeSandbox
# https://codesandbox.io/s/github/yourusername/cfb-matrix

# Share the preview URL
# https://abc123.csb.app
```

**Pros:**
- ✅ Real-time preview
- ✅ AI can see live changes
- ✅ No local setup needed
- ✅ Collaborative editing possible

**Cons:**
- ❌ Slower than local development
- ❌ May hit resource limits
- ❌ Internet connection required

---

## **Recommended Workflow for AI-Assisted Development**

### **For Rapid Iteration (Best)**

**Combo: Local Dev + Screenshots + Selective Tunneling**

```bash
# Terminal 1: Dev server
npm run dev

# Make changes, see them instantly at localhost:5173

# Terminal 2: Generate screenshots when ready for feedback
npm run screenshot

# Terminal 3: Create tunnel for complex issues
lt --port 5173
```

### Daily Workflow
1. **Start dev server** → Instant local preview
2. **Make changes** → See updates immediately
3. **Take screenshots** → Share visual state with AI
4. **Get feedback** → AI reviews screenshots
5. **Iterate quickly** → No deploy wait time
6. **For complex issues** → Open temporary tunnel
7. **When stable** → Push to GitHub Pages

### Screenshot Automation Script

```bash
#!/bin/bash
# scripts/dev-snapshot.sh

# Take screenshots
npm run screenshot

# Optional: Upload to imgur or similar
# curl -F "image=@screenshots/desktop-latest.png" https://api.imgur.com/3/upload

echo "✅ Screenshots ready for sharing!"
echo "📸 Desktop: screenshots/desktop-latest.png"
echo "📱 Mobile: screenshots/mobile-latest.png"
```

---

## Setup Instructions for Recommended Workflow

### 1. Install Dependencies
```bash
# For screenshots
npm install --save-dev puppeteer

# For tunneling (optional)
npm install -g localtunnel
```

### 2. Add Scripts to package.json
```json
{
  "scripts": {
    "dev": "vite",
    "build": "vite build",
    "preview": "vite preview",
    "screenshot": "node scripts/screenshot.js",
    "screenshot:watch": "nodemon --watch src --exec 'npm run screenshot'",
    "tunnel": "lt --port 5173"
  }
}
```

### 3. Create Screenshot Script
```javascript
// scripts/screenshot.js
const puppeteer = require('puppeteer');
const fs = require('fs');

const SCREENSHOTS_DIR = './screenshots';

// Ensure directory exists
if (!fs.existsSync(SCREENSHOTS_DIR)) {
  fs.mkdirSync(SCREENSHOTS_DIR);
}

const devices = [
  { name: 'desktop', width: 1920, height: 1080 },
  { name: 'tablet', width: 768, height: 1024 },
  { name: 'mobile', width: 375, height: 812 },
];

(async () => {
  const browser = await puppeteer.launch({ headless: 'new' });
  const page = await browser.newPage();
  
  for (const device of devices) {
    await page.setViewport({ 
      width: device.width, 
      height: device.height 
    });
    
    await page.goto('http://localhost:5173', {
      waitUntil: 'networkidle0'
    });
    
    // Wait for main content
    await page.waitForSelector('.schedule-matrix', { timeout: 5000 })
      .catch(() => console.log('⚠️  Schedule matrix not found'));
    
    const timestamp = new Date().toISOString().replace(/[:.]/g, '-');
    const filename = `${SCREENSHOTS_DIR}/${device.name}-${timestamp}.png`;
    
    await page.screenshot({ 
      path: filename,
      fullPage: true 
    });
    
    console.log(`✅ ${device.name}: ${filename}`);
  }
  
  await browser.close();
  console.log('\n📸 All screenshots captured!');
})();
```

### 4. Usage
```bash
# Start dev server in one terminal
npm run dev

# In another terminal, capture screenshots
npm run screenshot

# Or auto-capture on file changes
npm run screenshot:watch

# Or create tunnel for AI access
npm run tunnel
```

---

## Console Logging Strategy

### Create Development Logger

```typescript
// src/utils/devLogger.ts
export const DevLogger = {
  snapshot(label: string) {
    const snapshot = {
      timestamp: new Date().toISOString(),
      label,
      viewport: {
        width: window.innerWidth,
        height: window.innerHeight,
      },
      url: window.location.href,
      state: {
        // Add your app state here
        division: store.getState().selectedDivision,
        teams: store.getState().teams.length,
        games: store.getState().games.length,
        // etc.
      },
    };
    
    console.log(`📊 [SNAPSHOT: ${label}]`, JSON.stringify(snapshot, null, 2));
    
    // Also save to localStorage for review
    const snapshots = JSON.parse(localStorage.getItem('dev-snapshots') || '[]');
    snapshots.push(snapshot);
    localStorage.setItem('dev-snapshots', JSON.stringify(snapshots));
    
    return snapshot;
  },
  
  clearSnapshots() {
    localStorage.removeItem('dev-snapshots');
    console.log('🗑️  Cleared all snapshots');
  },
  
  getSnapshots() {
    return JSON.parse(localStorage.getItem('dev-snapshots') || '[]');
  },
};

// Use in components
DevLogger.snapshot('After schedule loaded');
DevLogger.snapshot('User toggled game result');
```

---

## Comparison of Options

| Method | Real-Time | Easy Setup | AI Access | Cost |
|--------|-----------|------------|-----------|------|
| Screenshots | ❌ | ✅ | ✅ | Free |
| Tunneling (ngrok/localtunnel) | ✅ | ✅ | ✅ | Free |
| Console Logs | ❌ | ✅ | ✅ | Free |
| Storybook | ✅ | ⚠️ | ✅ | Free |
| Visual Testing | ✅ | ⚠️ | ✅ | Paid |
| Screen Recording | ❌ | ✅ | ✅ | Free |
| Cloud IDE | ✅ | ✅ | ✅ | Free |

---

## My Recommendation: **Hybrid Approach**

```bash
# Day-to-day development
npm run dev                    # Local dev server (instant feedback)
npm run screenshot            # Generate screenshots for AI review

# For complex debugging
npm run tunnel                # Temporary live access

# For component development
npm run storybook             # Isolated component testing

# Before deployment
npm run build && npm run preview  # Test production build
```

This gives you:
- ⚡ **Speed** (local dev)
- 👁️ **Visibility** (screenshots)
- 🔗 **Access** (tunneling when needed)
- 🎯 **Precision** (Storybook for components)

---

## Next Steps

1. **Choose your preferred method** (I recommend screenshots + tunneling)
2. **Set up the scripts** (I can help with this)
3. **Test the workflow** (make a change, capture, share)
4. **Iterate rapidly** (no more waiting for deployments!)

Want me to set up the screenshot script for your current project, or help configure any of these options?

