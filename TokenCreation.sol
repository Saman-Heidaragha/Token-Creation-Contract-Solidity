// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract MyToken is ERC20 {
    // token properties
    function name() public pure override returns (string memory) {
    return "Saman";
    }

    function symbol() public pure override returns (string memory) {
    return "SM";
    }

    function decimals() public pure override returns (uint8) {
    return 18; 
    }   


    uint256 public constant TOTAL_SUPPLY = 10000000 * 10**18;
    
    // contract owner
    address public owner;

    // events
    event Mint(address indexed to, uint256 amount);
    event Burn(address indexed from, uint256 amount);


    constructor() ERC20("Saman", "SM") {
        owner = msg.sender;
        _mint(msg.sender, TOTAL_SUPPLY);
    }  



    // minting function (only owner)
    function mint(address recipient, uint256 amount) public onlyOwner {
        require(totalSupply() + amount <= TOTAL_SUPPLY, "Minting exceeds total supply");
        _mint(recipient, amount);
        emit Mint(recipient, amount);
    }

    // burning function
    function burn(uint256 amount) public {
        _burn(msg.sender, amount);
        emit Burn(msg.sender, amount);
    }

    // ownership transfer
    function transferOwnerShip(address newOwner) public onlyOwner {
        owner = newOwner;
    }

    // modifier to restrict functions to control owner
    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can perform this action");
        _;
    }
}