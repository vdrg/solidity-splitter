pragma solidity ^0.4.13;

contract Splitter {

  mapping (address => uint) public balances;
  mapping (address => address[]) public splitters;

  function setSpliters(address[] _splitters) {
    require(_splitters.length > 0);
    splitters[msg.sender] = _splitters;
  }

  function deposit() payable {
    uint splittersLength = splitters[msg.sender].length; 

    require(msg.value > 0 && splittersLength > 0);

    for (uint i = 0; i < splittersLength; i++) {
      // TODO: figure out what to do with the remaining ether.
      balances[splitters[msg.sender][i]] += msg.value / splittersLength;
    }
  }

  function withdraw() {
    uint balance = balances[msg.sender];
    require(balance > 0);

    msg.sender.transfer(balance);
  }
}
