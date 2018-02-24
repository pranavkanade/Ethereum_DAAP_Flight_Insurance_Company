# Blog on FlightData contract

## Flow of the contract that is being used by the user

1. User account is added to the block chain.
2. This user needs to be the insurance company.
3. Create a master that adds the user and provides them initial tokens to start with.
4. Deploy a smart contract help of the account contralled in name of insurance company.
5. User will then, invoke the contract and put all the details for the flight that he is going to travel with.
6. User will then, ask for the insurance claim and hence, will get twice as much what he/she has paid.

## Contract should include

1. Contract will hold which users have called it.
2. List of users and user ids.
3. These users will be structs which hold the address and name and the flightid of the user.
4. Also make a list of the policies that contract has sold to the users.
5. This list will contain the structs which hold all the data required to guess all the params required to buy/sell the policy.
