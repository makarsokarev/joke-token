// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/IERC20Metadata.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

abstract contract JokeERC20 is Context, IERC20, IERC20Metadata {
    mapping(address => uint256) private _balances;
    mapping(address => mapping(address => uint256)) private _allowances;


    uint256 private _totalTokens;

    string private _name;
    string private _symbol;
    uint8 private _decimals;

    constructor(string memory name_, string memory symbol_) {
        _name = name_;
        _symbol = symbol_;
        _decimals = 18;
    }

    function name() external view override returns (string memory) {
        return _name;
    }

    function symbol() external view override returns (string memory) {
        return _symbol;
    }

    function decimals() external view override returns (uint8) {
        return _decimals;
    }
    
    function totalSupply() external view returns (uint256) {
        return _totalTokens;
    }

    function balanceOf(address account) external view returns (uint256) {
        return _balances[account];
    }

    function transfer(address to, uint256 value) external returns (bool) {
        _balances[_msgSender()] -= value;
        _balances[to] += value;
        emit Transfer(_msgSender(), to, value);
        return true;
    }

    function allowance(address _owner, address spender) external view returns (uint256) {
        return _allowances[_owner][spender];
    }

    function approve(address spender, uint256 value) external returns (bool) {
        _allowances[_msgSender()][spender] = value;
        emit Approval(_msgSender(), spender, value);
        return true;
    }

    function transferFrom(address from, address to, uint256 value) external returns (bool) {
        _allowances[from][to] -= value;

        _balances[from] -= value;
        _balances[to] += value;
        emit Transfer(from, to, value);
        return true;
    }

    function _mint(address account, uint256 value) internal virtual {
        _balances[account] += value;
        _totalTokens += value;
        emit Transfer(address(0), account, value);
    }

    function _burn(address _from, uint256 value) internal virtual {
        _balances[_from] -= value;
        _totalTokens -= value;
    }

}