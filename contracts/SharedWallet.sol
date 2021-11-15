//SPDX-License-Identifier: MIT

pragma solidity ^0.8.9;

import "./Allowance.sol";

contract SharedWallet is Allowance{

    function withdrawMoney(address payable to, uint amount) public ownerOrAllowed(amount){
        require(amount <= address(this).balance, "Not enough funds");
        if (!isOwner()){
            reduceAllowance(msg.sender, amount);
        }
        emit MoneySent(to, amount);
        to.transfer(amount);
    }

    receive() external payable {
        emit MoneyReceived(msg.sender, msg.value);
    }

    function renounceOwnership() public override view onlyOwner {
        revert("Renouncing ownership is not allowed");
    }
}