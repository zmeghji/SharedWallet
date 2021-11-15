//SPDX-License-Identifier: MIT

pragma solidity ^0.8.9;

import "@openzeppelin/contracts/access/Ownable.sol";

contract SharedWallet is Ownable{

    function isOwner() view private returns (bool){
        return owner() == msg.sender;
    }
    mapping (address => uint) allowances;

    function changeAllowance(address addTo, uint amount ) public onlyOwner{
        allowances[addTo] = amount;
    }

    modifier ownerOrAllowed( uint amount){
        require( isOwner() || amount <= allowances[msg.sender], "You are trying to withdraw more than your current allowance");
        _;
    }

    function withdrawMoney(address payable to, uint amount) public ownerOrAllowed(amount){
        require(amount <= address(this).balance, "Not enough funds");
        to.transfer(amount);
    }

    receive() external payable {}
}