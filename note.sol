// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract note {
    /*
        실습가이드
        1. 1번 지갑 준비(주소 복붙) -> setOwner, 2번 지갑 준비(주소 복붙) -> setA
        2. deploy 후 1번 지갑으로 10eth -> deposit()
        3. contract 잔액 변화 확인
        4. 1번 지갑 넣고, 1000000000000000000 transferTo() -> 1번지갑, contract 잔액 변화 확인
        5. 2번 지갑, 1000000000000000000, transferTo() -> 2번 지갑, contract 잔액 변화 확인

        0x5B38Da6a701c568545dCfcB03FcB875f56beddC4
        0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2
    */
    /*
        참고.
        1. 가스비가 무한히 많이발생하게 할 수 있나?
        -> 없음. 디플로이 할 때 가스 리밋이 있음.
    */

    address payable owner;    // payable : 돈을 받을 수 있음
    address a;    // 상태변수에 payable없어도 함수 내에서 payable을 줘서 사용할 수도 있음.

    // 컨트렉트가 돈 받을 수 있음. 함수를 실행시켜서 함수에 돈을 보냄
    function deposit() public payable returns(uint){
        return msg.value;  // payable함수일 때만 가능함.
    } 
    // 왜 함수를 실행하면 컨트렉트에 돈이 들어가나? payable이 붙으면 돈을 받을 수 있는데 아래 코드 내용이 없음.
    // 하지만 deposit이라는 함수는 컨트렉트에 붙어있기 때문!

    receive() external payable{}    // 돈을 그냥 전송하는 거래를 일으켰는데 거래를 받는 사람이 스마트컨트렉트면 receive가 실행됨.
    // setA함수 실행해보고 from to 비교해보기. from은 나. to는 컨트렉트.
    fallback() external payable{}    // 함수를 실행하는 호출을받았는데 없는 함수다. 그러면 fallback이 실행됨. 디폴트값
    // 만약에 호출을 받았는데 컨트렉트에 돈을 보내는 호출이다. 그러면 자동으로 receive() 실행.
    
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

    function transferTo(address payable _to, uint _amount) public {  // 보내는 사람은 컨트렉트임.
        _to.transfer(_amount);  // 지갑주소.trasfer(규모)
    }

    function transferToOwner(uint _amount) public {
        owner.transfer(_amount);
    }

    // function transferToA(uint _amount) public {
    //     a.transfer(_amount);  // 에러발생함. send나 transfer를 사용하려면 address payable이여야 함.
    // }

}