// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.28;
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
contract ERC20Token is ERC20 {
    uint256 public tokenPrice;
    address public creater;

    constructor(
        string memory name,
        string memory symbol,
        uint256 initialSupply,
        uint8 decimals,
        address creatorAddress,
        uint256 price 
    ) ERC20(name,symbol){
        tokenPrice = price;
        creater = creatorAddress;
         _setupDecimals(decimals);
        _mint(creatorAddress, initialSupply * (10 ** decimals));
    }
    function _setupDecimals(uint8 decimalPlaces) internal virtual {
        // Overriding default decimals with the user-defined value
        assembly {
            sstore(0x5c, decimalPlaces) // Storage location for _decimals in OpenZeppelin ERC20
        }
    }
}