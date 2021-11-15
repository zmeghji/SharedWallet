//SPDX-License-Identifier: MIT

pragma solidity ^0.8.9;

import "@openzeppelin/contracts/access/Ownable.sol";

contract SharedWallet is Ownable{

    function withdrawMoney(address payable _to, uint _amount) public onlyOwner{
        _to.transfer(_amount);
    }

    receive() external payable {}
}