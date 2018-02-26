pragma solidity ^0.4.16;

contract Payout {
    address public userSender;
    address public userReciever;
    
    function Payout() public{
        userSender=msg.sender;
    }

    function settleClaim(address _addr, uint _amount) public {
        userReciever = _addr;
        userReciever.transfer(_amount);
    }

}