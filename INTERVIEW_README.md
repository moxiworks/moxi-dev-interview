# Interview

## What we're looking for

- Clean Maintainable Code
- Useful tests

## E01 - Debug

- Run `d/rspec spec/requests/shifts_spec.rb`
- Without modifying the tests, fix the 3 Failed examples.

```
Failed examples:

rspec ./spec/requests/shifts_spec.rb:49 # ShiftsController POST /shifts with invalid params does not create a new shift
rspec ./spec/requests/shifts_spec.rb:55 # ShiftsController POST /shifts with invalid params returns a 422 response
rspec ./spec/requests/shifts_spec.rb:60 # ShiftsController POST /shifts with invalid params returns errors
```

## E02 - Implement Feature

A volunteer needs to be able to see what shifts are available, sign up for a shift, and view their schedule.

### Requirements
- Volunteers can sign up for multiple shifts.
- A Shift can have multiple volunteers.
- A Shift has a maximum number of sign ups.
- A Volunteer can not sign up for a shift that is already filled with the maximum number of sign ups.

### API Endpoints
- **Shifts Available:** 
    - Accept a `job_id` and list the Shifts available that have not reach their maximum volunteers.
    - Example:
        - GET `/jobs/1/available_shifts`
- **Volunteer Sign up:** 
    - Accept a `volunteer_id` and a `shift_id` then return whether the volunteer successfully signed up for the shift.
    - Example:
        - POST `/shifts/1/sign_ups`
        - PAYLOAD `{sign_up: {volunteer_id: 2}}`
- **Volunteer Schedule:** 
    - Accept a `volunteer_id` and an `event_id` and list the Shifts a Volunteer signed up for along with name of the Job for each Shift
    - Example:
        - GET `/volunteers/1/schedules?event_id=2`
