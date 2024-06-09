Objective’s -


Hotel List View :    Achieved (100%) ✅

Hotel Details View:     Achieved (100%) ✅

Search Functionality:     Achieved (100%) ✅

User Authentication:     Achieved (100%) ✅

Data Persistence:     Achieved (100%) ✅

Error Handling and Validation:     Achieved (100%) ✅

Bonus Points (Optional):

Allow users to filter hotels based on amenities :  Achieved (100%) ✅

Add a review and rating system for hotels.  Achieved (50%)



How to use App -

1- Sign Up  via ( Name , Email , Password )
You need to Sign up first
Validations
Email - Email Validation , cannot be empty
Password - Minimum 4 digit , cannot be empty
Name - Cannot be empty

Error Pop Up shown With Proper message

2- Login via  (Email , Password )
You can only login if you are already a registered user
Validations -
Email - Email Validation , cannot be empty , email not found
Password - Minimum 4 digit , cannot be empty , does not match

3-  Hotel View and Description
You can see basic details like  name, location, price, star rating and in Description you can see details like hotel, including images, amenities, room types.
A Book button to create booking with us

4-  Search Functionality via Location
You can search Hotels based on location like ( Los Angeles , New York)

5- Filter via ( Price , Amenities)
You can apply Price Filter to search Hotel based on pricing example -(In dollars - 100 to 150)
You can apply amenities filter  (e.g., Wi-Fi, swimming pool, gym)

6- Profile View
Basic Information can be seen like (Name ,Email)

7- My Bookings
You can see all the bookings you have done initially you will be see (No Booking Found)
Only Bookings created with that user will be seen
Bookings Validation not need because all validations are done in Login flow

8- Logout Button
To Logout from your particular account.

9- Ratings and Review
You can view all the ratings and review
You can not rate your booked hotel because -
As Local Storage is used for building this app, Flutter does not allow you to write Json files due to security reasons .
If Local Storage is used then Hotel data will be lost and there will be no hotel to view . Hotel data will be in my Device . That’s why JSON is used for hotel data and Local Storage used for User storage .

10- App State
If user is logged in and if he quits the app and then reopen app he will directly allowed inside the app
If user log out’s and then he quits the app and then reopen app he will not allowed to do inside the app he will be redirected to Login 



