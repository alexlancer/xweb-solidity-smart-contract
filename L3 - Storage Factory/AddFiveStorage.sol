//SPDX-License-Identifier: MIT

pragma solidity 0.8.18; // solidity version

import {SimpleStorage} from  "/L2 - SimpleStorage/SimpleStorage.sol";

contract AddFiveStorage is SimpleStorage{
    // +5
    //overrides
    // virtual override

    function store(uint256 _newNumber) public override {
        myFavoriteNumber = _newNumber + 5;
    }
}