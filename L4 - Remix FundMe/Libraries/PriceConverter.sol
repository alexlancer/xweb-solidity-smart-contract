//SPDX-License-Identifier: MIT

pragma solidity 0.8.24; // solidity version

import {AggregatorV3Interface} from "@chainlink/contracts@0.8.0/src/v0.8/interfaces/AggregatorV3Interface.sol";

library PriceConverter {
     function getPrice() internal view returns(uint256) {
        //Address 0x694AA1769357215DE4FAC081bf1f309aDC325306
        //ABI
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
        (, int256 answer,,,)  = priceFeed.latestRoundData();
        // price of ETH in terms of USD
        return uint256(answer * 1e10);
    }
    function getConversionRate(uint256 ethAmount) internal view returns(uint256) {
        uint256 ethPrice = getPrice();
        uint256 ethAmountInUsd = (ethPrice * ethAmount) / 1e18;
        return ethAmountInUsd;
    }
}