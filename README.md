QuoteVault – AI-Assisted iOS App (SwiftUI + Supabase)

QuoteVault is a modern iOS application built with SwiftUI, Supabase, and Apple system frameworks, designed to explore how AI-assisted development can accelerate real-world app creation while maintaining clean architecture and production-ready code.

Features
Authentication

Email/password authentication using Supabase Auth

Session restore on app launch

Secure logout and session cleanup

Quotes

Browse curated quotes

Save favorites

Daily quote notification support

Share quote as a styled image card

Collections

Create custom quote collections

Add/remove quotes to collections

Supabase Row Level Security (RLS) enforced per user

Profile & Settings

Update profile name

Upload profile avatar (Supabase Storage)

Dark mode toggle

Font size adjustment

Accent color selection

Notification scheduling

Notifications & Widget

Daily quote notifications (background only)

Home screen widget showing daily quote

Widget respects user preferences

Tech Stack

SwiftUI

Combine

Supabase (Auth, Database, Storage)

PhotosUI

UserNotifications

WidgetKit

Async/Await Concurrency

Setup Instructions
1. Clone Repository
git clone https://github.com/your-username/QuoteVault.git
cd QuoteVault

2. Supabase Configuration

Create a Supabase project and add the following:

Tables

quotes

collections

collection_quotes

profiles

Ensure Row Level Security (RLS) is enabled.

Example policy (profiles):

create policy "Users can update own profile"
on public.profiles
for update
using (auth.uid() = id)
with check (auth.uid() = id);

Storage

Bucket: avatars

Public access enabled

Policy allowing users to upload/update their own avatar

3. Environment Setup

Add Supabase keys to your app:

SupabaseClient(
  supabaseURL: URL(string: "YOUR_PROJECT_URL")!,
  supabaseKey: "YOUR_ANON_KEY"
)

4. Build & Run

Xcode 26+

iOS 26+ recommended

Run on simulator or device

AI Coding Approach & Workflow

This project was intentionally built using AI-assisted development while keeping architectural decisions human-driven.

How AI Was Used

Generating SwiftUI view scaffolds

Drafting Supabase queries and RLS policies

Debugging concurrency and PhotosPicker issues

Refactoring ViewModels for correctness and clarity

Human Decisions

Feature scoping

Architecture (MVVM)

Error handling strategies

Security & RLS validation

Performance considerations

AI was treated as a pair programmer, not a replacement.

## 🤖 AI Tools Used

This project was developed using **ChatGPT** as an AI pair-programming assistant.

ChatGPT was used to:
- Generate initial SwiftUI view and ViewModel scaffolding
- Draft Supabase queries and Row Level Security (RLS) policies
- Debug SwiftUI, PhotosPicker, async/await, and Supabase issues
- Refactor code for clarity and correctness
- Validate architectural decisions and edge cases

All final implementation decisions, security rules, and integrations were reviewed and owned by the developer.

## 🎨 Design Process

The UI and UX for QuoteVault were **designed directly in SwiftUI** without using external design tools.

Due to local system limitations, tools like Figma or Stitch were not used.  
Instead, the design process followed an **implementation-driven approach**:

- Layouts were iterated directly in SwiftUI previews
- System typography and spacing guidelines were followed
- Focus was placed on clarity, readability, and accessibility
- Components were kept modular and reusable

This approach ensured fast iteration while maintaining a clean and consistent design.
## ⚠️ Known Limitations & Incomplete Features

The following features were planned but not fully implemented due to time constraints:

- ❌ Home Screen Widget (not implemented)
- ❌ Offline caching (quotes require network access)
- ❌ Push notifications (only local notifications are supported)
- ❌ Some form validations and edge case handling are incomplete

These areas are clearly identified and would be the next focus for improvement in a production version.

