MatchMate is a simple appliction that fetches the profile from the api and the user is able to accept or decline the match. we have implemented this application using native iOS frameworks,
Frameworks that have been used are mentioned below:
1. For Networking we have implemented URLSessions
2. For UI  we have implemnted "SwiftUI"
3. For NetworkConnectivity we have implemeted "Network"
4. For offline support we have implmented CoreData 
5. The app has been created in MVVM Architecture Pattern

Challenges:
The core functionality was simple to fecth the profile but I faced a challenge to test the app in offline on simulator, sometimes it shows unexpected behaviour when i turn on/off my wifi
The iOS simulator doesn't always simulate Wi-Fi state changes perfectly. For example, turning off your Mac’s Wi-Fi or changing network settings might not behave the same way in the simulator as it would on a real device.
The Solution is to test on a physical iPhone or iPad. NWPathMonitor works consistently on real devices where it can properly monitor Wi-Fi, cellular, and other network states.



   
