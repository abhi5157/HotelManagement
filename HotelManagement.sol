// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;
contract Hotel{
    
    enum Status {vacant,occupied}
    address payable public owner;
    Status currentStatus;

    event Occupy(address occpant, uint price);


    constructor()public payable  {
       address owner = msg.sender;
        currentStatus = Status.vacant;
    }

// check availability
modifier onlyWhileWaiting(){
 require(currentStatus == Status.vacant, "Currently occupied");
      _;
    }

 // check price
modifier Costs(uint amount){
require(msg.value >= amount, "not enough price");
  _;
    }
    receive() external payable onlyWhileWaiting  Costs(2 ether)   {    
     owner.transfer(msg.value);

     emit Occupy(msg.sender, msg.value);
    }
}
