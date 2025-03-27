// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract PlayerToken {
    string public name = "Player Token";
    string public symbol = "STAT";
    uint8 public decimals = 18;
    uint256 public totalSupply;
    address public oracle;

    mapping(address => uint256) public balanceOf;

    event Burn(address indexed burner, uint256 amount);

    constructor(uint256 _initialSupply, address _oracle) {
        totalSupply = _initialSupply;
        balanceOf[msg.sender] = _initialSupply;
        oracle = _oracle;
    }

    function burn(uint256 _amount) external {
        require(msg.sender == oracle, "Not authorized");
        require(balanceOf[address(this)] >= _amount, "Insufficient tokens");
        balanceOf[address(this)] -= _amount;
        totalSupply -= _amount;
        emit Burn(msg.sender, _amount);
    }
}