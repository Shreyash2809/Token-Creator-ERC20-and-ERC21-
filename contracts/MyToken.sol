// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.28;
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "./mytoken-1.sol";
contract TokenFactory {
    event TokenCreated(
        address indexed tokenAddress,
        string name,
        string symbol,
        uint256 initialSupply,
        uint8 decimals,
        uint256 price
    );

    function creteToken(
        string memory name,
        string memory symbol,
        uint256 initialSupply,
        uint8 decimals,
        uint256 price
    ) external {
        ERC20Token newToken = new ERC20Token(
            name,
            symbol,
            initialSupply,
            decimals,
            msg.sender,
            price
        );
        emit TokenCreated(
            address(newToken),
            name,
            symbol,
            initialSupply,
            decimals,
            price
        );
    }
}
