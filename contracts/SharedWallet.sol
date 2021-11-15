//SPDX-License-Identifier: MIT

pragma solidity ^0.8.9;

contract SharedWallet {

    address owner;

    constructor(){
        owner = msg.sender;
    }
    
    modifier onlyOwner(){
        require(msg.sender != owner, "You are not the owner");
        _;
    }
    function withdrawMoney(address payable _to, uint _amount) public onlyOwner{
        _to.transfer(_amount);
    }

    receive() external payable {

    }
}