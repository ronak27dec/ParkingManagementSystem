# Parking Lot Management System

## Overview
The Parking Lot Management System is a software solution designed to efficiently manage parking spaces in a parking lot. It provides a streamlined process for vehicle parking, allocation, and availability tracking. The system aims to optimize parking space utilization and enhance the overall parking experience.

## App Structure
Keeping in mind the scalability factor, the app follows Modularized approach. I envisioned the app to be a Whitelabel app. Client(ParkingLotApp) uses the ParkingCore framework.
ParkingCore framework contains all the necessary functionalities required for this app. The app is flexible enough to build on top of the ParkingCore framework.  ParkingCore is a reusable framework.
ParkingCore is fully testable with coverage of 95.5%. 
I covered all the necessary tests for view models in the ParkingLotApp.

Administrator has the ability to add the number of floors, small vehicle slots, medium vehicle slots, large vehicle slots and extra large slots per floors while onboarding. The algorithm will assign slots to each spaces in each floors.

## Features
### 1. Automated Parking Space Allocation
The system automatically allocates parking spaces based on the size of the vehicle(Small, Medium, Large and ExtraLarge).
 It intelligently assigns parking bays to small, medium, large, and extra-large vehicles, ensuring efficient space utilization.
 
### 2. User-friendly Interface
The system features an intuitive and user-friendly interface, making it easy for the administrators to navigate. Administrators can easily find available parking spaces and complete the parking process seamlessly.

### 4. Multi-floor Parking
Supports multi-floor parking structures, allowing administrators to find available spaces on different levels of the parking lot.

## Technology Stack
 **Frontend**: Swift v5.0
 
## Installation
To run the Parking Lot Management System, follow these steps:
1. Clone the repository: `git clone https://github.com/ronak27dec/ParkingManagementSystem.git`
2. Choose target as ParkingLotApp
3. Compile the app in Xcode 15

## Usage
1. Open the app. You will be presented with Signin and SignUp page.
2. Once successful, the app presents the Slot allocation and deallocation screen.
3. On allocation screen, choose the vehicle type - Small, Medium, Large or ExtraLarge and click on allocate button
4. For slot deallocation, enter your bay id and slot will be released for future allocation

## Assumptions
1. The app assumes that there is only four types of vehicles availble - Small, Medium, Large and ExtraLarge
2. The app assumes that the number of slots are equal per floor for per vehicle type.
3. The app assumes there is only one entry point to enter the parking space

## Future Improvements
1. Add core data support
2. Add error handling
