// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract TokenFarm is Ownable {
    //stakingToken

    address[] public allowedTokens;

    function stakeTokens(uint256 _amount, address _token) public {
        require(_amount > 0, "Amount must be more than 0");
        require(tokenIsAllowed(_token), "Token is currently not allowed");

        IREC20(_token).tranferFrom(msg.sender, address(this), _amount);
    }

    function addAllowedTokens(address _token) public onlyOwner {
        allowedTokens.push(_token);
    }

    function tokenIsAllowed(address _token) public returns (bool) {
        for (
            uint256 allowedTokensindex = 0;
            allowedTokensindex < allowedTokens.length;
            allowedTokensindex++
        ) {
            if (allowedTokens[allowedTokensindex] == _token) {
                return true;
            }
        }
        return false;
    }
}
