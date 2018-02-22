pragma solidity ^0.4.16;

// This is the owner of the contract
contract owned {
    address public owner;

    function owned() public {
        owner = msg.sender;
    }

    modifier onlyOwner {
        require(msg.sender == owner);
        _;
    }

    function transferOwnership (address newOwner) onlyOwner public{
        owner = newOwner;
    }
}

interface Token {
    function transferFrom(address _from, address _to, uint256 _value) public returns (bool success);
}

contract tokenRecipient {
    event receivedEther(address sender, uint amount);
    event receivedToken(address _from, uint256 _value, address _token, bytes _extraData);

    function receivedApproval(address _from, uint256 _value, address _token, bytes _extraData) public {
        Token t = Token(_token);
        require(t.transferFrom(_from, this, _value));
        receivedToken(_from, _value, _token, _extraData);
    }

    function () payable public {
        receivedEther(msg.sender, msg.value);
    }
}


contract FlightInsurance is owned, tokenRecipient {
    PolicyData[] public policiesTaken;
    Customer[] public policyHolders;

    mapping(address => uint) public customerId;
    
    // total number of policies taken by users.
    uint numPoliciesSold;

    event Insured(address customerAddress, uint insurenceId, uint premiumAmount, PolicyData policyTaken);
    event Claimed(address customerAddress, uint insurenceId);
    event BecameCustomer(address customerAddress, bool isCustomer);

    struct Customer {
        string name;
        address customer;
    }
    
    struct PolicyData {
        FlightData flightData;
        uint startDate;
        uint endDate;
        uint mimPayOut;
        uint premiumAmount;
        bool claimed;
        bool confirmed;
    }

    struct FlightData {
        string flightNumber;
        string source;
        string destination;
    }

    function FlightInsurance() payable public {
        // add 0th initial customer;
        addCustomer(0, "");
    }

    // Add a customer to the list of our customers
    function addCustomer(address customerAddress, string customerName) onlyOwner public {
        uint id = customerId[customerAddress];
        if (id == 0) {
            customerId[customerAddress] = policyHolders.length;
            id = policyHolders.length++;
        }

        policyHolders[id] = Customer({name: customerName, customer: customerAddress});
        BecameCustomer(customerAddress, true);
    }

    // Setting for flight delay 
    function FlightDelayInsurance() payable {
        // Set initial parameters
    }

    

}