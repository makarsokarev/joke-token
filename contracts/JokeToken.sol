// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./JokeERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract JokeToken is JokeERC20, Ownable  {
    constructor(address initialOwner) JokeERC20("JokeToken", "JOKE") Ownable(initialOwner) { }

    function mint(address account, uint256 value) public onlyOwner {
        _mint(account, value);
    }

    function burn(address _from, uint256 value) public onlyOwner {
        _burn(_from, value);
    }
}