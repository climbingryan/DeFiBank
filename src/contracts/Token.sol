// SPDX-License-Identifier: MIT
pragma solidity >=0.6.0 <0.8.5;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract Token is ERC20 {
  //add minter variable
  address public minter;
  //add minter changed event, logs every time a minter has changed (can push to front-end)
  event MinterChanged(address indexed from, address to);
    
  constructor() public payable ERC20("Decentralized Bank Currency", "DBC") {
                      // ^ how we send funds
    //asign initial minter
    minter = msg.sender;
  }

  //Add pass minter role function
  function passMinterRole(address dBank) public returns (bool) {
    require(msg.sender==minter, "Error, only owner can change pass minter role");
    minter = dBank;

    emit MinterChanged(msg.sender, dBank);
    return true;
  }

  function mint(address account, uint256 amount) public {
    //check if msg.sender have minter role
    require(msg.sender == minter, "Error, msg.sender does not have minter role");
		_mint(account, amount);
  // ^ creates tokens
	}
}