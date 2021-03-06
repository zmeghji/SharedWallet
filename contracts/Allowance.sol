//SPDX-License-Identifier: MIT

pragma solidity ^0.8.9;

import "@openzeppelin/contracts/access/Ownable.sol";

contract Allowance is Ownable{

    event AllowanceChanged(address indexed forWho, address indexed byWhom, 
        uint oldAmount, uint newAmount);

    event MoneySent(address indexed receiver, uint amount);
    event MoneyReceived(address indexed sender, uint amount);

    function isOwner() view internal returns (bool){
        return owner() == msg.sender;
    }

    mapping (address => uint) allowances;

    function changeAllowance(address toChange, uint amount ) public onlyOwner{
        emit AllowanceChanged(toChange, msg.sender, allowances[toChange], amount);
        allowances[toChange] = amount;
    }

    function reduceAllowance(address toReduce, uint amount) internal {
        emit AllowanceChanged(toReduce, msg.sender, allowances[toReduce], allowances[toReduce]- amount);
        allowances[toReduce] -= amount;
    }

    modifier ownerOrAllowed( uint amount){
        require( isOwner() || amount <= allowances[msg.sender], "You are trying to withdraw more than your current allowance");
        _;
    }
}
