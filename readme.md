# Project Overview

A Ruby based order now pay later service on command line

## Requirements

A platform that allows users and merchants to transact together with the following funtionalities.

- Allow merchants to be onboarded with the amount of discounts they offer
- Allow merchants to change the discount they offer
- Allow users to be onboarded (name, email-id and credit-limit)
- Allow a user to carry out a transaction of some amount with a merchant.
- Allow a user to pay back their dues (full or partial)
- Reporting:
	- how much discount we received from a merchant till date
 	- dues for a user so far
	- which users have reached their credit limit
	- total dues from all users together

## Commands
To create a new user - 
`new user u1 u1@email.in 1000`

To create a new -
`new merchant m1 m1@merchants.com 0.5%`

To create a new transaction - 
`new txn u1 m2 400`

To update the discount offered by a merchant - 
`update merchant m1 1%`

User pays back his dues - 
`payback u1 300`

Total discount offered by a merchant - 
`report discount m1`

Total Pending dues for user u1 -
`report dues u1`

All users who are at credit-limit - 
`report users-at-credit-limit`

All user's dues -
`report total-dues`

## Solution

The project worked on ruby which work on Entities like User, Merchants & Transactions. Certain actions can be performed on each entities like creation, updation or reporting. All the data is stored in a local database.

## Getting Started

1. `ruby set-commands.rb` To set the commands into the /.bash_profile. 
2. `source ~/.bash_profile` To load the updated bash_profile.
2. `ruby tests/AllTests.rb` Launches the tests.