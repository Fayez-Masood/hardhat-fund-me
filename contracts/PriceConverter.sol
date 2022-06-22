// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

library PriceConverter {
    function getPrice(AggregatorV3Interface priceFeed)
        internal
        view
        returns (uint256)
    {
        // ABI of the contract
        //address of the contract 	0x8A753747A1Fa494EC906cE90E9f37563A8AF630e

        (, int256 price, , , ) = priceFeed.latestRoundData();
        // RTH in term of USD
        //3000.00000000
        return uint256(price * 10000000000); //1**10 == 10000000000
    }

    function getConversionRate(
        uint256 ethAmount,
        AggregatorV3Interface priceFeed
    ) internal view returns (uint256) {
        uint256 ethPrice = getPrice(priceFeed);
        //3000_000000000000000000 = ETH /USD price
        //1_000000000000000000
        uint256 ethAmountInUsd = (ethPrice * ethAmount) / 1e18;
        return ethAmountInUsd;
    }
}
