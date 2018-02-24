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
        string customerName;
        address customerAddress;
    }
    
    struct PolicyData {
        FlightData flightData;
        uint startDate;
        uint endDate;
        uint minPayOut;
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
        // add 0th (initial) customer;
        addCustomer(0, "");
    }

    // Add a customer to the list of our customers
    function addCustomer(address customerAddress, string customerName) onlyOwner public {
        uint id = customerId[customerAddress];
        if (id == 0) {
            customerId[customerAddress] = policyHolders.length;
            id = policyHolders.length++;
        }

        policyHolders[id] = Customer({customerName: customerName, customerAddress: customerAddress});
        BecameCustomer(customerAddress, true);
    }

    // add a function to give the entry point to insure the customer.
    function insure(
        Customer customerInsuring,
        uint policyKey,
        uint premiumAmount,
        FlightData fdata           // this will hold the temp information on the flight for which the insurance is taken
    ) onlyOwner internal {
        PolicyData storage insuredOnPolicy = defaultPolicyData(1);
        insuredOnPolicy.flightData = fdata;

        // Need to find the ID of for the policy being taken

    }

    // Function to set all the default data of the PolicyData struct
    function defaultPolicyData(uint policyType) returns (PolicyData) {
        PolicyData storage defaultPd;
        
        defaultPd.startDate = 0;
        defaultPd.endDate = 20;
        // this will be different for different types 
        if (policyType == 1){
            defaultPd.minPayOut = 4000;
        }
        else {
            defaultPd.minPayOut = 2000;
        }
        defaultPd.premiumAmount = 1000;
        defaultPd.claimed = false;
        defaultPd.confirmed = false;
        return defaultPd;
    }

    // Function for the public interface which any registerd user will be able to call from the blockchain
    // assume that there is only one flight and user is putting all the correct date values.
    function FlightDelayInsurance(string name, uint policyType) payable public {
        // policyType could be various version of the same policy dith different payouts
        uint policyKey = 123;
        uint premiumAmountPaid = 1000;

        // flight information
        FlightData storage fd;
        fd.flightNumber = "1"; 
        fd.source = "";
        fd.destination = "";
        
        // customer information
        Customer storage cInsuring;
        cInsuring.customerAddress = msg.sender;
        cInsuring.customerName = name;

        insure(cInsuring, policyKey, premiumAmountPaid, fd);
    }
}