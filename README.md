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
