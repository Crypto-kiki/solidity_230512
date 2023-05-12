// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract note {

    address a;
    address payable owner;    // payable : 돈을 받을 수 있음

    function deposit() public payable {

    }
    
    function setOwner() public {
        owner = payable(msg.sender);
    }

    function getOwner() public view returns(address) {
        return owner;
    }

    function setA() public {
        a = msg.sender;
    }

    function getA() public view returns (address) {
        return a;
    }

    function transferTo(address payable _to, uint _amount) public {
        _to.transfer(_amount);  // 지갑주소.trasfer(규모)
    }

    function transferToOwner(uint _amount) public {
        owner.transfer(_amount);
    }

    function transferToA(uint _amount) public {
        // a.transfer(_amount);  // 에러발생함. send나 transfer를 사용하려면 address payable이여야 함.
    }

}