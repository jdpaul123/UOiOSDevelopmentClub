# UOiOSDevelopmentClub

iOS Application that is used as an information hub for University of Oregon iOS Development Club members. 
Members can find links to club related websites, events information such as date and location, and information on executive members and advisors including how to contact them. 
There are also admin capabilities through and authentication and authorization service. 
An approved admin can add, delete, and edit events and members/advisors entities.

Features:
- Authenticaiton using Firestore Auth
    - Account setup
    - Account sign in
    - Acount sign out
    - Authorization checks using Cloud Kit to authorize account emails
- Editing capabilities for member and event entities in app for authorized admin users
- Viewing of member and event entities for all users
- Core data stored data that is fetched from a Cloud Kit store
- Firebase Authentication services

Tecnologies used:
- Swift language
- UIKit
- SwiftUI
- Storyboards
- Core Data with public Cloud Kit
- Firebase for storing memebr data
- Firebase Auth
