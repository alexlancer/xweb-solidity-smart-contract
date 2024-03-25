//SPDX-License-Identifier: MIT

pragma solidity 0.8.7; // solidity version

contract FallbackExample{
    uint256 public result;

    receive() external payable{
        result = 1;
    }
}