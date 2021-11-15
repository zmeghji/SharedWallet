//SPDX-License-Identifier: MIT

pragma solidity ^0.8.9;

contract SharedWallet {

    function withdrawMoney(address payable _to, uint _amount) public {
        _to.transfer(_amount);
    }

    receive() external payable {

    }
}